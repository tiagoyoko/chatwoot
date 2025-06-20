<script>
import TestimonialCard from './TestimonialCard.vue';
import { useDarkMode } from 'widget/composables/useDarkMode';

export default {
  name: 'TestimonialsSection',
  components: {
    TestimonialCard,
  },
  props: {
    title: {
      type: String,
      default: 'O que nossos clientes dizem',
    },
    subtitle: {
      type: String,
      default: 'Depoimentos reais de empresas que transformaram seu atendimento',
    },
    testimonials: {
      type: Array,
      default: () => [
        {
          id: 1,
          name: 'Maria Silva',
          position: 'Gerente de Atendimento',
          company: 'TechCorp',
          text: 'O Chatwoot revolucionou nosso atendimento ao cliente. Conseguimos reduzir o tempo de resposta em 70% e aumentar significativamente a satisfação dos nossos clientes.',
          highlightPhrase: 'reduzir o tempo de resposta em 70%',
          avatar: '/images/testimonials/maria-silva.jpg',
          companyLogo: '/images/testimonials/techcorp-logo.png',
          rating: 5,
        },
        {
          id: 2,
          name: 'João Santos',
          position: 'CEO',
          company: 'StartupXYZ',
          text: 'Implementamos o Chatwoot e em apenas 3 meses vimos um aumento de 150% na conversão de leads. A plataforma é intuitiva e poderosa.',
          highlightPhrase: 'aumento de 150% na conversão',
          avatar: '/images/testimonials/joao-santos.jpg',
          companyLogo: '/images/testimonials/startupxyz-logo.png',
          rating: 5,
        },
        {
          id: 3,
          name: 'Ana Costa',
          position: 'Diretora de Marketing',
          company: 'E-commerce Plus',
          text: 'A integração com múltiplos canais nos permitiu centralizar todo o atendimento. Nossa equipe ficou mais produtiva e os clientes mais satisfeitos.',
          highlightPhrase: 'centralizar todo o atendimento',
          avatar: '/images/testimonials/ana-costa.jpg',
          companyLogo: '/images/testimonials/ecommerce-logo.png',
          rating: 5,
        },
        {
          id: 4,
          name: 'Carlos Oliveira',
          position: 'Head de Customer Success',
          company: 'SaaS Solutions',
          text: 'O sistema de automação do Chatwoot nos ajudou a escalar o atendimento sem perder a qualidade. Recomendo para qualquer empresa que busca excelência.',
          highlightPhrase: 'escalar o atendimento sem perder a qualidade',
          avatar: '/images/testimonials/carlos-oliveira.jpg',
          companyLogo: '/images/testimonials/saas-logo.png',
          rating: 5,
        },
        {
          id: 5,
          name: 'Fernanda Lima',
          position: 'Coordenadora de Suporte',
          company: 'Digital Agency',
          text: 'Com o Chatwoot, conseguimos organizar melhor nossos tickets e ter uma visão completa do histórico de cada cliente. Ferramenta indispensável!',
          highlightPhrase: 'visão completa do histórico',
          avatar: '/images/testimonials/fernanda-lima.jpg',
          companyLogo: '/images/testimonials/digital-logo.png',
          rating: 5,
        },
      ],
    },
    autoplay: {
      type: Boolean,
      default: true,
    },
    autoplayInterval: {
      type: Number,
      default: 5000,
    },
    showNavigation: {
      type: Boolean,
      default: true,
    },
    showPagination: {
      type: Boolean,
      default: true,
    },
  },
  setup() {
    const { getThemeClass } = useDarkMode();
    return { getThemeClass };
  },
  data() {
    return {
      currentSlide: 0,
      autoplayTimer: null,
      isTransitioning: false,
      touchStartX: 0,
      touchEndX: 0,
    };
  },
  computed: {
    visibleTestimonials() {
      // Show 3 testimonials on desktop, 2 on tablet, 1 on mobile
      const itemsPerSlide = this.getItemsPerSlide();
      const start = this.currentSlide * itemsPerSlide;
      return this.testimonials.slice(start, start + itemsPerSlide);
    },
    totalSlides() {
      const itemsPerSlide = this.getItemsPerSlide();
      return Math.ceil(this.testimonials.length / itemsPerSlide);
    },
    canGoNext() {
      return this.currentSlide < this.totalSlides - 1;
    },
    canGoPrev() {
      return this.currentSlide > 0;
    },
  },
  mounted() {
    if (this.autoplay) {
      this.startAutoplay();
    }
    window.addEventListener('resize', this.handleResize);
  },
  beforeUnmount() {
    this.stopAutoplay();
    window.removeEventListener('resize', this.handleResize);
  },
  methods: {
    getItemsPerSlide() {
      if (typeof window === 'undefined') return 3;
      
      const width = window.innerWidth;
      if (width < 768) return 1; // Mobile
      if (width < 1024) return 2; // Tablet
      return 3; // Desktop
    },
    nextSlide() {
      if (this.isTransitioning || !this.canGoNext) return;
      
      this.isTransitioning = true;
      this.currentSlide++;
      
      if (this.currentSlide >= this.totalSlides) {
        this.currentSlide = 0;
      }
      
      setTimeout(() => {
        this.isTransitioning = false;
      }, 300);
      
      this.resetAutoplay();
    },
    prevSlide() {
      if (this.isTransitioning || !this.canGoPrev) return;
      
      this.isTransitioning = true;
      this.currentSlide--;
      
      if (this.currentSlide < 0) {
        this.currentSlide = this.totalSlides - 1;
      }
      
      setTimeout(() => {
        this.isTransitioning = false;
      }, 300);
      
      this.resetAutoplay();
    },
    goToSlide(index) {
      if (this.isTransitioning || index === this.currentSlide) return;
      
      this.isTransitioning = true;
      this.currentSlide = index;
      
      setTimeout(() => {
        this.isTransitioning = false;
      }, 300);
      
      this.resetAutoplay();
    },
    startAutoplay() {
      if (!this.autoplay) return;
      
      this.autoplayTimer = setInterval(() => {
        this.nextSlide();
      }, this.autoplayInterval);
    },
    stopAutoplay() {
      if (this.autoplayTimer) {
        clearInterval(this.autoplayTimer);
        this.autoplayTimer = null;
      }
    },
    resetAutoplay() {
      this.stopAutoplay();
      if (this.autoplay) {
        this.startAutoplay();
      }
    },
    handleResize() {
      // Recalculate slides when window resizes
      const newTotalSlides = this.totalSlides;
      if (this.currentSlide >= newTotalSlides) {
        this.currentSlide = Math.max(0, newTotalSlides - 1);
      }
    },
    handleTouchStart(event) {
      this.touchStartX = event.touches[0].clientX;
    },
    handleTouchEnd(event) {
      this.touchEndX = event.changedTouches[0].clientX;
      this.handleSwipe();
    },
    handleSwipe() {
      const swipeThreshold = 50;
      const diff = this.touchStartX - this.touchEndX;
      
      if (Math.abs(diff) > swipeThreshold) {
        if (diff > 0) {
          this.nextSlide();
        } else {
          this.prevSlide();
        }
      }
    },
    handleKeydown(event) {
      switch (event.key) {
        case 'ArrowLeft':
          event.preventDefault();
          this.prevSlide();
          break;
        case 'ArrowRight':
          event.preventDefault();
          this.nextSlide();
          break;
        case 'Home':
          event.preventDefault();
          this.goToSlide(0);
          break;
        case 'End':
          event.preventDefault();
          this.goToSlide(this.totalSlides - 1);
          break;
      }
    },
  },
};
</script>

