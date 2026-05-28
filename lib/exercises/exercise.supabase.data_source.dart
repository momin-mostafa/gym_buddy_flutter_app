import 'package:gym_buddy/exercises/exercise.m.dart';
import 'package:gym_buddy/interface/data_source.interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExerciseSupabaseDataSource implements DataSource<ExerciseInfo> {
  final functions = Supabase.instance.client.functions;

  @override
  Future<List<ExerciseInfo>> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<ExerciseInfo>> fetchAllData() async {
    final response = await functions.invoke('fetch-all-excercise');
    return (response.data as List)
        .map((e) => ExerciseInfo.fromJson(e))
        .toList();
  }

  @override
  Future<ExerciseInfo> fetchDataForId(int id) {
    // TODO: implement fetchDataForId
    throw UnimplementedError();
  }

  @override
  Future<List<ExerciseInfo>> insertData(data) {
    // TODO: implement insertData
    throw UnimplementedError();
  }

  @override
  Future<List<ExerciseInfo>> updateData(data) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
