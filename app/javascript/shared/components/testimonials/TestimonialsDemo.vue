<template>
  <div class="testimonials-demo">
    <h1>Demonstração dos Componentes de Depoimentos</h1>
    
    <!-- Seção completa com configurações padrão -->
    <section class="demo-section">
      <h2>Seção Completa - Configuração Padrão</h2>
      <TestimonialsSection />
    </section>

    <!-- Seção personalizada -->
    <section class="demo-section">
      <h2>Seção Personalizada</h2>
      <TestimonialsSection
        title="Casos de Sucesso"
        subtitle="Empresas que transformaram seu atendimento com o Chatwoot"
        :testimonials="customTestimonials"
        :autoplay="false"
        :autoplay-interval="3000"
      />
    </section>

    <!-- Cards individuais -->
    <section class="demo-section">
      <h2>Cards Individuais</h2>
      <div class="individual-cards">
        <TestimonialCard
          v-for="testimonial in sampleTestimonials"
          :key="testimonial.id"
          :testimonial="testimonial"
        />
      </div>
    </section>

    <!-- Seção sem autoplay -->
    <section class="demo-section">
      <h2>Sem Autoplay</h2>
      <TestimonialsSection
        title="Controle Manual"
        :autoplay="false"
        :testimonials="sampleTestimonials"
      />
    </section>

    <!-- Seção sem navegação -->
    <section class="demo-section">
      <h2>Sem Navegação</h2>
      <TestimonialsSection
        title="Apenas Visualização"
        :show-navigation="false"
        :show-pagination="false"
        :autoplay="false"
        :testimonials="sampleTestimonials.slice(0, 3)"
      />
    </section>
  </div>
</template>

<script>
import TestimonialsSection from './TestimonialsSection.vue';
import TestimonialCard from './TestimonialCard.vue';

export default {
  name: 'TestimonialsDemo',
  components: {
    TestimonialsSection,
    TestimonialCard,
  },
  data() {
    return {
      customTestimonials: [
        {
          id: 1,
          name: 'Roberto Mendes',
          position: 'CTO',
          company: 'InnovaTech',
          text: 'A implementação do Chatwoot foi um divisor de águas para nossa empresa. Conseguimos integrar todos os canais de comunicação em uma única plataforma, resultando em uma melhoria de 85% na eficiência do atendimento.',
          highlightPhrase: 'melhoria de 85% na eficiência',
          avatar: '/images/testimonials/roberto-mendes.jpg',
          companyLogo: '/images/testimonials/innovatech-logo.png',
          rating: 5,
        },
        {
          id: 2,
          name: 'Luciana Ferreira',
          position: 'Head de Customer Experience',
          company: 'RetailMax',
          text: 'O sistema de automação inteligente do Chatwoot nos permitiu reduzir o tempo médio de resposta de 4 horas para apenas 15 minutos. Nossos clientes notaram a diferença imediatamente.',
          highlightPhrase: 'de 4 horas para apenas 15 minutos',
          avatar: '/images/testimonials/luciana-ferreira.jpg',
          companyLogo: '/images/testimonials/retailmax-logo.png',
          rating: 5,
        },
        {
          id: 3,
          name: 'Eduardo Santos',
          position: 'Diretor Comercial',
          company: 'FinanceHub',
          text: 'Com o Chatwoot, nossa taxa de conversão de leads aumentou 200%. A capacidade de acompanhar toda a jornada do cliente em tempo real é simplesmente fantástica.',
          highlightPhrase: 'taxa de conversão aumentou 200%',
          avatar: '/images/testimonials/eduardo-santos.jpg',
          companyLogo: '/images/testimonials/financehub-logo.png',
          rating: 5,
        },
      ],
      sampleTestimonials: [
        {
          id: 1,
          name: 'Ana Paula',
          position: 'Gerente de Suporte',
          company: 'TechStart',
          text: 'Interface intuitiva e recursos poderosos. Recomendo!',
          avatar: '/images/testimonials/ana-paula.jpg',
          rating: 5,
        },
        {
          id: 2,
          name: 'Carlos Eduardo',
          position: 'CEO',
          company: 'Digital Solutions',
          text: 'Transformou completamente nosso atendimento ao cliente.',
          highlightPhrase: 'Transformou completamente',
          companyLogo: '/images/testimonials/digital-solutions-logo.png',
          rating: 5,
        },
        {
          id: 3,
          name: 'Mariana Costa',
          position: 'Product Manager',
          company: 'AppCorp',
          text: 'A melhor plataforma de atendimento que já utilizamos. Suporte excepcional e funcionalidades avançadas.',
          highlightPhrase: 'A melhor plataforma',
          avatar: '/images/testimonials/mariana-costa.jpg',
          companyLogo: '/images/testimonials/appcorp-logo.png',
          rating: 5,
        },
      ],
    };
  },
};
</script>

<style scoped lang="scss">
.testimonials-demo {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;

  h1 {
    text-align: center;
    margin-bottom: 3rem;
    color: #1f2937;
    font-size: 2.5rem;
  }

  .demo-section {
    margin-bottom: 4rem;
    padding: 2rem;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    background: #f9fafb;

    h2 {
      margin-bottom: 2rem;
      color: #374151;
      font-size: 1.5rem;
      border-bottom: 2px solid #3b82f6;
      padding-bottom: 0.5rem;
    }

    .individual-cards {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
      gap: 1.5rem;
      margin-top: 2rem;
    }
  }
}

// Dark mode support
@media (prefers-color-scheme: dark) {
  .testimonials-demo {
    background: #111827;
    color: #f9fafb;

    h1 {
      color: #f9fafb;
    }

    .demo-section {
      background: #1f2937;
      border-color: #374151;

      h2 {
        color: #f9fafb;
        border-bottom-color: #60a5fa;
      }
    }
  }
}

// Responsive design
@media (max-width: 768px) {
  .testimonials-demo {
    padding: 1rem;

    h1 {
      font-size: 2rem;
      margin-bottom: 2rem;
    }

    .demo-section {
      padding: 1rem;
      margin-bottom: 2rem;

      h2 {
        font-size: 1.25rem;
        margin-bottom: 1rem;
      }

      .individual-cards {
        grid-template-columns: 1fr;
        gap: 1rem;
      }
    }
  }
}
</style>

