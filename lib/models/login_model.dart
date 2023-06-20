class LoginModel {
  String email = '';
  String password = '';

  LoginModel({
    required this.email,
    required this.password,
  });

  void encryptPassword() {
    password.toUpperCase();
  }

  String loginValidations() {
    if (email.isEmpty) {
      return 'O campo E-mail deve ser preenchido';
    }

    if (password.isEmpty) {
      return 'O campo de senha deve ser preenchido';
    }

    String validateEmail = _validateEmail(email);

    if (validateEmail.length > 1) {
      return validateEmail;
    }

    return '';
  }

  String _validateEmail(String email) {
    String message = '';
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegex.hasMatch(email)) {
      message = 'O campo E-mail não contém um e-mail válido';
    }

    return message;
  }
}
