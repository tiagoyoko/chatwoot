# Componentes de Depoimentos

Esta pasta contém os componentes para exibir depoimentos de clientes no Chatwoot.

## Componentes

### TestimonialsSection.vue
Componente principal que exibe uma seção completa de depoimentos com carrossel.

#### Props
- `title` (String): Título da seção (padrão: "O que nossos clientes dizem")
- `subtitle` (String): Subtítulo da seção
- `testimonials` (Array): Array de objetos de depoimento
- `autoplay` (Boolean): Ativa reprodução automática (padrão: true)
- `autoplayInterval` (Number): Intervalo em ms para autoplay (padrão: 5000)
- `showNavigation` (Boolean): Mostra botões de navegação (padrão: true)
- `showPagination` (Boolean): Mostra pontos de paginação (padrão: true)

#### Exemplo de uso
```vue
<template>
  <TestimonialsSection
    title="Depoimentos dos Clientes"
    subtitle="Veja o que nossos clientes falam sobre nós"
    :testimonials="testimonialsList"
    :autoplay="true"
    :autoplay-interval="6000"
  />
</template>

<script>
import { TestimonialsSection } from 'shared/components/testimonials';

export default {
  components: {
    TestimonialsSection,
  },
  data() {
    return {
      testimonialsList: [
        {
          id: 1,
          name: 'João Silva',
          position: 'CEO',
          company: 'TechCorp',
          text: 'Excelente plataforma!',
          highlightPhrase: 'Excelente',
          avatar: '/images/testimonials/joao.jpg',
          companyLogo: '/images/testimonials/techcorp.png',
          rating: 5,
        },
        // ... mais depoimentos
      ],
    };
  },
};
</script>
```

### TestimonialCard.vue
Componente individual para exibir um único depoimento.

#### Props
- `testimonial` (Object, required): Objeto com dados do depoimento

#### Estrutura do objeto testimonial
```javascript
{
  id: Number,              // ID único
  name: String,            // Nome do cliente (obrigatório)
  position: String,        // Cargo do cliente (opcional)
  company: String,         // Nome da empresa (opcional)
  text: String,            // Texto do depoimento (obrigatório)
  highlightPhrase: String, // Frase para destacar (opcional)
  avatar: String,          // URL da foto do cliente (opcional)
  companyLogo: String,     // URL do logo da empresa (opcional)
  rating: Number,          // Avaliação de 1-5 estrelas (opcional)
}
```

## Recursos

### Acessibilidade
- ✅ Suporte completo a leitores de tela
- ✅ Navegação por teclado (setas, Home, End)
- ✅ Labels ARIA apropriados
- ✅ Suporte a modo de alto contraste
- ✅ Respeita preferências de movimento reduzido

### Responsividade
- **Desktop (1024px+)**: 3 depoimentos por slide
- **Tablet (768px-1023px)**: 2 depoimentos por slide
- **Mobile (<768px)**: 1 depoimento por slide

### Interações
- **Mouse**: Clique nos botões de navegação e pontos de paginação
- **Touch**: Swipe para navegar (mobile/tablet)
- **Teclado**: Setas esquerda/direita, Home, End
- **Autoplay**: Reprodução automática com pausa ao interagir

### Temas
- ✅ Suporte completo ao modo escuro
- ✅ Integração com sistema de temas do Chatwoot
- ✅ Transições suaves entre temas

## Estrutura de Assets

```
public/images/testimonials/
├── avatars/           # Fotos dos clientes
│   ├── cliente1.jpg
│   └── cliente2.jpg
├── logos/             # Logos das empresas
│   ├── empresa1.png
│   └── empresa2.png
└── default-avatar.png # Avatar padrão
```

### Recomendações de Imagens
- **Avatares**: 96x96px (mínimo 48x48px), formato circular
- **Logos**: 40x40px (máximo 80x80px), fundo transparente
- **Formatos**: PNG, JPG, WebP
- **Otimização**: Comprimir imagens para web

## Personalização

### CSS Custom Properties
O componente usa as variáveis SCSS do Chatwoot. Para personalizar:

```scss
.testimonials-section {
  --testimonial-card-bg: #ffffff;
  --testimonial-text-color: #374151;
  --testimonial-border-radius: 12px;
  --testimonial-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
```

### Animações
As animações podem ser desabilitadas respeitando `prefers-reduced-motion`:

```css
@media (prefers-reduced-motion: reduce) {
  .testimonial-enter-active,
  .testimonial-leave-active {
    transition: none;
  }
}
```

## Performance

- ✅ Lazy loading de imagens
- ✅ Transições otimizadas com CSS
- ✅ Debounce em eventos de resize
- ✅ Cleanup de timers no unmount
- ✅ Imagens com fallback automático

## Testes

Para testar os componentes:

```bash
# Executar testes unitários
npm run test:unit testimonials

# Executar testes de acessibilidade
npm run test:a11y testimonials
```

## Contribuição

Ao modificar os componentes:

1. Mantenha a compatibilidade com versões anteriores
2. Teste em diferentes tamanhos de tela
3. Verifique acessibilidade com leitores de tela
4. Teste com modo escuro ativado
5. Valide performance com muitos depoimentos

