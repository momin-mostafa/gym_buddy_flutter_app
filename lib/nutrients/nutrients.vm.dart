import 'package:flutter/widgets.dart';
import 'package:gym_buddy/extensions/number_formatter.extension.dart';
import 'package:gym_buddy/nutrients/nutrients.repo.dart';

import 'model/nutrients.entity.dart' show Nutrients;

class NutrientsVM with ChangeNotifier {
  NutrientsRepo repository;

  NutrientsVM(this.repository);

  List<Nutrients> nutrientsList = [];

  List<Nutrients> userSelectedNutrients = [];

  void addUserSelectedNutrients(Nutrients nutrients) async {
    await addNutrients(nutrients);
  }

  num selectedAmount = 0;

  String get totalProteinForSelectedNutrients {
    num result = 0;
    result = userSelectedNutrients.fold((result), (previousValue, element) {
      result += element.proteinPerGram * element.userIntakeAmount;
      return result;
    });

    return result.format.toString();
  }

  String get totalFatForSelectedNutrients {
    num result = 0;
    result = userSelectedNutrients.fold((result), (previousValue, element) {
      result += element.fatPerGram * element.userIntakeAmount;
      return result;
    });

    return result.format.toString();
  }

  String get totalCaloriesForSelectedNutrients {
    num result = 0;
    result = userSelectedNutrients.fold((result), (previousValue, element) {
      result += element.calPerGram * element.userIntakeAmount;
      return result;
    });

    return result.format.toString();
  }

  Future<void> updateNutrientsList() async {
    await repository.getAllNutrientsList().then((value) {
      nutrientsList = value;
      notifyListeners();
    });
  }

  Future<Nutrients?> getNutrientsDetailsForId(int id) async {
    return await repository.getNutrientsForId(id);
  }

  void removeFromUserSelectedNutrientsList(int index) {
    userSelectedNutrients.removeAt(index);
    notifyListeners();
  }

  Future<void> addNutrients(Nutrients nutrients) async {
    nutrientsList = await repository.addNutrients(nutrients);
    notifyListeners();
  }
}