<template>
  <section
    class="testimonials-section"
    :class="getThemeClass('bg-slate-50', 'dark:bg-slate-900')"
    aria-label="Seção de depoimentos de clientes"
  >
    <div class="container">
      <!-- Header -->
      <div class="section-header">
        <h2
          class="section-title"
          :class="getThemeClass('text-slate-900', 'dark:text-slate-100')"
        >
          {{ title }}
        </h2>
        <p
          v-if="subtitle"
          class="section-subtitle"
          :class="getThemeClass('text-slate-600', 'dark:text-slate-400')"
        >
          {{ subtitle }}
        </p>
      </div>

      <!-- Carousel -->
      <div
        class="testimonials-carousel"
        @touchstart="handleTouchStart"
        @touchend="handleTouchEnd"
        @keydown="handleKeydown"
        tabindex="0"
        role="region"
        aria-label="Carrossel de depoimentos"
        aria-live="polite"
      >
        <!-- Navigation Buttons -->
        <button
          v-if="showNavigation && canGoPrev"
          class="nav-button nav-prev"
          :class="getThemeClass('bg-white text-slate-700 hover:bg-slate-50', 'dark:bg-slate-800 dark:text-slate-300 dark:hover:bg-slate-700')"
          @click="prevSlide"
          :disabled="isTransitioning"
          aria-label="Depoimento anterior"
        >
          <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
          </svg>
        </button>

        <button
          v-if="showNavigation && canGoNext"
          class="nav-button nav-next"
          :class="getThemeClass('bg-white text-slate-700 hover:bg-slate-50', 'dark:bg-slate-800 dark:text-slate-300 dark:hover:bg-slate-700')"
          @click="nextSlide"
          :disabled="isTransitioning"
          aria-label="Próximo depoimento"
        >
          <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
        </button>

        <!-- Testimonials Grid -->
        <div class="testimonials-grid">
          <transition-group
            name="testimonial"
            tag="div"
            class="testimonials-wrapper"
          >
            <TestimonialCard
              v-for="testimonial in visibleTestimonials"
              :key="`${testimonial.id}-${currentSlide}`"
              :testimonial="testimonial"
              class="testimonial-item"
            />
          </transition-group>
        </div>

        <!-- Pagination Dots -->
        <div
          v-if="showPagination && totalSlides > 1"
          class="pagination"
          role="tablist"
          aria-label="Navegação de depoimentos"
        >
          <button
            v-for="(slide, index) in totalSlides"
            :key="index"
            class="pagination-dot"
            :class="{
              'active': index === currentSlide,
              ...getThemeClass('bg-slate-300 hover:bg-slate-400', 'dark:bg-slate-600 dark:hover:bg-slate-500')
            }"
            @click="goToSlide(index)"
            :disabled="isTransitioning"
            role="tab"
            :aria-selected="index === currentSlide"
            :aria-label="`Ir para grupo de depoimentos ${index + 1}`"
          ></button>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
