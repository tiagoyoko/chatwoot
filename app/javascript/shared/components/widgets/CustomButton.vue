<template>
  <component
    :is="componentTag"
    :class="buttonClasses"
    :style="buttonStyles"
    :disabled="disabled || loading"
    :type="htmlType"
    :href="href"
    :target="target"
    :rel="rel"
    @click="handleClick"
  >
    <!-- Loading spinner -->
    <span v-if="loading" class="button-spinner">
      <svg class="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
        <circle 
          class="opacity-25" 
          cx="12" 
          cy="12" 
          r="10" 
          stroke="currentColor" 
          stroke-width="4"
        />
        <path 
          class="opacity-75" 
          fill="currentColor" 
          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
        />
      </svg>
    </span>
    
    <!-- Icon (left) -->
    <span v-if="iconLeft && !loading" class="button-icon button-icon-left">
      <i :class="iconLeft" />
    </span>
    
    <!-- Button content -->
    <span :class="{ 'opacity-0': loading }">
      <slot />
    </span>
    
    <!-- Icon (right) -->
    <span v-if="iconRight && !loading" class="button-icon button-icon-right">
      <i :class="iconRight" />
    </span>
  </component>
</template>

<script>
export default {
  name: 'CustomButton',
  props: {
    // Variantes de estilo
    variant: {
      type: String,
      default: 'primary', // 'primary', 'secondary', 'outline', 'ghost', 'danger', 'success', 'warning'
    },
    
    // Tamanhos
    size: {
      type: String,
      default: 'medium', // 'small', 'medium', 'large', 'xl'
    },
    
    // Estados
    disabled: {
      type: Boolean,
      default: false,
    },
    loading: {
      type: Boolean,
      default: false,
    },
    
    // Layout
    block: {
      type: Boolean,
      default: false,
    },
    rounded: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large', 'full'
    },
    
    // Ícones
    iconLeft: {
      type: String,
      default: null,
    },
    iconRight: {
      type: String,
      default: null,
    },
    
    // Cores customizadas
    backgroundColor: {
      type: String,
      default: null,
    },
    textColor: {
      type: String,
      default: null,
    },
    borderColor: {
      type: String,
      default: null,
    },
    
    // Propriedades HTML
    htmlType: {
      type: String,
      default: 'button', // 'button', 'submit', 'reset'
    },
    
    // Link properties (quando usado como link)
    href: {
      type: String,
      default: null,
    },
    target: {
      type: String,
      default: null,
    },
    rel: {
      type: String,
      default: null,
    },
    
    // Classes customizadas
    customClass: {
      type: String,
      default: '',
    },
    
    // Sombra
    shadow: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large'
    },
  },
  
  computed: {
    componentTag() {
      return this.href ? 'a' : 'button';
    },
    
    buttonClasses() {
      const classes = ['custom-button'];
      
      // Base styles
      classes.push('inline-flex items-center justify-center font-medium transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2');
      
      // Variant styles
      classes.push(this.getVariantClasses());
      
      // Size styles
      classes.push(this.getSizeClasses());
      
      // Rounded styles
      classes.push(this.getRoundedClasses());
      
      // Shadow styles
      classes.push(this.getShadowClasses());
      
      // Block
      if (this.block) {
        classes.push('w-full');
      }
      
      // Disabled state
      if (this.disabled) {
        classes.push('opacity-50 cursor-not-allowed');
      }
      
      // Loading state
      if (this.loading) {
        classes.push('cursor-wait');
      }
      
      // Custom classes
      if (this.customClass) {
        classes.push(this.customClass);
      }
      
      return classes.join(' ');
    },
    
    buttonStyles() {
      const styles = {};
      
      if (this.backgroundColor) {
        styles.backgroundColor = this.backgroundColor;
      }
      
      if (this.textColor) {
        styles.color = this.textColor;
      }
      
      if (this.borderColor) {
        styles.borderColor = this.borderColor;
      }
      
      return styles;
    },
  },
  
  methods: {
    getVariantClasses() {
      const variants = {
        primary: 'bg-blue-600 hover:bg-blue-700 text-white border border-transparent focus:ring-blue-500',
        secondary: 'bg-gray-600 hover:bg-gray-700 text-white border border-transparent focus:ring-gray-500',
        outline: 'bg-transparent hover:bg-gray-50 text-gray-700 border border-gray-300 focus:ring-blue-500',
        ghost: 'bg-transparent hover:bg-gray-100 text-gray-700 border border-transparent focus:ring-gray-500',
        danger: 'bg-red-600 hover:bg-red-700 text-white border border-transparent focus:ring-red-500',
        success: 'bg-green-600 hover:bg-green-700 text-white border border-transparent focus:ring-green-500',
        warning: 'bg-yellow-500 hover:bg-yellow-600 text-white border border-transparent focus:ring-yellow-500',
      };
      
      return variants[this.variant] || variants.primary;
    },
    
    getSizeClasses() {
      const sizes = {
        small: 'px-3 py-1.5 text-sm',
        medium: 'px-4 py-2 text-sm',
        large: 'px-6 py-3 text-base',
        xl: 'px-8 py-4 text-lg',
      };
      
      return sizes[this.size] || sizes.medium;
    },
    
    getRoundedClasses() {
      const rounded = {
        none: 'rounded-none',
        small: 'rounded-sm',
        default: 'rounded-md',
        large: 'rounded-lg',
        full: 'rounded-full',
      };
      
      return rounded[this.rounded] || rounded.default;
    },
    
    getShadowClasses() {
      const shadows = {
        none: '',
        small: 'shadow-sm',
        default: 'shadow',
        large: 'shadow-lg',
      };
      
      return shadows[this.shadow] || shadows.default;
    },
    
    handleClick(event) {
      if (this.disabled || this.loading) {
        event.preventDefault();
        return;
      }
      
      this.$emit('click', event);
    },
  },
};
</script>

<style scoped>
.custom-button {
  position: relative;
  user-select: none;
}

.button-spinner {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.button-icon {
  display: flex;
  align-items: center;
}

.button-icon-left {
  margin-right: 0.5rem;
}

.button-icon-right {
  margin-left: 0.5rem;
}

/* Hover effects */
.custom-button:not(:disabled):not(.cursor-wait):hover {
  transform: translateY(-1px);
}

.custom-button:not(:disabled):not(.cursor-wait):active {
  transform: translateY(0);
}

/* Focus styles */
.custom-button:focus {
  outline: none;
}

/* Responsive adjustments */
@media (max-width: 640px) {
  .custom-button.w-full {
    width: 100%;
  }
}
</style>

