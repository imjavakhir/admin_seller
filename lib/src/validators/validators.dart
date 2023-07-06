abstract class Validators {
  static String? empty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не должно быть пустым';
    }

    return null;
  }
  

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не должно быть пустым';
    }
    if (value.length < 14) {
      return 'Это недействительный номер телефона';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Не должно быть пустым';
    }
    if (value.length < 8) {
      return 'Должно быть не менее 8 символов';
    }
    return null;
  }
}
