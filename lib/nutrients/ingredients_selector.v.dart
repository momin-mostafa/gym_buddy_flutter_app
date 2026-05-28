import 'package:flutter/material.dart';
import 'package:gym_buddy/nutrients/model/nutrients.entity.dart';
import 'package:gym_buddy/nutrients/nutrients.vm.dart';
import 'package:provider/provider.dart';
import 'package:gym_buddy/extensions/date_formatter.extension.dart';

import '../user_interaction_tracker.dart' show UserInteractionTracker;

class IngredientsSelectorView extends StatefulWidget {
  const IngredientsSelectorView({super.key});

  @override
  State<IngredientsSelectorView> createState() =>
      _IngredientsSelectorViewState();
}

class _IngredientsSelectorViewState extends State<IngredientsSelectorView> {
  @override
  void initState() {
    context.read<NutrientsVM>().updateNutrientsList();
    UserInteractionTracker().onScreen("IngredientsSelectorView");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 300,
            // backgroundColor: Colors.white,
            // collapsedHeight: 100,
            // snap: true,
            // floating: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              background: Consumer<NutrientsVM>(
                builder: (context, vm, asyncSnapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        Text(
                          'Total Protein : ${vm.totalProteinForSelectedNutrients}',
                        ),
                        Text(
                          'Total Calories : ${vm.totalCaloriesForSelectedNutrients}',
                        ),
                        Text('Total Fat : ${vm.totalFatForSelectedNutrients}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        spacing: 8,
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            DateTime.now().format,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text("Protein Difficiency by 80g"),
                        ],
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    DateTime.now().format,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  IconButton(
                    onPressed: () async {
                      await context.read<NutrientsVM>().updateNutrientsList();
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return bottomSheet();
                        },
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          Consumer<NutrientsVM>(
            builder: (context, vm, asyncSnapshot) {
              return SliverList.builder(
                itemCount: vm.userSelectedNutrients.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(vm.userSelectedNutrients[index].name ?? ''),
                      subtitle: Text(
                        "${vm.userSelectedNutrients[index].userIntakeAmount}g",
                      ),
                      trailing: IconButton(
                        onPressed: () =>
                            vm.removeFromUserSelectedNutrientsList(index),
                        icon: Icon(Icons.delete_outline),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    final vm = context.watch<NutrientsVM>();
    final list = vm.nutrientsList;
    return ListView.builder(
      itemBuilder: (context, index) {
        final num initialAmount = 10;
        final Nutrients selectedNutrient = list[index];
        selectedNutrient.userIntakeAmount = initialAmount;
        return UserIntakeTile(nutrient: selectedNutrient);
      },
      itemCount: list.length,
    );
  }
}

class UserIntakeTile extends StatefulWidget {
  const UserIntakeTile({super.key, required this.nutrient});

  final Nutrients nutrient;

  @override
  State<UserIntakeTile> createState() => _UserIntakeTileState();
}

class _UserIntakeTileState extends State<UserIntakeTile> {
  late final Nutrients selectedNutrient;
  final num initialAmount = 10;
  final TextEditingController amountTextEditingController =
      TextEditingController();
  bool isAdded = false;

  @override
  void initState() {
    selectedNutrient = widget.nutrient;
    selectedNutrient.userIntakeAmount = initialAmount;
    amountTextEditingController.text = initialAmount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NutrientsVM vm = context.read<NutrientsVM>();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ListTile(
          title: Text(selectedNutrient.name ?? ''),
          subtitle: Column(
            crossAxisAlignment: .start,
            children: [
              Text("Cal Per Gram : ${selectedNutrient.calPerGram}"),
              Text("Protein Per Gram : ${selectedNutrient.proteinPerGram}"),
              Text("fat Per Gram : ${selectedNutrient.fatPerGram}"),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        selectedNutrient.userIntakeAmount -= initialAmount;
                        amountTextEditingController.text = selectedNutrient
                            .userIntakeAmount
                            .toString();
                      });
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                      controller: amountTextEditingController,
                      decoration: InputDecoration(suffix: Text("g")),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline_outlined),
                    onPressed: () {
                      selectedNutrient.userIntakeAmount += initialAmount;
                      amountTextEditingController.text = selectedNutrient
                          .userIntakeAmount
                          .toString();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isAdded ? Icons.check_circle : Icons.save_as_outlined,
                    ),
                    onPressed: isAdded
                        ? null
                        : () {
                            vm.addUserSelectedNutrients(selectedNutrient);
                            setState(() {
                              isAdded = !isAdded;
                            });
                          },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
