class ExerciseInfo {
  final int? id;
  final DateTime? createdAt;
  final String? visualGuideUrl;
  final String? name;

  const ExerciseInfo({
    required this.id,
    required this.createdAt,
    required this.visualGuideUrl,
    required this.name,
  });

  factory ExerciseInfo.fromJson(Map<String, dynamic> json) {
    return ExerciseInfo(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      visualGuideUrl: json['visualGuideUrl'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'visualGuideUrl': visualGuideUrl,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'ExerciseInfo(id: $id, createdAt: $createdAt, visualGuideUrl: $visualGuideUrl, name: $name)';
  }
}