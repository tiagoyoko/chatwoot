import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../error/exceptions.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw StorageException('Erro ao inicializar armazenamento local');
    }
  }

  SharedPreferences get _preferences {
    if (_prefs == null) {
      throw StorageException('Armazenamento local não foi inicializado');
    }
    return _prefs!;
  }

  /// Salva uma string
  Future<bool> setString(String key, String value) async {
    try {
      return await _preferences.setString(key, value);
    } catch (e) {
      throw StorageException('Erro ao salvar string: $key');
    }
  }

  /// Recupera uma string
  String? getString(String key) {
    try {
      return _preferences.getString(key);
    } catch (e) {
      throw StorageException('Erro ao recuperar string: $key');
    }
  }

  /// Salva um inteiro
  Future<bool> setInt(String key, int value) async {
    try {
      return await _preferences.setInt(key, value);
    } catch (e) {
      throw StorageException('Erro ao salvar inteiro: $key');
    }
  }

  /// Recupera um inteiro
  int? getInt(String key) {
    try {
      return _preferences.getInt(key);
    } catch (e) {
      throw StorageException('Erro ao recuperar inteiro: $key');
    }
  }

  /// Salva um double
  Future<bool> setDouble(String key, double value) async {
    try {
      return await _preferences.setDouble(key, value);
    } catch (e) {
      throw StorageException('Erro ao salvar double: $key');
    }
  }

  /// Recupera um double
  double? getDouble(String key) {
    try {
      return _preferences.getDouble(key);
    } catch (e) {
      throw StorageException('Erro ao recuperar double: $key');
    }
  }

  /// Salva um boolean
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _preferences.setBool(key, value);
    } catch (e) {
      throw StorageException('Erro ao salvar boolean: $key');
    }
  }

  /// Recupera um boolean
  bool? getBool(String key) {
    try {
      return _preferences.getBool(key);
    } catch (e) {
      throw StorageException('Erro ao recuperar boolean: $key');
    }
  }

  /// Salva uma lista de strings
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      return await _preferences.setStringList(key, value);
    } catch (e) {
      throw StorageException('Erro ao salvar lista de strings: $key');
    }
  }

  /// Recupera uma lista de strings
  List<String>? getStringList(String key) {
    try {
      return _preferences.getStringList(key);
    } catch (e) {
      throw StorageException('Erro ao recuperar lista de strings: $key');
    }
  }

  /// Salva um objeto JSON
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await _preferences.setString(key, jsonString);
    } catch (e) {
      throw StorageException('Erro ao salvar JSON: $key');
    }
  }

  /// Recupera um objeto JSON
  Map<String, dynamic>? getJson(String key) {
    try {
      final jsonString = _preferences.getString(key);
      if (jsonString == null) return null;
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw StorageException('Erro ao recuperar JSON: $key');
    }
  }

  /// Salva uma lista de objetos JSON
  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await _preferences.setString(key, jsonString);
    } catch (e) {
      throw StorageException('Erro ao salvar lista JSON: $key');
    }
  }

  /// Recupera uma lista de objetos JSON
  List<Map<String, dynamic>>? getJsonList(String key) {
    try {
      final jsonString = _preferences.getString(key);
      if (jsonString == null) return null;
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      throw StorageException('Erro ao recuperar lista JSON: $key');
    }
  }

  /// Remove uma chave
  Future<bool> remove(String key) async {
    try {
      return await _preferences.remove(key);
    } catch (e) {
      throw StorageException('Erro ao remover chave: $key');
    }
  }

  /// Verifica se uma chave existe
  bool containsKey(String key) {
    try {
      return _preferences.containsKey(key);
    } catch (e) {
      throw StorageException('Erro ao verificar chave: $key');
    }
  }

  /// Limpa todos os dados
  Future<bool> clear() async {
    try {
      return await _preferences.clear();
    } catch (e) {
      throw StorageException('Erro ao limpar armazenamento');
    }
  }

  /// Recupera todas as chaves
  Set<String> getKeys() {
    try {
      return _preferences.getKeys();
    } catch (e) {
      throw StorageException('Erro ao recuperar chaves');
    }
  }

  /// Recarrega as preferências
  Future<void> reload() async {
    try {
      await _preferences.reload();
    } catch (e) {
      throw StorageException('Erro ao recarregar preferências');
    }
  }
}

