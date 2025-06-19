// Componentes base reutilizáveis para landing pages
// Localização: app/javascript/shared/components/widgets/

// Importação dos componentes
import ContainerSection from './ContainerSection.vue';
import CustomButton from './CustomButton.vue';
import SectionTitle from './SectionTitle.vue';
import Card from './Card.vue';
import Grid from './Grid.vue';

// Exportação nomeada para importação individual
export {
  ContainerSection,
  CustomButton,
  SectionTitle,
  Card,
  Grid,
};

// Exportação padrão como objeto para importação em lote
export default {
  ContainerSection,
  CustomButton,
  SectionTitle,
  Card,
  Grid,
};

// Plugin para instalação global no Vue
export const WidgetsPlugin = {
  install(app) {
    app.component('ContainerSection', ContainerSection);
    app.component('CustomButton', CustomButton);
    app.component('SectionTitle', SectionTitle);
    app.component('Card', Card);
    app.component('Grid', Grid);
  },
};

