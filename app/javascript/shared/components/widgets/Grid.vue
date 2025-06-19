<template>
  <div :class="gridClasses" :style="gridStyles">
    <slot />
  </div>
</template>

<script>
export default {
  name: 'Grid',
  props: {
    // Configurações de colunas
    cols: {
      type: [Number, String],
      default: 'auto', // 'auto', 1, 2, 3, 4, 5, 6, 12
    },
    colsSm: {
      type: [Number, String],
      default: null,
    },
    colsMd: {
      type: [Number, String],
      default: null,
    },
    colsLg: {
      type: [Number, String],
      default: null,
    },
    colsXl: {
      type: [Number, String],
      default: null,
    },
    
    // Espaçamento entre itens
    gap: {
      type: String,
      default: 'default', // 'none', 'small', 'default', 'large', 'xl'
    },
    gapX: {
      type: String,
      default: null,
    },
    gapY: {
      type: String,
      default: null,
    },
    
    // Alinhamento
    alignItems: {
      type: String,
      default: 'stretch', // 'start', 'center', 'end', 'stretch'
    },
    justifyItems: {
      type: String,
      default: 'stretch', // 'start', 'center', 'end', 'stretch'
    },
    justifyContent: {
      type: String,
      default: 'start', // 'start', 'center', 'end', 'between', 'around', 'evenly'
    },
    alignContent: {
      type: String,
      default: 'start', // 'start', 'center', 'end', 'between', 'around', 'evenly', 'stretch'
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
    
    // Auto-fit e auto-fill
    autoFit: {
      type: Boolean,
      default: false,
    },
    autoFill: {
      type: Boolean,
      default: false,
    },
    minItemWidth: {
      type: String,
      default: '250px',
    },
    maxItemWidth: {
      type: String,
      default: '1fr',
    },
    
    // Classes customizadas
    customClass: {
      type: String,
      default: '',
    },
    
    // Responsividade
    responsive: {
      type: Boolean,
      default: true,
    },
    
    // Masonry layout
    masonry: {
      type: Boolean,
      default: false,
    },
    
    // Densidade
    dense: {
      type: Boolean,
      default: false,
    },
  },
  
  computed: {
    gridClasses() {
      const classes = ['grid-container'];
      
      // Base grid
      classes.push('grid');
      
      // Column classes
      if (!this.autoFit && !this.autoFill) {
        classes.push(this.getColumnClasses());
      }
      
      // Gap classes
      classes.push(this.getGapClasses());
      
      // Alignment classes
      if (this.alignItems !== 'stretch') {
        classes.push(`items-${this.alignItems}`);
      }
      
      if (this.justifyItems !== 'stretch') {
        classes.push(`justify-items-${this.justifyItems}`);
      }
      
      if (this.justifyContent !== 'start') {
        classes.push(`justify-${this.justifyContent}`);
      }
      
      if (this.alignContent !== 'start') {
        classes.push(`content-${this.alignContent}`);
      }
      
      // Dense layout
      if (this.dense) {
        classes.push('grid-flow-dense');
      }
      
      // Masonry (using CSS Grid approximation)
      if (this.masonry) {
        classes.push('grid-masonry');
      }
      
      // Custom class
      if (this.customClass) {
        classes.push(this.customClass);
      }
      
      return classes.join(' ');
    },
    
    gridStyles() {
      const styles = {};
      
      // Auto-fit or auto-fill
      if (this.autoFit || this.autoFill) {
        const repeatType = this.autoFit ? 'auto-fit' : 'auto-fill';
        styles.gridTemplateColumns = `repeat(${repeatType}, minmax(${this.minItemWidth}, ${this.maxItemWidth}))`;
      }
      
      // Height
      if (this.minHeight) {
        styles.minHeight = this.minHeight;
      }
      
      if (this.height) {
        styles.height = this.height;
      }
      
      // Masonry approximation
      if (this.masonry) {
        styles.gridAutoRows = '10px';
      }
      
      return styles;
    },
  },
  
  methods: {
    getColumnClasses() {
      const classes = [];
      
      // Base columns
      if (this.cols !== 'auto') {
        if (this.cols === 1) classes.push('grid-cols-1');
        else if (this.cols === 2) classes.push('grid-cols-2');
        else if (this.cols === 3) classes.push('grid-cols-3');
        else if (this.cols === 4) classes.push('grid-cols-4');
        else if (this.cols === 5) classes.push('grid-cols-5');
        else if (this.cols === 6) classes.push('grid-cols-6');
        else if (this.cols === 12) classes.push('grid-cols-12');
      }
      
      // Responsive columns
      if (this.colsSm) {
        if (this.colsSm === 1) classes.push('sm:grid-cols-1');
        else if (this.colsSm === 2) classes.push('sm:grid-cols-2');
        else if (this.colsSm === 3) classes.push('sm:grid-cols-3');
        else if (this.colsSm === 4) classes.push('sm:grid-cols-4');
        else if (this.colsSm === 5) classes.push('sm:grid-cols-5');
        else if (this.colsSm === 6) classes.push('sm:grid-cols-6');
        else if (this.colsSm === 12) classes.push('sm:grid-cols-12');
      }
      
      if (this.colsMd) {
        if (this.colsMd === 1) classes.push('md:grid-cols-1');
        else if (this.colsMd === 2) classes.push('md:grid-cols-2');
        else if (this.colsMd === 3) classes.push('md:grid-cols-3');
        else if (this.colsMd === 4) classes.push('md:grid-cols-4');
        else if (this.colsMd === 5) classes.push('md:grid-cols-5');
        else if (this.colsMd === 6) classes.push('md:grid-cols-6');
        else if (this.colsMd === 12) classes.push('md:grid-cols-12');
      }
      
      if (this.colsLg) {
        if (this.colsLg === 1) classes.push('lg:grid-cols-1');
        else if (this.colsLg === 2) classes.push('lg:grid-cols-2');
        else if (this.colsLg === 3) classes.push('lg:grid-cols-3');
        else if (this.colsLg === 4) classes.push('lg:grid-cols-4');
        else if (this.colsLg === 5) classes.push('lg:grid-cols-5');
        else if (this.colsLg === 6) classes.push('lg:grid-cols-6');
        else if (this.colsLg === 12) classes.push('lg:grid-cols-12');
      }
      
      if (this.colsXl) {
        if (this.colsXl === 1) classes.push('xl:grid-cols-1');
        else if (this.colsXl === 2) classes.push('xl:grid-cols-2');
        else if (this.colsXl === 3) classes.push('xl:grid-cols-3');
        else if (this.colsXl === 4) classes.push('xl:grid-cols-4');
        else if (this.colsXl === 5) classes.push('xl:grid-cols-5');
        else if (this.colsXl === 6) classes.push('xl:grid-cols-6');
        else if (this.colsXl === 12) classes.push('xl:grid-cols-12');
      }
      
      return classes.join(' ');
    },
    
    getGapClasses() {
      const classes = [];
      
      // Gap sizes
      const gapSizes = {
        none: '0',
        small: '2',
        default: '4',
        large: '6',
        xl: '8',
      };
      
      if (this.gapX && this.gapY) {
        classes.push(`gap-x-${gapSizes[this.gapX] || gapSizes.default}`);
        classes.push(`gap-y-${gapSizes[this.gapY] || gapSizes.default}`);
      } else if (this.gapX) {
        classes.push(`gap-x-${gapSizes[this.gapX] || gapSizes.default}`);
      } else if (this.gapY) {
        classes.push(`gap-y-${gapSizes[this.gapY] || gapSizes.default}`);
      } else {
        classes.push(`gap-${gapSizes[this.gap] || gapSizes.default}`);
      }
      
      return classes.join(' ');
    },
  },
};
</script>

<style scoped>
.grid-container {
  width: 100%;
}

/* Masonry approximation using CSS Grid */
.grid-masonry {
  grid-auto-flow: row dense;
}

.grid-masonry > * {
  grid-row-end: span var(--grid-row-span, 1);
}

/* Responsive adjustments */
@media (max-width: 640px) {
  .grid-container {
    padding: 0 1rem;
  }
}

/* Auto-sizing utilities */
.grid-auto-fit {
  grid-template-columns: repeat(auto-fit, minmax(var(--min-item-width, 250px), 1fr));
}

.grid-auto-fill {
  grid-template-columns: repeat(auto-fill, minmax(var(--min-item-width, 250px), 1fr));
}
</style>

