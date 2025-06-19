/// Exceção base para todas as exceções da aplicação
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message';
}

/// Exceções de rede
class NetworkException extends AppException {
  const NetworkException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exceções do servidor
class ServerException extends AppException {
  const ServerException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'ServerException: $message';
}

/// Exceção para requisições inválidas (400)
class BadRequestException extends AppException {
  const BadRequestException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'BadRequestException: $message';
}

/// Exceção para não autorizado (401)
class UnauthorizedException extends AppException {
  const UnauthorizedException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Exceção para acesso negado (403)
class ForbiddenException extends AppException {
  const ForbiddenException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'ForbiddenException: $message';
}

/// Exceção para recurso não encontrado (404)
class NotFoundException extends AppException {
  const NotFoundException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'NotFoundException: $message';
}

/// Exceção para dados inválidos (422)
class ValidationException extends AppException {
  final Map<String, dynamic>? errors;

  const ValidationException(String message, [this.errors, String? code]) 
      : super(message, code);

  @override
  String toString() => 'ValidationException: $message';
}

/// Exceções de cache
class CacheException extends AppException {
  const CacheException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'CacheException: $message';
}

/// Exceções de armazenamento local
class StorageException extends AppException {
  const StorageException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'StorageException: $message';
}

/// Exceções de autenticação
class AuthException extends AppException {
  const AuthException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'AuthException: $message';
}

/// Exceções de permissão
class PermissionException extends AppException {
  const PermissionException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'PermissionException: $message';
}

/// Exceções de formato de arquivo
class FileFormatException extends AppException {
  const FileFormatException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'FileFormatException: $message';
}

/// Exceções de tamanho de arquivo
class FileSizeException extends AppException {
  const FileSizeException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'FileSizeException: $message';
}

/// Exceções de timeout
class TimeoutException extends AppException {
  const TimeoutException(String message, [String? code]) : super(message, code);

  @override
  String toString() => 'TimeoutException: $message';
}

