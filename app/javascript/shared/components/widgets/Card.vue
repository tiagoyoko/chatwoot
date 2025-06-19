<template>
  <div 
    :class="cardClasses"
    :style="cardStyles"
    @click="handleClick"
  >
    <!-- Header -->
    <div v-if="hasHeader" :class="headerClasses">
      <!-- Icon -->
      <div v-if="icon" class="card-icon">
        <i :class="icon" :style="iconStyles" />
      </div>
      
      <!-- Image -->
      <div v-if="image" class="card-image">
        <img 
          :src="image" 
          :alt="imageAlt || title"
          :class="imageClasses"
        />
      </div>
      
      <!-- Header content -->
      <div v-if="$slots.header" class="card-header-content">
        <slot name="header" />
      </div>
    </div>
    
    <!-- Body -->
    <div :class="bodyClasses">
      <!-- Title -->
      <h3 v-if="title" :class="titleClasses" :style="titleStyles">
        {{ title }}
      </h3>
      
      <!-- Subtitle -->
      <p v-if="subtitle" :class="subtitleClasses" :style="subtitleStyles">
        {{ subtitle }}
      </p>
      
      <!-- Description -->
      <p v-if="description" :class="descriptionClasses" :style="descriptionStyles">
        {{ description }}
      </p>
      
      <!-- Default slot content -->
      <div v-if="$slots.default" class="card-content">
        <slot />
      </div>
    </div>
    
    <!-- Footer -->
    <div v-if="$slots.footer || showFooter" :class="footerClasses">
      <slot name="footer">
        <CustomButton
          v-if="buttonText"
          :variant="buttonVariant"
          :size="buttonSize"
          @click="handleButtonClick"
        >
          {{ buttonText }}
        </CustomButton>
      </slot>
    </div>
    
    <!-- Hover overlay -->
    <div v-if="hoverable" class="card-overlay" />
  </div>
</template>

<script>
import CustomButton from './CustomButton.vue';

