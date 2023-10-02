class ValidationProvider {
  // Только буквы
  bool isLoginValid(String login) {
    return RegExp(r'[a-zA-Zа-яА-Я]{5,}').hasMatch(login);
  }

  // Строчные и прописные буквы, цифры, спецсимволы. Минимум 8 символов
  bool isPasswordValid(String password) {
    return RegExp(
            r'(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-ZА-Я])(?=.*[a-zа-я]).*$')
        .hasMatch(password);
  }

  // Только буквы
  bool isUIDValid(String uid) {
    return RegExp(r'[0-9]{10}').hasMatch(uid);
  }
}
