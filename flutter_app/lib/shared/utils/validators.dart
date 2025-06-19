class Validators {
  /// Valida se o email tem formato válido
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Digite um email válido';
    }
    
    return null;
  }
  
  /// Valida se a senha atende aos critérios mínimos
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    
    return null;
  }
  
  /// Valida se o nome não está vazio
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome é obrigatório';
    }
    
    if (value.trim().length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    
    return null;
  }
  
  /// Valida se o telefone tem formato válido
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone é obrigatório';
    }
    
    // Remove caracteres não numéricos
    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (cleanPhone.length < 10 || cleanPhone.length > 11) {
      return 'Digite um telefone válido';
    }
    
    return null;
  }
  
  /// Valida se o campo não está vazio
  static String? validateRequired(String? value, {String fieldName = 'Campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }
  
  /// Valida se o valor tem comprimento mínimo
  static String? validateMinLength(String? value, int minLength, {String fieldName = 'Campo'}) {
    if (value == null || value.length < minLength) {
      return '$fieldName deve ter pelo menos $minLength caracteres';
    }
    return null;
  }
  
  /// Valida se o valor tem comprimento máximo
  static String? validateMaxLength(String? value, int maxLength, {String fieldName = 'Campo'}) {
    if (value != null && value.length > maxLength) {
      return '$fieldName deve ter no máximo $maxLength caracteres';
    }
    return null;
  }
  
  /// Valida se as senhas coincidem
  static String? validatePasswordConfirmation(String? password, String? confirmation) {
    if (confirmation == null || confirmation.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    
    if (password != confirmation) {
      return 'Senhas não coincidem';
    }
    
    return null;
  }
  
  /// Valida se o valor é um número válido
  static String? validateNumber(String? value, {String fieldName = 'Campo'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName é obrigatório';
    }
    
    if (double.tryParse(value) == null) {
      return '$fieldName deve ser um número válido';
    }
    
    return null;
  }
  
  /// Valida se o valor está dentro de um intervalo
  static String? validateRange(String? value, double min, double max, {String fieldName = 'Campo'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName é obrigatório';
    }
    
    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName deve ser um número válido';
    }
    
    if (number < min || number > max) {
      return '$fieldName deve estar entre $min e $max';
    }
    
    return null;
  }
  
  /// Valida URL
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL é obrigatória';
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );
    
    if (!urlRegex.hasMatch(value)) {
      return 'Digite uma URL válida';
    }
    
    return null;
  }
}

