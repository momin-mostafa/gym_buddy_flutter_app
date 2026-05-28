import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

import '../../interface/data_source.interface.dart' show DataSource;
import '../model/nutrients.dto.dart' show NutrientsDTO;

class NutrientsSupabaseDataSource implements DataSource<NutrientsDTO> {
  final database = Supabase.instance.client.from('ingredients');

  @override
  Future<List<NutrientsDTO>> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<NutrientsDTO>> fetchAllData() async {
    List<NutrientsDTO> nutrients = [];

    try {
      final response = await database.select();
      if (response.isEmpty) return nutrients;
      for (var element in response) {
        nutrients.add(NutrientsDTO.fromJson(element));
      }
    } catch (e, stackTrace) {
      log(
        'NutrientsSupabaseDataSource.fetchAllData.parse_error',
        error: e,
        stackTrace: stackTrace,
      );
    }

    return nutrients;
  }

  @override
  Future<NutrientsDTO?> fetchDataForId(int id) async {
    try {
      final response = await database.select().eq('id', id).single();
      return NutrientsDTO.fromJson(response);
    } catch (e, stackTrace) {
      log(
        'NutrientsSupabaseDataSource.fetchDataForId.parse_error',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<List<NutrientsDTO>> insertData(NutrientsDTO data) {
    // TODO: implement insertData
    throw UnimplementedError();
  }

  @override
  Future<List<NutrientsDTO>> updateData(NutrientsDTO data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
