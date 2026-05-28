import 'package:gym_buddy/nutrients/model/base_nutrients.dart';
import 'package:gym_buddy/nutrients/model/nutrients.entity.dart';

class NutrientsDTO extends NutrientsBase {
  NutrientsDTO({
    required super.id,
    required super.name,
    required super.protein,
    required super.fat,
    required super.calories,
    required super.unitG,
  });

  factory NutrientsDTO.fromJson(Map<String, dynamic> json) {
    return NutrientsDTO(
      id: json['id'],
      name: json['name'],
      protein: json['protein'],
      fat: json['fat'],
      calories: json['calories'],
      unitG: json['unit_g'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'protein': protein,
      'fat': fat,
      'calories': calories,
      'unit_g': unitG,
    };
  }

  NutrientsDTO copyWith({
    int? id,
    String? name,
    double? protein,
    double? fat,
    double? calories,
    double? unitG,
  }) {
    return NutrientsDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      calories: calories ?? this.calories,
      unitG: unitG ?? this.unitG,
    );
  }

  @override
  String toString() {
    return 'Food(name: $name, protein: $protein, fat: $fat, calories: $calories, unitG: $unitG)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NutrientsDTO &&
            name == other.name &&
            protein == other.protein &&
            fat == other.fat &&
            calories == other.calories &&
            unitG == other.unitG;
  }

  @override
  int get hashCode {
    return Object.hash(name, protein, fat, calories, unitG);
  }
}
