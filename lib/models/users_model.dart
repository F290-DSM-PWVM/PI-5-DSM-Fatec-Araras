class UsersModel {
  int id = 0;
  String fullName = '';
  String email = '';
  String password = '';
  String? confirmPassword = '';
  String? insertedAt = '';
  String? updatedAt = '';

  UsersModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.confirmPassword,
    this.insertedAt,
    this.updatedAt,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    password = json['password'];
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['inserted_at'] = insertedAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  void encryptPassword() {
    password.toUpperCase();
  }

  String userValidations() {
    if (fullName.isEmpty) {
      return 'O campo Nome deve ser preenchido';
    }

    if (email.isEmpty) {
      return 'O campo E-mail deve ser preenchido';
    }

    String validateEmail = _validateEmail(email);

    if (validateEmail.length > 1) {
      return validateEmail;
    }

    if (password.isEmpty || confirmPassword!.isEmpty) {
      return 'Ambos campos de senha ser preenchido';
    }

    if (password != confirmPassword) {
      return 'As senhas informadas não correspondem';
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
