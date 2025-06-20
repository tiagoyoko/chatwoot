<script setup>
import TestimonialsSection from './TestimonialsSection.vue';
import { sampleTestimonials, testimonialsByCategory, testimonialConfigs } from './testimonials-data.js';

// Dados reduzidos para demonstração
const shortTestimonials = sampleTestimonials.slice(0, 4);
const manyTestimonials = sampleTestimonials;
</script>

<template>
  <Story
    title="Components/Testimonials/TestimonialsSection"
    :layout="{ type: 'fullscreen' }"
  >
    <!-- Configuração padrão -->
    <Variant title="Padrão">
      <TestimonialsSection :testimonials="shortTestimonials" />
    </Variant>

    <!-- Sem autoplay -->
    <Variant title="Sem Autoplay">
      <TestimonialsSection 
        :testimonials="shortTestimonials"
        :autoplay="false"
      />
    </Variant>

    <!-- Sem navegação -->
    <Variant title="Sem Navegação">
      <TestimonialsSection 
        :testimonials="shortTestimonials"
        :show-navigation="false"
        :autoplay="false"
      />
    </Variant>

    <!-- Sem paginação -->
    <Variant title="Sem Paginação">
      <TestimonialsSection 
        :testimonials="shortTestimonials"
        :show-pagination="false"
        :autoplay="false"
      />
    </Variant>

    <!-- Título e subtítulo personalizados -->
    <Variant title="Personalizado">
      <TestimonialsSection 
        title="Casos de Sucesso"
        subtitle="Veja como empresas reais transformaram seu atendimento"
        :testimonials="shortTestimonials"
        :autoplay="false"
      />
    </Variant>

    <!-- Muitos depoimentos -->
    <Variant title="Muitos Depoimentos">
      <TestimonialsSection 
        :testimonials="manyTestimonials"
        :autoplay="false"
      />
    </Variant>

    <!-- Configuração para homepage -->
    <Variant title="Homepage">
      <TestimonialsSection 
        v-bind="testimonialConfigs.homepage"
        :testimonials="shortTestimonials"
      />
    </Variant>

    <!-- Configuração para pricing -->
    <Variant title="Pricing Page">
      <TestimonialsSection 
        v-bind="testimonialConfigs.pricing"
        :testimonials="shortTestimonials"
      />
    </Variant>

    <!-- Depoimentos de E-commerce -->
    <Variant title="E-commerce">
      <TestimonialsSection 
        title="Sucesso no E-commerce"
        subtitle="Como lojas online aumentaram suas vendas"
        :testimonials="testimonialsByCategory.ecommerce"
        :autoplay="false"
      />
    </Variant>

    <!-- Depoimentos de SaaS -->
    <Variant title="SaaS">
      <TestimonialsSection 
        title="Transformação SaaS"
        subtitle="Empresas de software que escalaram com Chatwoot"
        :testimonials="testimonialsByCategory.saas"
        :autoplay="false"
      />
    </Variant>

    <!-- Modo escuro -->
    <Variant title="Modo Escuro" :meta="{ colorScheme: 'dark' }">
      <div class="dark bg-slate-900 min-h-screen">
        <TestimonialsSection 
          :testimonials="shortTestimonials"
          :autoplay="false"
        />
      </div>
    </Variant>

    <!-- Responsivo - Mobile -->
    <Variant title="Mobile" :meta="{ viewport: { width: 375, height: 667 } }">
      <TestimonialsSection 
        :testimonials="shortTestimonials"
        :autoplay="false"
      />
    </Variant>

    <!-- Responsivo - Tablet -->
    <Variant title="Tablet" :meta="{ viewport: { width: 768, height: 1024 } }">
      <TestimonialsSection 
        :testimonials="shortTestimonials"
        :autoplay="false"
      />
    </Variant>

    <!-- Autoplay rápido para demonstração -->
    <Variant title="Autoplay Rápido">
      <TestimonialsSection 
        :testimonials="shortTestimonials"
        :autoplay="true"
        :autoplay-interval="2000"
      />
      <p class="text-center text-sm text-gray-600 mt-4">
        Autoplay configurado para 2 segundos (apenas para demonstração)
      </p>
    </Variant>

    <!-- Poucos depoimentos -->
    <Variant title="Poucos Depoimentos">
      <TestimonialsSection 
        :testimonials="shortTestimonials.slice(0, 2)"
        :autoplay="false"
      />
    </Variant>

    <!-- Um único depoimento -->
    <Variant title="Único Depoimento">
      <TestimonialsSection 
        :testimonials="[shortTestimonials[0]]"
        :autoplay="false"
      />
    </Variant>

    <!-- Estados de loading/erro -->
    <Variant title="Sem Depoimentos">
      <TestimonialsSection 
        :testimonials="[]"
        :autoplay="false"
      />
    </Variant>

    <!-- Teste de acessibilidade -->
    <Variant title="Teste de Acessibilidade">
      <div class="accessibility-test">
        <TestimonialsSection 
          :testimonials="shortTestimonials"
          :autoplay="false"
        />
        <div class="mt-4 p-4 bg-blue-50 rounded">
          <h3 class="font-semibold mb-2">Teste de Acessibilidade:</h3>
          <ul class="text-sm space-y-1">
            <li>• Use Tab para navegar pelos controles</li>
            <li>• Use setas ← → para navegar pelos slides</li>
            <li>• Use Home/End para ir ao primeiro/último slide</li>
            <li>• Teste com leitor de tela</li>
          </ul>
        </div>
      </div>
    </Variant>
  </Story>
</template>

<style scoped>
.dark {
  color-scheme: dark;
}

.accessibility-test {
  outline: 2px dashed #3b82f6;
  outline-offset: 4px;
  padding: 1rem;
  border-radius: 8px;
}
</style>

