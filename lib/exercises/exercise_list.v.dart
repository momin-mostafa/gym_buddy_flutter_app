import 'package:flutter/material.dart';
import 'package:gym_buddy/exercises/exercise.m.dart';
import 'package:gym_buddy/exercises/exercise.supabase.data_source.dart';
import 'package:gym_buddy/exercises/exercise_details.v.dart'
    show ExerciseDetailsView;

class ExerciseListView extends StatefulWidget {
  const ExerciseListView({super.key});

  @override
  State<ExerciseListView> createState() => _ExerciseListViewState();
}

class _ExerciseListViewState extends State<ExerciseListView> {
  List<ExerciseInfo> data = [];

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  Future<void> getAllData() async {
    data = await ExerciseSupabaseDataSource().fetchAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exercise List",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(data[index].name ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseDetailsView(data: data[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
