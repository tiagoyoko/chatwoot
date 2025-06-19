import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../app/config/app_config.dart';
import '../error/exceptions.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final http.Client _client = http.Client();
  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
      final response = await _client
          .get(url, headers: _headers)
          .timeout(AppConfig.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Sem conexão com a internet');
    } on HttpException {
      throw NetworkException('Erro de conexão');
    } catch (e) {
      throw ServerException('Erro interno do servidor');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
      final response = await _client
          .post(
            url,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(AppConfig.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Sem conexão com a internet');
    } on HttpException {
      throw NetworkException('Erro de conexão');
    } catch (e) {
      throw ServerException('Erro interno do servidor');
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
      final response = await _client
          .put(
            url,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(AppConfig.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Sem conexão com a internet');
    } on HttpException {
      throw NetworkException('Erro de conexão');
    } catch (e) {
      throw ServerException('Erro interno do servidor');
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
      final response = await _client
          .delete(url, headers: _headers)
          .timeout(AppConfig.connectionTimeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Sem conexão com a internet');
    } on HttpException {
      throw NetworkException('Erro de conexão');
    } catch (e) {
      throw ServerException('Erro interno do servidor');
    }
  }

  Future<Map<String, dynamic>> multipartRequest(
    String method,
    String endpoint, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}/$endpoint');
      final request = http.MultipartRequest(method, url);

      // Adicionar headers
      request.headers.addAll(_headers);

      // Adicionar campos
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Adicionar arquivos
      if (files != null) {
        request.files.addAll(files);
      }

      final streamedResponse = await request.send().timeout(AppConfig.connectionTimeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Sem conexão com a internet');
    } on HttpException {
      throw NetworkException('Erro de conexão');
    } catch (e) {
      throw ServerException('Erro interno do servidor');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (response.body.isEmpty) {
          return {};
        }
        return jsonDecode(response.body) as Map<String, dynamic>;
      case 400:
        throw BadRequestException('Requisição inválida');
      case 401:
        throw UnauthorizedException('Não autorizado');
      case 403:
        throw ForbiddenException('Acesso negado');
      case 404:
        throw NotFoundException('Recurso não encontrado');
      case 422:
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        throw ValidationException(
          errorData['message'] as String? ?? 'Dados inválidos',
          errorData['errors'] as Map<String, dynamic>?,
        );
      case 500:
      case 502:
      case 503:
        throw ServerException('Erro interno do servidor');
      default:
        throw ServerException('Erro desconhecido: ${response.statusCode}');
    }
  }

  void dispose() {
    _client.close();
  }
}

