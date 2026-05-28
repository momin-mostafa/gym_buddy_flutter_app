import 'package:flutter/material.dart';
import 'package:gym_buddy/exercises/exercise.m.dart';

class AddRoutineWidget extends StatefulWidget {
  const AddRoutineWidget({super.key, required this.exerciseInfo});

  final ExerciseInfo exerciseInfo;

  @override
  State<AddRoutineWidget> createState() => _AddRoutineWidgetState();
}

class _AddRoutineWidgetState extends State<AddRoutineWidget> {
  bool addToCurrentCycle = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      children: [
        Stack(
          children: [
            Card(
              clipBehavior: .hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 8,
                  children: [
                    ListTile(
                      leading:
                          (widget.exerciseInfo.visualGuideUrl != null &&
                              widget.exerciseInfo.visualGuideUrl!.isNotEmpty)
                          ? Image.network(widget.exerciseInfo.visualGuideUrl!)
                          : null,
                      title: Text(widget.exerciseInfo.name ?? ''),
                      trailing: IconButton.filledTonal(
                        onPressed: Navigator.of(context).pop,
                        icon: Icon(Icons.cancel_outlined),
                      ),
                    ),
                    SizedBox(),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Notes"),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Reps"),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Weight"),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Number of set",
                            ),
                          ),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      value: addToCurrentCycle,
                      onChanged: (value) {
                        setState(() {
                          addToCurrentCycle = value ?? false;
                        });
                      },
                      title: Text("Add to current cycle"),
                    ),
                    FilledButton(onPressed: () {}, child: Text("Add")),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