export default {
  name: 'Card',
  components: {
    CustomButton,
  },
  props: {
    // Conteúdo
    title: {
      type: String,
      default: null,
    },
    subtitle: {
      type: String,
      default: null,
    },
    description: {
      type: String,
      default: null,
    },
    
    // Visual elements
    icon: {
      type: String,
      default: null,
    },
    iconColor: {
      type: String,
      default: null,
    },
    image: {
      type: String,
      default: null,
    },
    imageAlt: {
      type: String,
      default: null,
    },
    
    // Layout
    variant: {
      type: String,
      default: 'default', // 'default', 'outlined', 'elevated', 'flat'
    },
    size: {
      type: String,
      default: 'medium', // 'small', 'medium', 'large'
    },
    
    // Styling
    backgroundColor: {
      type: String,
      default: null,
    },
    borderColor: {
      type: String,
      default: null,
    },
    textColor: {
      type: String,
      default: null,
    },
    
    // Behavior
    hoverable: {
      type: Boolean,
      default: false,
    },
    clickable: {
      type: Boolean,
      default: false,
    },
    
    // Button
    buttonText: {
      type: String,
      default: null,
    },
    buttonVariant: {
      type: String,
      default: 'primary',
    },
    buttonSize: {
      type: String,
      default: 'medium',
    },
    
    // Spacing
    padding: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large'
    },
    
    // Border radius
    rounded: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large', 'xl'
    },
    
    // Shadow
    shadow: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large', 'xl'
    },
    
    // Custom classes
    customClass: {
      type: String,
      default: '',
    },
    headerClass: {
      type: String,
      default: '',
    },
    bodyClass: {
      type: String,
      default: '',
    },
    footerClass: {
      type: String,
      default: '',
    },
    
    // Animation
    animated: {
      type: Boolean,
      default: false,
    },
    animationDelay: {
      type: Number,
      default: 0,
    },
  },
  
  computed: {
    hasHeader() {
      return this.icon || this.image || this.$slots.header;
    },
    
    showFooter() {
      return this.buttonText;
    },
    
    cardClasses() {
      const classes = ['card'];
      
      // Base styles
      classes.push('relative overflow-hidden transition-all duration-300');
      
      // Variant styles
      classes.push(this.getVariantClasses());
      
      // Size styles
      classes.push(this.getSizeClasses());
      
      // Rounded styles
      classes.push(this.getRoundedClasses());
      
      // Shadow styles
      classes.push(this.getShadowClasses());
      
      // Hover effects
      if (this.hoverable || this.clickable) {
        classes.push('hover:transform hover:scale-105 hover:shadow-lg cursor-pointer');
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
    
    headerClasses() {
      const classes = ['card-header'];
      
      if (this.padding === 'none') {
        classes.push('p-0');
      } else if (this.padding === 'small') {
        classes.push('p-4 pb-2');
      } else if (this.padding === 'large') {
        classes.push('p-8 pb-4');
      } else {
        classes.push('p-6 pb-3');
      }
      
      if (this.headerClass) {
        classes.push(this.headerClass);
      }
      
      return classes.join(' ');
    },
    
    bodyClasses() {
      const classes = ['card-body'];
      
      if (this.padding === 'none') {
        classes.push('p-0');
      } else if (this.padding === 'small') {
        classes.push('px-4 pb-4');
      } else if (this.padding === 'large') {
        classes.push('px-8 pb-8');
      } else {
        classes.push('px-6 pb-6');
      }
      
      if (!this.hasHeader) {
        if (this.padding === 'small') {
          classes.push('pt-4');
        } else if (this.padding === 'large') {
          classes.push('pt-8');
        } else {
          classes.push('pt-6');
        }
      }
      
      if (this.bodyClass) {
        classes.push(this.bodyClass);
      }
      
      return classes.join(' ');
    },
    
    footerClasses() {
      const classes = ['card-footer'];
      
      if (this.padding === 'none') {
        classes.push('p-0');
      } else if (this.padding === 'small') {
        classes.push('px-4 pb-4');
      } else if (this.padding === 'large') {
        classes.push('px-8 pb-8');
      } else {
        classes.push('px-6 pb-6');
      }
      
      if (this.footerClass) {
        classes.push(this.footerClass);
      }
      
      return classes.join(' ');
    },
    
    titleClasses() {
      const sizeClasses = {
        small: 'text-lg',
        medium: 'text-xl',
        large: 'text-2xl',
      };
      
      return `card-title font-semibold mb-2 ${sizeClasses[this.size] || sizeClasses.medium}`;
    },
    
    subtitleClasses() {
      return 'card-subtitle text-sm font-medium text-gray-600 mb-2';
    },
    
    descriptionClasses() {
      return 'card-description text-gray-600 leading-relaxed mb-4';
    },
    
    imageClasses() {
      return 'w-full h-48 object-cover';
    },
    
    cardStyles() {
      const styles = {};
      
      if (this.backgroundColor) {
        styles.backgroundColor = this.backgroundColor;
      }
      
      if (this.borderColor) {
        styles.borderColor = this.borderColor;
      }
      
      if (this.textColor) {
        styles.color = this.textColor;
      }
      
      if (this.animated && this.animationDelay) {
        styles.animationDelay = `${this.animationDelay}ms`;
      }
      
      return styles;
    },
    
    titleStyles() {
      const styles = {};
      
      if (this.textColor) {
        styles.color = this.textColor;
      }
      
      return styles;
    },
    
    subtitleStyles() {
      const styles = {};
      
      if (this.textColor) {
        styles.color = this.textColor;
        styles.opacity = 0.8;
      }
      
      return styles;
    },
    
    descriptionStyles() {
      const styles = {};
      
      if (this.textColor) {
        styles.color = this.textColor;
        styles.opacity = 0.7;
      }
      
      return styles;
    },
    
    iconStyles() {
      const styles = {};
      
      if (this.iconColor) {
        styles.color = this.iconColor;
      }
      
      return styles;
    },
  },
  
  methods: {
    getVariantClasses() {
      const variants = {
        default: 'bg-white border border-gray-200',
        outlined: 'bg-transparent border-2 border-gray-300',
        elevated: 'bg-white border-0',
        flat: 'bg-gray-50 border-0',
      };
      
      return variants[this.variant] || variants.default;
    },
    
    getSizeClasses() {
      const sizes = {
        small: 'max-w-sm',
        medium: 'max-w-md',
        large: 'max-w-lg',
      };
      
      return sizes[this.size] || '';
    },
    
    getRoundedClasses() {
      const rounded = {
        none: 'rounded-none',
        small: 'rounded-sm',
        default: 'rounded-lg',
        large: 'rounded-xl',
        xl: 'rounded-2xl',
      };
      
      return rounded[this.rounded] || rounded.default;
    },
    
    getShadowClasses() {
      const shadows = {
        none: '',
        small: 'shadow-sm',
        default: 'shadow-md',
        large: 'shadow-lg',
        xl: 'shadow-xl',
      };
      
      return shadows[this.shadow] || shadows.default;
    },
    
    handleClick(event) {
      if (this.clickable) {
        this.$emit('click', event);
      }
    },
    
    handleButtonClick(event) {
      event.stopPropagation();
      this.$emit('button-click', event);
    },
  },
};
</script>

<style scoped>
.card {
  position: relative;
}

.card-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 3rem;
  height: 3rem;
  margin-bottom: 1rem;
  font-size: 1.5rem;
  background-color: #f3f4f6;
  border-radius: 0.5rem;
}

.card-image {
  margin-bottom: 1rem;
  border-radius: 0.5rem;
  overflow: hidden;
}

.card-content {
  margin-top: 1rem;
}

.card-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(147, 51, 234, 0.1));
  opacity: 0;
  transition: opacity 0.3s ease;
}

.card:hover .card-overlay {
  opacity: 1;
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

/* Responsive adjustments */
@media (max-width: 640px) {
  .card {
    margin: 0 1rem;
  }
}
</style>

