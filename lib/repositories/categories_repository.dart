import 'package:f290_pi_5/models/categories_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesRepository {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<CategoriesModel>> findAll() async {
    final response = await supabase.from('categories').select('*');

    final categories = response
        .map<CategoriesModel>((c) => CategoriesModel.fromJson(c))
        .toList();

    return categories;
  }
}
