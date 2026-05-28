import 'package:gym_buddy/extensions/number_formatter.extension.dart';

import 'base_nutrients.dart' show NutrientsBase;
import 'nutrients.dto.dart' show NutrientsDTO;

class Nutrients extends NutrientsBase {
  num userIntakeAmount;

  Nutrients({
    required super.id,
    required super.name,
    required super.protein,
    required super.fat,
    required super.calories,
    required super.unitG,
    required this.userIntakeAmount,
  });

  factory Nutrients.fromDTO(NutrientsDTO dto) {
    return Nutrients(
      id: dto.id ?? 0,
      name: dto.name ?? '',
      protein: dto.protein ?? 0,
      fat: dto.fat ?? 0,
      calories: dto.calories ?? 0,
      unitG: dto.unitG ?? 0,
      userIntakeAmount: 0,
    );
  }

  NutrientsDTO toDTO() {
    return NutrientsDTO(
      id: id,
      name: name,
      protein: protein,
      fat: fat,
      calories: calories,
      unitG: unitG,
    );
  }

  num get calPerGram {
    if ((unitG ?? 0) <= 0) return 0;
    return ((calories ?? 0) / unitG!).format;
  }

  num get proteinPerGram {
    if ((unitG ?? 0) <= 0) return 0;
    return ((protein ?? 0) / unitG!).format;
  }

  num get fatPerGram {
    if ((unitG ?? 0) <= 0) return 0;
    return ((fat ?? 0) / unitG!).format;
  }
}
