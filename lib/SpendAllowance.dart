extension IntExt on int {

  String toBalancePrice() {
    return (this > 0) ? "¥ ${this.toRadixString(10)}" : "¥ 0";
  }

  String toPrice() {
    return (this > 0) ? "¥ ${this.toRadixString(10)}" : "";
  }
}

extension StringExt on String {

  int toInt(int defaultint) {
    return (int.parse(this) > 0) ? int.parse(this) : defaultint;
  }

  int toBalance(List<int> spendlist) {
    final balance = this.toInt(500) - spendlist.toSum();
    return (balance > 0) ? balance : 0;
  }

  double toPercent(List<int> spendlist) {
    final percent = spendlist.toSum().toDouble() / this.toInt(500).toDouble();
    return (percent < 1) ? percent : 1;
  }
}

extension IntArrayExt on List<int> {
  int toSum() {
    return this.reduce((value, element) => value + element);
  }
}