import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

import '../../interface/data_source.interface.dart' show DataSource;
import '../model/nutrients.dto.dart' show NutrientsDTO;

class NutrientsSupabaseApiDataSource implements DataSource<NutrientsDTO> {
  final client = Supabase.instance.client;

  final String getAPI = "get-ingredients";
  final String insertAPI = "insert-ingredients";

  @override
  Future<List<NutrientsDTO>> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<NutrientsDTO>> fetchAllData() async {
    try {
      final response = await client.functions.invoke(getAPI);
      if (response.data == null) return [];
      return (response.data as List)
          .map((e) => NutrientsDTO.fromJson(e))
          .toList();
    } catch (e, st) {
      log(
        "NutrientsSupabaseApiDataSource.fetchAllData.$getAPI",
        error: e,
        stackTrace: st,
      );
      throw "Unable to get data";
    }
  }

  @override
  Future<NutrientsDTO?> fetchDataForId(int id) {
    // TODO: implement fetchDataForId
    throw UnimplementedError();
  }

  @override
  Future<List<NutrientsDTO>> insertData(NutrientsDTO dto) async {
    try {
      final response = await client.functions.invoke(
        insertAPI,
        body: {'ingredient_id': dto.id, 'quantity_in_gram': dto.unitG},
      );
      if (response.data == null) return [];
      return (response.data as List)
          .map((e) => NutrientsDTO.fromJson(e))
          .toList();
    } catch (e, st) {
      log(
        "NutrientsSupabaseApiDataSource.insertData.$insertAPI",
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }

  @override
  Future<List<NutrientsDTO>> updateData(NutrientsDTO data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
