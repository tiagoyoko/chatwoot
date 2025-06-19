class AppConfig {
  static const String appName = 'Chatwoot';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  
  // Configurações de ambiente
  static const bool isDebug = true;
  static const bool enableLogging = true;
  
  // URLs da API
  static const String baseUrl = 'https://api.chatwoot.com';
  static const String websocketUrl = 'wss://api.chatwoot.com/cable';
  
  // Configurações de autenticação
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const Duration tokenExpirationTime = Duration(hours: 24);
  
  // Configurações de cache
  static const Duration cacheExpiration = Duration(hours: 1);
  static const int maxCacheSize = 50 * 1024 * 1024; // 50MB
  
  // Configurações de rede
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  
  // Configurações de notificação
  static const String fcmServerKey = '';
  static const String notificationChannelId = 'chatwoot_notifications';
  static const String notificationChannelName = 'Chatwoot Notifications';
  static const String notificationChannelDescription = 'Notificações do Chatwoot';
  
  // Configurações de mídia
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB
  static const int maxDocumentSize = 10 * 1024 * 1024; // 10MB
  
  static const List<String> supportedImageFormats = [
    'jpg', 'jpeg', 'png', 'gif', 'webp'
  ];
  
  static const List<String> supportedVideoFormats = [
    'mp4', 'mov', 'avi', 'mkv'
  ];
  
  static const List<String> supportedDocumentFormats = [
    'pdf', 'doc', 'docx', 'txt', 'rtf'
  ];
}