@import 'widget/assets/scss/variables.scss';
@import 'dashboard/assets/scss/mixins.scss';

.testimonials-section {
  padding: $space-jumbo 0;
  position: relative;

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 $space-normal;
  }

  .section-header {
    text-align: center;
    margin-bottom: $space-jumbo;

    .section-title {
      font-size: 2.5rem;
      font-weight: $font-weight-bold;
      margin-bottom: $space-normal;
      line-height: 1.2;

      @media (max-width: 768px) {
        font-size: 2rem;
      }
    }

    .section-subtitle {
      font-size: $font-size-large;
      line-height: 1.6;
      max-width: 600px;
      margin: 0 auto;

      @media (max-width: 768px) {
        font-size: $font-size-default;
      }
    }
  }

  .testimonials-carousel {
    position: relative;
    outline: none;

    &:focus-visible {
      outline: 2px solid $color-woot;
      outline-offset: 4px;
      border-radius: $space-small;
    }

    .nav-button {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      width: 48px;
      height: 48px;
      border-radius: 50%;
      border: none;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      cursor: pointer;
      z-index: 10;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      justify-content: center;

      &:hover {
        transform: translateY(-50%) scale(1.05);
      }

      &:disabled {
        opacity: 0.5;
        cursor: not-allowed;
        transform: translateY(-50%);
      }

      &.nav-prev {
        left: -24px;

        @media (max-width: 768px) {
          left: -16px;
        }
      }

      &.nav-next {
        right: -24px;

        @media (max-width: 768px) {
          right: -16px;
        }
      }

      @media (max-width: 768px) {
        width: 40px;
        height: 40px;
      }
    }

    .testimonials-grid {
      overflow: hidden;
      border-radius: $space-normal;

      .testimonials-wrapper {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: $space-normal;
        min-height: 320px;

        @media (max-width: 1024px) {
          grid-template-columns: repeat(2, 1fr);
        }

        @media (max-width: 768px) {
          grid-template-columns: 1fr;
        }

        .testimonial-item {
          width: 100%;
        }
      }
    }

    .pagination {
      display: flex;
      justify-content: center;
      gap: $space-small;
      margin-top: $space-large;

      .pagination-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;

        &.active {
          background-color: $color-woot !important;
          transform: scale(1.2);
        }

        &:hover:not(.active) {
          transform: scale(1.1);
        }

        &:disabled {
          cursor: not-allowed;
        }
      }
    }
  }
}

// Transition animations
.testimonial-enter-active,
.testimonial-leave-active {
  transition: all 0.3s ease;
}

.testimonial-enter-from {
  opacity: 0;
  transform: translateX(30px);
}

.testimonial-leave-to {
  opacity: 0;
  transform: translateX(-30px);
}

// Responsive adjustments
@media (max-width: 768px) {
  .testimonials-section {
    padding: $space-large 0;

    .container {
      padding: 0 $space-normal;
    }

    .section-header {
      margin-bottom: $space-large;
    }

    .testimonials-carousel .testimonials-grid .testimonials-wrapper {
      gap: $space-normal;
      min-height: auto;
    }
  }
}

// High contrast mode support
@media (prefers-contrast: high) {
  .testimonials-section {
    .nav-button {
      border: 2px solid currentColor;
    }

    .pagination .pagination-dot {
      border: 2px solid currentColor;
    }
  }
}

// Reduced motion support
@media (prefers-reduced-motion: reduce) {
  .testimonial-enter-active,
  .testimonial-leave-active,
  .nav-button,
  .pagination-dot {
    transition: none;
  }

  .nav-button:hover {
    transform: translateY(-50%);
  }

  .pagination-dot:hover:not(.active) {
    transform: none;
  }
}
</style>

