class AppConstants {
  // Configurações da API
  static const String baseUrl = 'https://api.chatwoot.com';
  static const String apiVersion = 'v1';
  static const Duration requestTimeout = Duration(seconds: 30);
  
  // Configurações de armazenamento
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String settingsKey = 'app_settings';
  
  // Configurações de paginação
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Configurações de chat
  static const int maxMessageLength = 1000;
  static const Duration typingIndicatorTimeout = Duration(seconds: 3);
  
  // Configurações de mídia
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];
  
  // Configurações de notificação
  static const String notificationChannelId = 'chatwoot_notifications';
  static const String notificationChannelName = 'Chatwoot Notifications';
  
  // Configurações de tema
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
}

