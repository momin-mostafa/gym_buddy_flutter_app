extension NumberFormatter on num? {
  num get format {
    if (this == null) return 0;
    return double.tryParse(this!.toStringAsFixed(2)) ?? 0;
  }
}
