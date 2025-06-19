# Componentes Base Reutilizáveis

Esta pasta contém componentes Vue.js base reutilizáveis para construção de landing pages e interfaces de usuário consistentes.

## 📁 Estrutura

```
widgets/
├── ContainerSection.vue    # Container responsivo para seções
├── CustomButton.vue        # Botão customizável com múltiplas variantes
├── SectionTitle.vue        # Títulos de seção com subtítulos e descrições
├── Card.vue               # Cards flexíveis para conteúdo
├── Grid.vue               # Sistema de grid responsivo
├── index.js               # Arquivo de exportação
└── README.md              # Esta documentação
```

## 🚀 Como Usar

### Importação Individual

```javascript
import { ContainerSection, CustomButton, SectionTitle } from '@/shared/components/widgets';
```

### Importação em Lote

```javascript
import WidgetComponents from '@/shared/components/widgets';
```

### Instalação Global (Plugin)

```javascript
import { WidgetsPlugin } from '@/shared/components/widgets';

app.use(WidgetsPlugin);
```

## 📖 Componentes

### 1. ContainerSection

Container responsivo para seções da página com configurações flexíveis de layout e espaçamento.

```vue
<template>
  <ContainerSection
    :padding="'large'"
    :background-color="'#f8f9fa'"
    :center-content="true"
  >
    <h1>Conteúdo da seção</h1>
  </ContainerSection>
</template>
```

**Props principais:**
- `fullWidth`: Remove limitação de largura máxima
- `padding`: Controla espaçamento interno ('none', 'small', 'default', 'large')
- `backgroundColor`: Cor de fundo personalizada
- `centerContent`: Centraliza conteúdo vertical e horizontalmente
- `minHeight`: Altura mínima da seção

### 2. CustomButton

Botão altamente customizável com múltiplas variantes, tamanhos e estados.

```vue
<template>
  <CustomButton
    variant="primary"
    size="large"
    :loading="isLoading"
    icon-left="fas fa-download"
    @click="handleClick"
  >
    Download Agora
  </CustomButton>
</template>
```

**Props principais:**
- `variant`: Estilo do botão ('primary', 'secondary', 'outline', 'ghost', 'danger', 'success', 'warning')
- `size`: Tamanho ('small', 'medium', 'large', 'xl')
- `loading`: Estado de carregamento com spinner
- `disabled`: Estado desabilitado
- `block`: Largura total
- `iconLeft/iconRight`: Ícones nas laterais

### 3. SectionTitle

Componente para títulos de seção com subtítulos, descrições e elementos decorativos.

```vue
<template>
  <SectionTitle
    subtitle="Nossos Serviços"
    title="Soluções Completas"
    description="Oferecemos uma gama completa de serviços para atender suas necessidades."
    :show-decorator="true"
    alignment="center"
  />
</template>
```

**Props principais:**
- `title`: Título principal (obrigatório)
- `subtitle`: Subtítulo/eyebrow text
- `description`: Descrição adicional
- `titleTag`: Tag HTML do título ('h1', 'h2', etc.)
- `alignment`: Alinhamento ('left', 'center', 'right')
- `showDecorator`: Mostra elemento decorativo
- `animated`: Adiciona animação de entrada

### 4. Card

Card flexível para exibição de conteúdo com header, body e footer opcionais.

```vue
<template>
  <Card
    title="Título do Card"
    subtitle="Subtítulo"
    description="Descrição do conteúdo do card."
    icon="fas fa-star"
    :hoverable="true"
    button-text="Saiba Mais"
    @button-click="handleButtonClick"
  />
</template>
```

**Props principais:**
- `title`: Título do card
- `subtitle`: Subtítulo
- `description`: Descrição
- `icon`: Ícone do header
- `image`: Imagem do header
- `variant`: Estilo ('default', 'outlined', 'elevated', 'flat')
- `hoverable`: Efeito hover
- `buttonText`: Texto do botão no footer

### 5. Grid

Sistema de grid responsivo baseado em CSS Grid com configurações flexíveis.

```vue
<template>
  <Grid
    :cols="3"
    :cols-md="2"
    :cols-sm="1"
    gap="large"
    :auto-fit="true"
    min-item-width="300px"
  >
    <Card v-for="item in items" :key="item.id" v-bind="item" />
  </Grid>
</template>
```

**Props principais:**
- `cols`: Número de colunas base
- `colsSm/colsMd/colsLg/colsXl`: Colunas responsivas
- `gap`: Espaçamento entre itens
- `autoFit/autoFill`: Layout automático
- `minItemWidth`: Largura mínima dos itens
- `alignItems/justifyItems`: Alinhamento dos itens

## 🎨 Personalização

### Cores e Temas

Todos os componentes suportam cores personalizadas através de props específicas:

```vue
<CustomButton
  :background-color="'#6366f1'"
  :text-color="'white'"
  :border-color="'#4f46e5'"
>
  Botão Personalizado
</CustomButton>
```

### Classes CSS Customizadas

Cada componente aceita classes CSS personalizadas:

```vue
<ContainerSection custom-class="my-custom-section">
  <!-- conteúdo -->
</ContainerSection>
```

### Slots

Os componentes utilizam slots para máxima flexibilidade:

```vue
<Card>
  <template #header>
    <div class="custom-header">Header personalizado</div>
  </template>
  
  <div class="custom-content">
    Conteúdo personalizado do card
  </div>
  
  <template #footer>
    <div class="custom-footer">Footer personalizado</div>
  </template>
</Card>
```

## 📱 Responsividade

Todos os componentes são responsivos por padrão e incluem:

- Breakpoints padrão do Tailwind CSS
- Ajustes automáticos de espaçamento
- Tipografia responsiva
- Layout adaptativo

## 🔧 Desenvolvimento

### Adicionando Novos Componentes

1. Crie o arquivo `.vue` na pasta `widgets/`
2. Adicione a exportação no `index.js`
3. Documente o uso neste README
4. Adicione testes se necessário

### Convenções

- Use PascalCase para nomes de componentes
- Props em camelCase
- Classes CSS com prefixo do componente
- Suporte a slots quando apropriado
- Documentação inline com JSDoc

## 🧪 Exemplos de Uso

### Landing Page Completa

```vue
<template>
  <div>
    <!-- Hero Section -->
    <ContainerSection
      :min-height="'100vh'"
      :center-content="true"
      background-gradient="linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
    >
      <div class="text-center text-white">
        <SectionTitle
          title="Bem-vindo ao Futuro"
          description="Transforme sua experiência com nossas soluções inovadoras"
          :animated="true"
          title-color="white"
          description-color="rgba(255,255,255,0.9)"
        />
        <CustomButton
          variant="outline"
          size="large"
          text-color="white"
          border-color="white"
          class="mt-8"
        >
          Começar Agora
        </CustomButton>
      </div>
    </ContainerSection>

    <!-- Features Section -->
    <ContainerSection padding="large">
      <SectionTitle
        subtitle="Recursos"
        title="Por que nos escolher?"
        alignment="center"
        :show-decorator="true"
        class="mb-12"
      />
      
      <Grid :cols="3" :cols-md="2" :cols-sm="1" gap="large">
        <Card
          v-for="feature in features"
          :key="feature.id"
          :title="feature.title"
          :description="feature.description"
          :icon="feature.icon"
          :hoverable="true"
          :animated="true"
        />
      </Grid>
    </ContainerSection>
  </div>
</template>
```

## 📄 Licença

Estes componentes fazem parte do projeto Chatwoot e seguem a mesma licença MIT.

