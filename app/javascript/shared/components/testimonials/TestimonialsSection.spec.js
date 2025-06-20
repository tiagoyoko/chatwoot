import { mount } from '@vue/test-utils';
import TestimonialsSection from './TestimonialsSection.vue';
import TestimonialCard from './TestimonialCard.vue';

// Mock do composable useDarkMode
jest.mock('widget/composables/useDarkMode', () => ({
  useDarkMode: () => ({
    getThemeClass: (lightClass, darkClass) => lightClass,
  }),
}));

// Mock do window.innerWidth para testes responsivos
Object.defineProperty(window, 'innerWidth', {
  writable: true,
  configurable: true,
  value: 1024,
});

describe('TestimonialsSection', () => {
  const mockTestimonials = [
    {
      id: 1,
      name: 'João Silva',
      text: 'Excelente plataforma!',
    },
    {
      id: 2,
      name: 'Maria Santos',
      text: 'Muito bom atendimento!',
    },
    {
      id: 3,
      name: 'Pedro Costa',
      text: 'Recomendo para todos!',
    },
    {
      id: 4,
      name: 'Ana Lima',
      text: 'Transformou nosso negócio!',
    },
  ];

  let wrapper;

  beforeEach(() => {
    jest.useFakeTimers();
    wrapper = mount(TestimonialsSection, {
      props: {
        testimonials: mockTestimonials,
        autoplay: false, // Desabilita autoplay para testes
      },
    });
  });

  afterEach(() => {
    wrapper.unmount();
    jest.useRealTimers();
  });

  describe('Renderização básica', () => {
    it('deve renderizar o componente corretamente', () => {
      expect(wrapper.exists()).toBe(true);
      expect(wrapper.classes()).toContain('testimonials-section');
    });

    it('deve exibir o título padrão', () => {
      const title = wrapper.find('.section-title');
      expect(title.text()).toBe('O que nossos clientes dizem');
    });

    it('deve exibir título personalizado', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          title: 'Depoimentos Personalizados',
          testimonials: mockTestimonials,
        },
      });

      const title = wrapper.find('.section-title');
      expect(title.text()).toBe('Depoimentos Personalizados');
    });

    it('deve exibir subtítulo quando fornecido', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          subtitle: 'Veja o que nossos clientes falam',
          testimonials: mockTestimonials,
        },
      });

      const subtitle = wrapper.find('.section-subtitle');
      expect(subtitle.text()).toBe('Veja o que nossos clientes falam');
    });
  });

  describe('Exibição de depoimentos', () => {
    it('deve renderizar os componentes TestimonialCard', () => {
      const cards = wrapper.findAllComponents(TestimonialCard);
      expect(cards.length).toBeGreaterThan(0);
    });

    it('deve exibir 3 depoimentos no desktop por padrão', () => {
      window.innerWidth = 1024;
      wrapper = mount(TestimonialsSection, {
        props: { testimonials: mockTestimonials },
      });

      expect(wrapper.vm.getItemsPerSlide()).toBe(3);
    });

    it('deve exibir 2 depoimentos no tablet', () => {
      window.innerWidth = 800;
      wrapper = mount(TestimonialsSection, {
        props: { testimonials: mockTestimonials },
      });

      expect(wrapper.vm.getItemsPerSlide()).toBe(2);
    });

    it('deve exibir 1 depoimento no mobile', () => {
      window.innerWidth = 600;
      wrapper = mount(TestimonialsSection, {
        props: { testimonials: mockTestimonials },
      });

      expect(wrapper.vm.getItemsPerSlide()).toBe(1);
    });
  });

  describe('Navegação', () => {
    beforeEach(() => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          autoplay: false,
          showNavigation: true,
        },
      });
    });

    it('deve exibir botões de navegação quando habilitado', () => {
      const prevButton = wrapper.find('.nav-prev');
      const nextButton = wrapper.find('.nav-next');

      expect(nextButton.exists()).toBe(true);
      // Botão anterior só aparece quando não está no primeiro slide
    });

    it('deve navegar para o próximo slide', async () => {
      const initialSlide = wrapper.vm.currentSlide;
      const nextButton = wrapper.find('.nav-next');

      await nextButton.trigger('click');
      
      expect(wrapper.vm.currentSlide).toBe(initialSlide + 1);
    });

    it('deve navegar para o slide anterior', async () => {
      // Primeiro vai para o segundo slide
      wrapper.vm.currentSlide = 1;
      await wrapper.vm.$nextTick();

      const prevButton = wrapper.find('.nav-prev');
      await prevButton.trigger('click');

      expect(wrapper.vm.currentSlide).toBe(0);
    });

    it('deve desabilitar navegação durante transição', async () => {
      wrapper.vm.isTransitioning = true;
      await wrapper.vm.$nextTick();

      const nextButton = wrapper.find('.nav-next');
      expect(nextButton.attributes('disabled')).toBeDefined();
    });

    it('não deve exibir navegação quando desabilitada', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          showNavigation: false,
        },
      });

      const prevButton = wrapper.find('.nav-prev');
      const nextButton = wrapper.find('.nav-next');

      expect(prevButton.exists()).toBe(false);
      expect(nextButton.exists()).toBe(false);
    });
  });

  describe('Paginação', () => {
    beforeEach(() => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          showPagination: true,
        },
      });
    });

    it('deve exibir pontos de paginação', () => {
      const pagination = wrapper.find('.pagination');
      expect(pagination.exists()).toBe(true);

      const dots = wrapper.findAll('.pagination-dot');
      expect(dots.length).toBe(wrapper.vm.totalSlides);
    });

    it('deve marcar o slide atual como ativo', () => {
      const activeDot = wrapper.find('.pagination-dot.active');
      expect(activeDot.exists()).toBe(true);
    });

    it('deve navegar ao clicar em um ponto', async () => {
      const dots = wrapper.findAll('.pagination-dot');
      if (dots.length > 1) {
        await dots[1].trigger('click');
        expect(wrapper.vm.currentSlide).toBe(1);
      }
    });

    it('não deve exibir paginação quando desabilitada', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          showPagination: false,
        },
      });

      const pagination = wrapper.find('.pagination');
      expect(pagination.exists()).toBe(false);
    });
  });

  describe('Autoplay', () => {
    it('deve iniciar autoplay quando habilitado', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          autoplay: true,
          autoplayInterval: 1000,
        },
      });

      expect(wrapper.vm.autoplayTimer).toBeTruthy();
    });

    it('deve parar autoplay quando desabilitado', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          autoplay: false,
        },
      });

      expect(wrapper.vm.autoplayTimer).toBeNull();
    });

    it('deve resetar autoplay após interação', async () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          autoplay: true,
        },
      });

      const spy = jest.spyOn(wrapper.vm, 'resetAutoplay');
      const nextButton = wrapper.find('.nav-next');
      
      await nextButton.trigger('click');
      
      expect(spy).toHaveBeenCalled();
    });
  });

  describe('Navegação por teclado', () => {
    beforeEach(() => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          autoplay: false,
        },
      });
    });

    it('deve navegar com seta direita', async () => {
      const carousel = wrapper.find('.testimonials-carousel');
      const initialSlide = wrapper.vm.currentSlide;

      await carousel.trigger('keydown', { key: 'ArrowRight' });
      
      expect(wrapper.vm.currentSlide).toBe(initialSlide + 1);
    });

    it('deve navegar com seta esquerda', async () => {
      wrapper.vm.currentSlide = 1;
      await wrapper.vm.$nextTick();

      const carousel = wrapper.find('.testimonials-carousel');
      await carousel.trigger('keydown', { key: 'ArrowLeft' });
      
      expect(wrapper.vm.currentSlide).toBe(0);
    });

    it('deve ir para o primeiro slide com Home', async () => {
      wrapper.vm.currentSlide = 1;
      await wrapper.vm.$nextTick();

      const carousel = wrapper.find('.testimonials-carousel');
      await carousel.trigger('keydown', { key: 'Home' });
      
      expect(wrapper.vm.currentSlide).toBe(0);
    });

    it('deve ir para o último slide com End', async () => {
      const carousel = wrapper.find('.testimonials-carousel');
      await carousel.trigger('keydown', { key: 'End' });
      
      expect(wrapper.vm.currentSlide).toBe(wrapper.vm.totalSlides - 1);
    });
  });

  describe('Touch/Swipe', () => {
    beforeEach(() => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          autoplay: false,
        },
      });
    });

    it('deve detectar swipe para a direita', async () => {
      const carousel = wrapper.find('.testimonials-carousel');
      const initialSlide = wrapper.vm.currentSlide;

      // Simula swipe da esquerda para direita (próximo slide)
      await carousel.trigger('touchstart', {
        touches: [{ clientX: 100 }],
      });
      await carousel.trigger('touchend', {
        changedTouches: [{ clientX: 200 }],
      });

      expect(wrapper.vm.currentSlide).toBe(initialSlide + 1);
    });

    it('deve detectar swipe para a esquerda', async () => {
      wrapper.vm.currentSlide = 1;
      await wrapper.vm.$nextTick();

      const carousel = wrapper.find('.testimonials-carousel');

      // Simula swipe da direita para esquerda (slide anterior)
      await carousel.trigger('touchstart', {
        touches: [{ clientX: 200 }],
      });
      await carousel.trigger('touchend', {
        changedTouches: [{ clientX: 100 }],
      });

      expect(wrapper.vm.currentSlide).toBe(0);
    });

    it('não deve navegar com swipe muito pequeno', async () => {
      const carousel = wrapper.find('.testimonials-carousel');
      const initialSlide = wrapper.vm.currentSlide;

      // Simula swipe pequeno (menor que threshold)
      await carousel.trigger('touchstart', {
        touches: [{ clientX: 100 }],
      });
      await carousel.trigger('touchend', {
        changedTouches: [{ clientX: 120 }],
      });

      expect(wrapper.vm.currentSlide).toBe(initialSlide);
    });
  });

  describe('Acessibilidade', () => {
    it('deve ter atributos ARIA apropriados', () => {
      const carousel = wrapper.find('.testimonials-carousel');
      
      expect(carousel.attributes('role')).toBe('region');
      expect(carousel.attributes('aria-label')).toBe('Carrossel de depoimentos');
      expect(carousel.attributes('aria-live')).toBe('polite');
      expect(carousel.attributes('tabindex')).toBe('0');
    });

    it('deve ter labels apropriados nos botões', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          showNavigation: true,
        },
      });

      const nextButton = wrapper.find('.nav-next');
      expect(nextButton.attributes('aria-label')).toBe('Próximo depoimento');
    });

    it('deve ter atributos apropriados na paginação', () => {
      const pagination = wrapper.find('.pagination');
      expect(pagination.attributes('role')).toBe('tablist');
      expect(pagination.attributes('aria-label')).toBe('Navegação de depoimentos');

      const dots = wrapper.findAll('.pagination-dot');
      if (dots.length > 0) {
        expect(dots[0].attributes('role')).toBe('tab');
        expect(dots[0].attributes('aria-selected')).toBe('true');
      }
    });
  });

  describe('Responsividade', () => {
    it('deve recalcular slides ao redimensionar janela', async () => {
      const spy = jest.spyOn(wrapper.vm, 'handleResize');
      
      window.dispatchEvent(new Event('resize'));
      
      expect(spy).toHaveBeenCalled();
    });

    it('deve ajustar slide atual se exceder total após resize', () => {
      wrapper.vm.currentSlide = 2;
      
      // Simula mudança que resulta em menos slides
      window.innerWidth = 400;
      wrapper.vm.handleResize();
      
      expect(wrapper.vm.currentSlide).toBeLessThan(wrapper.vm.totalSlides);
    });
  });

  describe('Cleanup', () => {
    it('deve limpar timers ao desmontar', () => {
      wrapper = mount(TestimonialsSection, {
        props: {
          testimonials: mockTestimonials,
          autoplay: true,
        },
      });

      const spy = jest.spyOn(wrapper.vm, 'stopAutoplay');
      wrapper.unmount();
      
      expect(spy).toHaveBeenCalled();
    });

    it('deve remover event listeners ao desmontar', () => {
      const spy = jest.spyOn(window, 'removeEventListener');
      wrapper.unmount();
      
      expect(spy).toHaveBeenCalledWith('resize', expect.any(Function));
    });
  });
});

