# Chatwoot Flutter App

Aplicativo Flutter para o Chatwoot - Customer Engagement Suite.

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── app/                         # Configurações globais da aplicação
│   ├── app.dart                # Widget principal da aplicação
│   ├── config/                 # Configurações da aplicação
│   │   └── app_config.dart     # Configurações gerais
│   ├── routes/                 # Sistema de rotas
│   │   └── app_routes.dart     # Definição das rotas
│   └── theme/                  # Tema da aplicação
│       └── app_theme.dart      # Configuração do tema
├── features/                   # Funcionalidades da aplicação
│   ├── auth/                   # Autenticação
│   │   └── presentation/
│   │       └── pages/
│   │           └── login_page.dart
│   ├── chat/                   # Conversas e mensagens
│   │   └── presentation/
│   │       └── pages/
│   │           └── chat_list_page.dart
│   ├── dashboard/              # Dashboard principal
│   │   └── presentation/
│   │       └── pages/
│   │           └── dashboard_page.dart
│   └── profile/                # Perfil do usuário
│       └── presentation/
│           └── pages/
│               └── profile_page.dart
├── shared/                     # Recursos compartilhados
│   ├── constants/              # Constantes da aplicação
│   │   ├── app_colors.dart     # Cores do tema
│   │   └── app_constants.dart  # Constantes gerais
│   ├── models/                 # Modelos de dados
│   │   ├── user_model.dart     # Modelo do usuário
│   │   └── conversation_model.dart # Modelo de conversas
│   ├── utils/                  # Utilitários
│   │   ├── date_utils.dart     # Utilitários de data
│   │   └── validators.dart     # Validadores
│   ├── widgets/                # Widgets reutilizáveis
│   │   └── splash_screen.dart  # Tela de splash
│   └── services/               # Serviços compartilhados
└── core/                       # Funcionalidades centrais
    ├── network/                # Configurações de rede
    │   └── api_client.dart     # Cliente HTTP
    ├── storage/                # Armazenamento local
    │   └── local_storage.dart  # Gerenciamento de storage
    ├── error/                  # Tratamento de erros
    │   └── exceptions.dart     # Exceções customizadas
    └── extensions/             # Extensões de tipos
```

## 🏗️ Arquitetura

O projeto segue uma arquitetura limpa (Clean Architecture) com as seguintes camadas:

- **Presentation**: Widgets, páginas e gerenciamento de estado
- **Domain**: Regras de negócio, entidades e casos de uso
- **Data**: Repositórios, fontes de dados e modelos

### Organização por Features

Cada funcionalidade é organizada em sua própria pasta dentro de `features/`, contendo:

- `data/`: Repositórios e fontes de dados
- `domain/`: Entidades, casos de uso e contratos
- `presentation/`: Páginas, widgets e gerenciamento de estado

## 🎨 Design System

### Cores

As cores principais estão definidas em `shared/constants/app_colors.dart`:

- **Primary**: #1F93FF (Azul Chatwoot)
- **Secondary**: #44CE4B (Verde)
- **Success**: #44CE4B
- **Warning**: #FFC532
- **Error**: #E53E3E

### Tema

O tema da aplicação está configurado em `app/theme/app_theme.dart` com suporte a:

- Modo claro e escuro
- Material Design 3
- Tipografia personalizada
- Componentes customizados

## 📱 Funcionalidades

### Implementadas

- ✅ Estrutura base do projeto
- ✅ Sistema de rotas
- ✅ Tela de splash
- ✅ Tela de login
- ✅ Dashboard principal
- ✅ Lista de conversas
- ✅ Perfil do usuário
- ✅ Tema claro/escuro
- ✅ Modelos de dados
- ✅ Cliente HTTP
- ✅ Armazenamento local
- ✅ Tratamento de erros

### A Implementar

- ⏳ Autenticação completa
- ⏳ WebSocket para mensagens em tempo real
- ⏳ Envio de mensagens
- ⏳ Upload de arquivos
- ⏳ Notificações push
- ⏳ Busca e filtros
- ⏳ Configurações avançadas
- ⏳ Testes unitários e de integração

## 🚀 Como Executar

1. **Instalar dependências:**
   ```bash
   flutter pub get
   ```

2. **Executar o app:**
   ```bash
   flutter run
   ```

3. **Gerar código (se necessário):**
   ```bash
   flutter packages pub run build_runner build
   ```

## 📦 Dependências Principais

- **flutter_bloc**: Gerenciamento de estado
- **http/dio**: Cliente HTTP
- **shared_preferences**: Armazenamento local
- **cached_network_image**: Cache de imagens
- **firebase_messaging**: Notificações push
- **intl**: Internacionalização

## 🧪 Testes

```bash
# Executar todos os testes
flutter test

# Executar testes com coverage
flutter test --coverage
```

## 📝 Convenções

### Nomenclatura

- **Arquivos**: snake_case (ex: `user_model.dart`)
- **Classes**: PascalCase (ex: `UserModel`)
- **Variáveis**: camelCase (ex: `userName`)
- **Constantes**: UPPER_SNAKE_CASE (ex: `API_BASE_URL`)

### Estrutura de Commits

```
tipo(escopo): descrição

feat: nova funcionalidade
fix: correção de bug
docs: documentação
style: formatação
refactor: refatoração
test: testes
chore: tarefas de manutenção
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

