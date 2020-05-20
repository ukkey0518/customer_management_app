extension ConvertFromIntList on List<int> {
  // [取得：合計値を取得]
  int getSum() {
    var sum = 0;
    if (this.isNotEmpty) {
      sum = this.reduce((a, b) => a + b);
    }
    return sum;
  }

  // [取得：平均値を取得]
  double getAverage() {
    var average = 0.0;
    if (this.isNotEmpty) {
      final length = this.length;
      final sum = this.getSum();
      average = sum / length;
    }
    return average;
  }
}
