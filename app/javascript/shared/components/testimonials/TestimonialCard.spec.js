import { mount } from '@vue/test-utils';
import TestimonialCard from './TestimonialCard.vue';

// Mock do composable useDarkMode
jest.mock('widget/composables/useDarkMode', () => ({
  useDarkMode: () => ({
    getThemeClass: (lightClass, darkClass) => lightClass,
  }),
}));

describe('TestimonialCard', () => {
  const mockTestimonial = {
    id: 1,
    name: 'João Silva',
    position: 'CEO',
    company: 'TechCorp',
    text: 'Excelente plataforma de atendimento!',
    highlightPhrase: 'Excelente',
    avatar: '/images/testimonials/joao.jpg',
    companyLogo: '/images/testimonials/techcorp.png',
    rating: 5,
  };

  let wrapper;

  beforeEach(() => {
    wrapper = mount(TestimonialCard, {
      props: {
        testimonial: mockTestimonial,
      },
    });
  });

  afterEach(() => {
    wrapper.unmount();
  });

  describe('Renderização básica', () => {
    it('deve renderizar o componente corretamente', () => {
      expect(wrapper.exists()).toBe(true);
      expect(wrapper.classes()).toContain('testimonial-card');
    });

    it('deve exibir o nome do cliente', () => {
      const authorName = wrapper.find('.author-name');
      expect(authorName.text()).toBe('João Silva');
    });

    it('deve exibir o texto do depoimento', () => {
      const textContent = wrapper.find('.text-content');
      expect(textContent.text()).toContain('Excelente plataforma de atendimento!');
    });

    it('deve exibir a posição do cliente', () => {
      const position = wrapper.find('.author-position');
      expect(position.text()).toBe('CEO');
    });

    it('deve exibir o nome da empresa', () => {
      const company = wrapper.find('.company-name');
      expect(company.text()).toBe('TechCorp');
    });
  });

  describe('Imagens', () => {
    it('deve exibir o avatar do cliente', () => {
      const avatar = wrapper.find('.avatar-image');
      expect(avatar.attributes('src')).toBe('/images/testimonials/joao.jpg');
      expect(avatar.attributes('alt')).toBe('Foto de João Silva');
    });

    it('deve exibir o logo da empresa', () => {
      const logo = wrapper.find('.company-logo');
      expect(logo.attributes('src')).toBe('/images/testimonials/techcorp.png');
      expect(logo.attributes('alt')).toBe('Logo da TechCorp');
    });

    it('deve usar avatar padrão quando não fornecido', () => {
      const testimonialWithoutAvatar = { ...mockTestimonial, avatar: null };
      wrapper = mount(TestimonialCard, {
        props: { testimonial: testimonialWithoutAvatar },
      });

      expect(wrapper.vm.avatarUrl).toBe('/images/testimonials/default-avatar.png');
    });
  });

  describe('Destaque de frases', () => {
    it('deve destacar a frase especificada', () => {
      const textContent = wrapper.find('.text-content');
      expect(textContent.html()).toContain('<mark class="highlight">Excelente</mark>');
    });

    it('deve exibir texto normal quando não há frase para destacar', () => {
      const testimonialWithoutHighlight = { ...mockTestimonial, highlightPhrase: null };
      wrapper = mount(TestimonialCard, {
        props: { testimonial: testimonialWithoutHighlight },
      });

      const textContent = wrapper.find('.text-content');
      expect(textContent.html()).not.toContain('<mark');
      expect(textContent.text()).toBe('Excelente plataforma de atendimento!');
    });
  });

  describe('Avaliação por estrelas', () => {
    it('deve exibir as estrelas de avaliação', () => {
      const rating = wrapper.find('.rating');
      expect(rating.exists()).toBe(true);

      const stars = wrapper.findAll('.star');
      expect(stars).toHaveLength(5);

      // Verifica se todas as 5 estrelas estão preenchidas
      const filledStars = wrapper.findAll('.star.filled');
      expect(filledStars).toHaveLength(5);
    });

    it('deve exibir avaliação parcial corretamente', () => {
      const testimonialWith3Stars = { ...mockTestimonial, rating: 3 };
      wrapper = mount(TestimonialCard, {
        props: { testimonial: testimonialWith3Stars },
      });

      const filledStars = wrapper.findAll('.star.filled');
      const emptyStars = wrapper.findAll('.star.empty');
      
      expect(filledStars).toHaveLength(3);
      expect(emptyStars).toHaveLength(2);
    });

    it('não deve exibir estrelas quando rating não fornecido', () => {
      const testimonialWithoutRating = { ...mockTestimonial, rating: null };
      wrapper = mount(TestimonialCard, {
        props: { testimonial: testimonialWithoutRating },
      });

      const rating = wrapper.find('.rating');
      expect(rating.exists()).toBe(false);
    });
  });

  describe('Acessibilidade', () => {
    it('deve ter atributos ARIA apropriados', () => {
      expect(wrapper.attributes('role')).toBe('article');
      expect(wrapper.attributes('aria-label')).toBe('Depoimento de João Silva');
    });

    it('deve ter alt text apropriado para imagens', () => {
      const avatar = wrapper.find('.avatar-image');
      const logo = wrapper.find('.company-logo');

      expect(avatar.attributes('alt')).toBe('Foto de João Silva');
      expect(logo.attributes('alt')).toBe('Logo da TechCorp');
    });

    it('deve ter aria-label para avaliação', () => {
      const rating = wrapper.find('.rating');
      expect(rating.attributes('aria-label')).toBe('Avaliação: 5 de 5 estrelas');
    });

    it('deve ter loading lazy para imagens', () => {
      const avatar = wrapper.find('.avatar-image');
      const logo = wrapper.find('.company-logo');

      expect(avatar.attributes('loading')).toBe('lazy');
      expect(logo.attributes('loading')).toBe('lazy');
    });
  });

  describe('Campos opcionais', () => {
    it('deve funcionar sem posição', () => {
      const testimonialWithoutPosition = { ...mockTestimonial, position: null };
      wrapper = mount(TestimonialCard, {
        props: { testimonial: testimonialWithoutPosition },
      });

      const position = wrapper.find('.author-position');
      expect(position.exists()).toBe(false);
    });

    it('deve funcionar sem empresa', () => {
      const testimonialWithoutCompany = { ...mockTestimonial, company: null };
      wrapper = mount(TestimonialCard, {
        props: { testimonial: testimonialWithoutCompany },
      });

      const companyInfo = wrapper.find('.company-info');
      expect(companyInfo.exists()).toBe(false);
    });

    it('deve funcionar sem logo da empresa', () => {
      const testimonialWithoutLogo = { ...mockTestimonial, companyLogo: null };
      wrapper = mount(TestimonialCard, {
        props: { testimonial: testimonialWithoutLogo },
      });

      const logo = wrapper.find('.company-logo');
      expect(logo.exists()).toBe(false);
    });
  });

  describe('Validação de props', () => {
    it('deve validar prop testimonial corretamente', () => {
      const validator = TestimonialCard.props.testimonial.validator;

      // Objeto válido
      expect(validator(mockTestimonial)).toBe(true);

      // Objeto inválido - sem name
      expect(validator({ text: 'Teste' })).toBe(false);

      // Objeto inválido - sem text
      expect(validator({ name: 'Teste' })).toBe(false);

      // Objeto inválido - null
      expect(validator(null)).toBe(false);
    });
  });

  describe('Tratamento de erros', () => {
    it('deve lidar com erro de carregamento do avatar', async () => {
      const avatar = wrapper.find('.avatar-image');
      
      // Simula erro de carregamento
      await avatar.trigger('error');
      
      expect(avatar.element.src).toBe('http://localhost/images/testimonials/default-avatar.png');
    });

    it('deve esconder logo da empresa em caso de erro', async () => {
      const logo = wrapper.find('.company-logo');
      
      // Simula erro de carregamento
      await logo.trigger('error');
      
      expect(logo.element.style.display).toBe('none');
    });
  });
});

