import 'package:flutter/material.dart';
import 'package:gym_buddy/authentication/view_model/auth.vm.dart' show AuthVM;
import 'package:gym_buddy/exercise_routine/add_routine.v.dart';
import 'package:gym_buddy/exercises/exercise_list.v.dart';
import 'package:gym_buddy/nutrients/ingredients_selector.v.dart';
import 'package:provider/provider.dart' show ReadContext;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int selectedBottomNavigationBarIndex = 0;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          IngredientsSelectorView(),
          ExerciseListView(),
          AddRoutineView(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedBottomNavigationBarIndex,
        onTap: (int index) {
          setState(() {
            selectedBottomNavigationBarIndex = index;
            tabController?.animateTo(index);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.food_bank_outlined), label: "Intake"),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_outlined),
            label: "Add Routine",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Explore",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthVM>().signOut();
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
