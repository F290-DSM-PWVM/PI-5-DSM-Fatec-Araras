import 'package:f290_pi_5/models/login_model.dart';
import 'package:f290_pi_5/models/users_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersRepository {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<UsersModel>> findByEmail(String email) async {
    final response =
        await supabase.from('users').select('*').eq('email', email);

    final users =
        response.map<UsersModel>((c) => UsersModel.fromJson(c)).toList();

    return users;
  }

  Future<UsersModel?> findAuthenticatedUser(LoginModel login) async {
    final response = await supabase
        .from('users')
        .select('*')
        .match({'email': login.email, 'password': login.password});

    if (response.isEmpty) {
      return null;
    }

    final user = UsersModel.fromJson(response[0]);

    return user;
  }

  Future<List<Map<String, dynamic>>> create(UsersModel user) async {
    return await supabase.from('users').insert({
      'full_name': user.fullName,
      'email': user.email,
      'password': user.password
    }).select('id');
  }

  void delete(int userId) async {
    await supabase.from('users').delete().eq('id', userId);
  }
}
