<template>
  <section 
    :class="containerClasses"
    :style="containerStyles"
  >
    <div 
      v-if="hasContainer"
      :class="innerContainerClasses"
    >
      <slot />
    </div>
    <slot v-else />
  </section>
</template>

<script>
export default {
  name: 'ContainerSection',
  props: {
    // Configurações de layout
    fullWidth: {
      type: Boolean,
      default: false,
    },
    hasContainer: {
      type: Boolean,
      default: true,
    },
    maxWidth: {
      type: String,
      default: '1200px',
    },
    
    // Configurações de espaçamento
    padding: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large'
    },
    paddingTop: {
      type: String,
      default: null,
    },
    paddingBottom: {
      type: String,
      default: null,
    },
    
    // Configurações visuais
    backgroundColor: {
      type: String,
      default: null,
    },
    backgroundImage: {
      type: String,
      default: null,
    },
    backgroundGradient: {
      type: String,
      default: null,
    },
    
    // Classes customizadas
    customClass: {
      type: String,
      default: '',
    },
    containerClass: {
      type: String,
      default: '',
    },
    
    // Configurações de altura
    minHeight: {
      type: String,
      default: null,
    },
    height: {
      type: String,
      default: null,
    },
    
    // Configurações de flexbox
    centerContent: {
      type: Boolean,
      default: false,
    },
    alignItems: {
      type: String,
      default: 'stretch', // 'start', 'center', 'end', 'stretch'
    },
    justifyContent: {
      type: String,
      default: 'start', // 'start', 'center', 'end', 'between', 'around', 'evenly'
    },
  },
  
  computed: {
    containerClasses() {
      const classes = ['container-section'];
      
      // Padding classes
      if (this.padding === 'none') {
        classes.push('py-0');
      } else if (this.padding === 'small') {
        classes.push('py-8');
      } else if (this.padding === 'large') {
        classes.push('py-20');
      } else {
        classes.push('py-12');
      }
      
      // Center content
      if (this.centerContent) {
        classes.push('flex items-center justify-center');
      } else {
        // Flexbox alignment
        if (this.alignItems !== 'stretch') {
          classes.push(`items-${this.alignItems}`);
        }
        if (this.justifyContent !== 'start') {
          classes.push(`justify-${this.justifyContent}`);
        }
      }
      
      // Custom classes
      if (this.customClass) {
        classes.push(this.customClass);
      }
      
      return classes.join(' ');
    },
    
    innerContainerClasses() {
      const classes = ['container mx-auto px-4'];
      
      if (!this.fullWidth) {
        classes.push('max-w-screen-xl');
      }
      
      if (this.containerClass) {
        classes.push(this.containerClass);
      }
      
      return classes.join(' ');
    },
    
    containerStyles() {
      const styles = {};
      
      // Background
      if (this.backgroundColor) {
        styles.backgroundColor = this.backgroundColor;
      }
      
      if (this.backgroundImage) {
        styles.backgroundImage = `url(${this.backgroundImage})`;
        styles.backgroundSize = 'cover';
        styles.backgroundPosition = 'center';
        styles.backgroundRepeat = 'no-repeat';
      }
      
      if (this.backgroundGradient) {
        styles.background = this.backgroundGradient;
      }
      
      // Dimensions
      if (this.minHeight) {
        styles.minHeight = this.minHeight;
      }
      
      if (this.height) {
        styles.height = this.height;
      }
      
      if (this.maxWidth && !this.fullWidth) {
        styles.maxWidth = this.maxWidth;
      }
      
      // Custom padding
      if (this.paddingTop) {
        styles.paddingTop = this.paddingTop;
      }
      
      if (this.paddingBottom) {
        styles.paddingBottom = this.paddingBottom;
      }
      
      return styles;
    },
  },
};
</script>

<style scoped>
.container-section {
  position: relative;
  width: 100%;
}

.container-section.flex {
  display: flex;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .container-section {
    padding-left: 1rem;
    padding-right: 1rem;
  }
}
</style>

