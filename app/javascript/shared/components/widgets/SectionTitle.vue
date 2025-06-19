<template>
  <div :class="containerClasses">
    <!-- Subtitle/Eyebrow -->
    <p 
      v-if="subtitle" 
      :class="subtitleClasses"
      :style="subtitleStyles"
    >
      {{ subtitle }}
    </p>
    
    <!-- Main Title -->
    <component
      :is="titleTag"
      :class="titleClasses"
      :style="titleStyles"
    >
      <slot name="title">{{ title }}</slot>
    </component>
    
    <!-- Description -->
    <p 
      v-if="description || $slots.description" 
      :class="descriptionClasses"
      :style="descriptionStyles"
    >
      <slot name="description">{{ description }}</slot>
    </p>
    
    <!-- Decorative element -->
    <div 
      v-if="showDecorator" 
      :class="decoratorClasses"
      :style="decoratorStyles"
    />
    
    <!-- Custom content slot -->
    <div v-if="$slots.default" class="section-title-content">
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  name: 'SectionTitle',
  props: {
    // Conteúdo
    title: {
      type: String,
      required: true,
    },
    subtitle: {
      type: String,
      default: null,
    },
    description: {
      type: String,
      default: null,
    },
    
    // Configurações de tag HTML
    titleTag: {
      type: String,
      default: 'h2', // 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'
    },
    
    // Alinhamento
    alignment: {
      type: String,
      default: 'center', // 'left', 'center', 'right'
    },
    
    // Tamanhos
    titleSize: {
      type: String,
      default: 'large', // 'small', 'medium', 'large', 'xl', '2xl', '3xl'
    },
    subtitleSize: {
      type: String,
      default: 'medium', // 'small', 'medium', 'large'
    },
    descriptionSize: {
      type: String,
      default: 'medium', // 'small', 'medium', 'large'
    },
    
    // Cores
    titleColor: {
      type: String,
      default: null,
    },
    subtitleColor: {
      type: String,
      default: null,
    },
    descriptionColor: {
      type: String,
      default: null,
    },
    
    // Espaçamento
    spacing: {
      type: String,
      default: 'default', // 'tight', 'default', 'loose'
    },
    marginBottom: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large'
    },
    
    // Decorador
    showDecorator: {
      type: Boolean,
      default: false,
    },
    decoratorType: {
      type: String,
      default: 'line', // 'line', 'dots', 'circle'
    },
    decoratorColor: {
      type: String,
      default: null,
    },
    decoratorPosition: {
      type: String,
      default: 'bottom', // 'top', 'bottom'
    },
    
    // Animação
    animated: {
      type: Boolean,
      default: false,
    },
    animationDelay: {
      type: Number,
      default: 0,
    },
    
    // Classes customizadas
    customClass: {
      type: String,
      default: '',
    },
    titleClass: {
      type: String,
      default: '',
    },
    subtitleClass: {
      type: String,
      default: '',
    },
    descriptionClass: {
      type: String,
      default: '',
    },
    
    // Responsividade
    responsive: {
      type: Boolean,
      default: true,
    },
  },
  
  computed: {
    containerClasses() {
      const classes = ['section-title'];
      
      // Alignment
      if (this.alignment === 'center') {
        classes.push('text-center');
      } else if (this.alignment === 'right') {
        classes.push('text-right');
      } else {
        classes.push('text-left');
      }
      
      // Spacing
      if (this.spacing === 'tight') {
        classes.push('space-y-2');
      } else if (this.spacing === 'loose') {
        classes.push('space-y-6');
      } else {
        classes.push('space-y-4');
      }
      
      // Margin bottom
      if (this.marginBottom === 'none') {
        classes.push('mb-0');
      } else if (this.marginBottom === 'small') {
        classes.push('mb-6');
      } else if (this.marginBottom === 'large') {
        classes.push('mb-16');
      } else {
        classes.push('mb-12');
      }
      
      // Animation
      if (this.animated) {
        classes.push('animate-fade-in-up');
      }
      
      // Custom class
      if (this.customClass) {
        classes.push(this.customClass);
      }
      
      return classes.join(' ');
    },
    
    titleClasses() {
      const classes = ['section-title-main'];
      
      // Size classes
      const sizeClasses = {
        small: 'text-xl md:text-2xl',
        medium: 'text-2xl md:text-3xl',
        large: 'text-3xl md:text-4xl lg:text-5xl',
        xl: 'text-4xl md:text-5xl lg:text-6xl',
        '2xl': 'text-5xl md:text-6xl lg:text-7xl',
        '3xl': 'text-6xl md:text-7xl lg:text-8xl',
      };
      
      classes.push(sizeClasses[this.titleSize] || sizeClasses.large);
      
      // Default styling
      classes.push('font-bold leading-tight');
      
      // Responsive adjustments
      if (this.responsive) {
        classes.push('max-w-4xl mx-auto');
      }
      
      // Custom class
      if (this.titleClass) {
        classes.push(this.titleClass);
      }
      
      return classes.join(' ');
    },
    
    subtitleClasses() {
      const classes = ['section-title-subtitle'];
      
      // Size classes
      const sizeClasses = {
        small: 'text-sm',
        medium: 'text-base',
        large: 'text-lg',
      };
      
      classes.push(sizeClasses[this.subtitleSize] || sizeClasses.medium);
      
      // Default styling
      classes.push('font-medium uppercase tracking-wider text-gray-600');
      
      // Custom class
      if (this.subtitleClass) {
        classes.push(this.subtitleClass);
      }
      
      return classes.join(' ');
    },
    
    descriptionClasses() {
      const classes = ['section-title-description'];
      
      // Size classes
      const sizeClasses = {
        small: 'text-sm',
        medium: 'text-base md:text-lg',
        large: 'text-lg md:text-xl',
      };
      
      classes.push(sizeClasses[this.descriptionSize] || sizeClasses.medium);
      
      // Default styling
      classes.push('text-gray-600 leading-relaxed');
      
      // Responsive adjustments
      if (this.responsive) {
        classes.push('max-w-3xl mx-auto');
      }
      
      // Custom class
      if (this.descriptionClass) {
        classes.push(this.descriptionClass);
      }
      
      return classes.join(' ');
    },
    
    decoratorClasses() {
      const classes = ['section-title-decorator'];
      
      if (this.decoratorType === 'line') {
        classes.push('w-16 h-1 bg-blue-600 mx-auto');
      } else if (this.decoratorType === 'dots') {
        classes.push('flex space-x-2 justify-center');
      } else if (this.decoratorType === 'circle') {
        classes.push('w-3 h-3 bg-blue-600 rounded-full mx-auto');
      }
      
      return classes.join(' ');
    },
    
    titleStyles() {
      const styles = {};
      
      if (this.titleColor) {
        styles.color = this.titleColor;
      }
      
      if (this.animated && this.animationDelay) {
        styles.animationDelay = `${this.animationDelay}ms`;
      }
      
      return styles;
    },
    
    subtitleStyles() {
      const styles = {};
      
      if (this.subtitleColor) {
        styles.color = this.subtitleColor;
      }
      
      return styles;
    },
    
    descriptionStyles() {
      const styles = {};
      
      if (this.descriptionColor) {
        styles.color = this.descriptionColor;
      }
      
      return styles;
    },
    
    decoratorStyles() {
      const styles = {};
      
      if (this.decoratorColor) {
        styles.backgroundColor = this.decoratorColor;
      }
      
      return styles;
    },
  },
};
</script>

<style scoped>
.section-title {
  position: relative;
}

.section-title-content {
  margin-top: 1.5rem;
}

/* Decorator dots */
.section-title-decorator.flex::before,
.section-title-decorator.flex::after {
  content: '';
  width: 0.5rem;
  height: 0.5rem;
  background-color: currentColor;
  border-radius: 50%;
}

/* Animation */
@keyframes fade-in-up {
  from {
    opacity: 0;
    transform: translateY(2rem);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-up {
  animation: fade-in-up 0.6s ease-out forwards;
}

/* Responsive typography */
@media (max-width: 640px) {
  .section-title-main {
    line-height: 1.2;
  }
  
  .section-title-description {
    font-size: 0.9rem;
  }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
  .section-title-subtitle {
    color: #9CA3AF;
  }
  
  .section-title-description {
    color: #9CA3AF;
  }
}
</style>

