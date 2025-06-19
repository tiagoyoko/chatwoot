import 'package:intl/intl.dart';

class AppDateUtils {
  static const String defaultDateFormat = 'dd/MM/yyyy';
  static const String defaultTimeFormat = 'HH:mm';
  static const String defaultDateTimeFormat = 'dd/MM/yyyy HH:mm';
  
  /// Formata uma data para string usando o formato padrão
  static String formatDate(DateTime date, {String? format}) {
    final formatter = DateFormat(format ?? defaultDateFormat);
    return formatter.format(date);
  }
  
  /// Formata uma hora para string usando o formato padrão
  static String formatTime(DateTime time, {String? format}) {
    final formatter = DateFormat(format ?? defaultTimeFormat);
    return formatter.format(time);
  }
  
  /// Formata data e hora para string usando o formato padrão
  static String formatDateTime(DateTime dateTime, {String? format}) {
    final formatter = DateFormat(format ?? defaultDateTimeFormat);
    return formatter.format(dateTime);
  }
  
  /// Retorna uma string de tempo relativo (ex: "há 5 minutos")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inSeconds < 60) {
      return 'agora';
    } else if (difference.inMinutes < 60) {
      return 'há ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'há ${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return 'há ${difference.inDays}d';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'há ${weeks}sem';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return 'há ${months}mês';
    } else {
      final years = (difference.inDays / 365).floor();
      return 'há ${years}ano';
    }
  }
  
  /// Verifica se uma data é hoje
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  /// Verifica se uma data é ontem
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }
  
  /// Retorna o início do dia para uma data
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  /// Retorna o fim do dia para uma data
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
  
  /// Converte timestamp Unix para DateTime
  static DateTime fromUnixTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
  
  /// Converte DateTime para timestamp Unix
  static int toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }
}

