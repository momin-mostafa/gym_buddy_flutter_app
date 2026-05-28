import 'package:flutter/material.dart';
import 'package:gym_buddy/exercise_routine/add_routine.w.dart';
import 'package:gym_buddy/exercises/exercise.m.dart';
import 'package:gym_buddy/exercises/exercise.supabase.data_source.dart'
    show ExerciseSupabaseDataSource;

class AddRoutineView extends StatefulWidget {
  const AddRoutineView({super.key});

  @override
  State<AddRoutineView> createState() => _AddRoutineViewState();
}

class _AddRoutineViewState extends State<AddRoutineView> {
  List<ExerciseInfo> data = [];

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  Future<void> getAllData() async {
    data = await ExerciseSupabaseDataSource().fetchAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: ListTile(title: Text(data[index].name ?? '')),
                  onTap: () async => await showDialog(
                    context: context,
                    builder: (context) {
                      return AddRoutineWidget(exerciseInfo: data[index]);
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
