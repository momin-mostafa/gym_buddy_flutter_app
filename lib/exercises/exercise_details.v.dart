import 'package:flutter/material.dart';
import 'package:gym_buddy/exercises/exercise.m.dart';

class ExerciseDetailsView extends StatefulWidget {
  const ExerciseDetailsView({super.key, required this.data});

  final ExerciseInfo data;

  @override
  State<ExerciseDetailsView> createState() => _ExerciseDetailsViewState();
}

class _ExerciseDetailsViewState extends State<ExerciseDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.name ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        crossAxisAlignment: .stretch,
        spacing: 8,
        children: [
          SizedBox(),
          if (widget.data.visualGuideUrl != null &&
              widget.data.visualGuideUrl!.isNotEmpty)
            Image.network(
              widget.data.visualGuideUrl!,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          Text(widget.data.name ?? ''),
          Text(widget.data.id.toString()),
        ],
      ),
    );
  }
}
