extension ConvertFromIntList on List<int> {
  // [取得：合計値を取得]
  int getSum() {
    if (this.isEmpty) return null;
    return this.reduce((a, b) => a + b);
  }

  // [取得：平均値を取得]
  double getAverage() {
    if (this.isEmpty) return null;
    final length = this.length;
    final sum = this.getSum();
    return sum / length;
  }
}
