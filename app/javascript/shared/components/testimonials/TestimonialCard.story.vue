<script setup>
import TestimonialCard from './TestimonialCard.vue';
import { sampleTestimonials } from './testimonials-data.js';

// Dados de exemplo para as histórias
const basicTestimonial = sampleTestimonials[0];

const testimonialWithoutAvatar = {
  ...basicTestimonial,
  avatar: null,
};

const testimonialWithoutLogo = {
  ...basicTestimonial,
  companyLogo: null,
};

const testimonialWithoutRating = {
  ...basicTestimonial,
  rating: null,
};

const testimonialMinimal = {
  id: 999,
  name: 'Cliente Simples',
  text: 'Depoimento básico sem informações extras.',
};

const testimonialLongText = {
  ...basicTestimonial,
  text: 'Este é um depoimento muito longo para testar como o componente se comporta com textos extensos. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
  highlightPhrase: 'textos extensos',
};

const testimonialWithPartialRating = {
  ...basicTestimonial,
  rating: 3,
};
</script>

<template>
  <Story
    title="Components/Testimonials/TestimonialCard"
    :layout="{ type: 'grid', width: '400px' }"
  >
    <!-- Variante padrão -->
    <Variant title="Padrão">
      <TestimonialCard :testimonial="basicTestimonial" />
    </Variant>

    <!-- Sem avatar -->
    <Variant title="Sem Avatar">
      <TestimonialCard :testimonial="testimonialWithoutAvatar" />
    </Variant>

    <!-- Sem logo da empresa -->
    <Variant title="Sem Logo da Empresa">
      <TestimonialCard :testimonial="testimonialWithoutLogo" />
    </Variant>

    <!-- Sem avaliação -->
    <Variant title="Sem Avaliação">
      <TestimonialCard :testimonial="testimonialWithoutRating" />
    </Variant>

    <!-- Versão mínima -->
    <Variant title="Mínimo">
      <TestimonialCard :testimonial="testimonialMinimal" />
    </Variant>

    <!-- Texto longo -->
    <Variant title="Texto Longo">
      <TestimonialCard :testimonial="testimonialLongText" />
    </Variant>

    <!-- Avaliação parcial -->
    <Variant title="Avaliação Parcial (3 estrelas)">
      <TestimonialCard :testimonial="testimonialWithPartialRating" />
    </Variant>

    <!-- Modo escuro -->
    <Variant title="Modo Escuro" :meta="{ colorScheme: 'dark' }">
      <div class="dark bg-slate-900 p-4 rounded">
        <TestimonialCard :testimonial="basicTestimonial" />
      </div>
    </Variant>

    <!-- Estados de hover -->
    <Variant title="Estado Hover">
      <div class="hover-demo">
        <TestimonialCard :testimonial="basicTestimonial" class="hover" />
        <p class="text-sm text-gray-600 mt-2">
          Passe o mouse sobre o card para ver o efeito
        </p>
      </div>
    </Variant>

    <!-- Múltiplos cards para comparação -->
    <Variant title="Comparação" :layout="{ type: 'grid', width: '100%' }">
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <TestimonialCard 
          v-for="testimonial in sampleTestimonials.slice(0, 3)" 
          :key="testimonial.id"
          :testimonial="testimonial" 
        />
      </div>
    </Variant>
  </Story>
</template>

<style scoped>
.hover-demo .testimonial-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

.dark {
  color-scheme: dark;
}
</style>

