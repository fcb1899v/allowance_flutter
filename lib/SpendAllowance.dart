extension IntExt on int {

  String toBalancePrice() {
    return (this > 0) ? "¥ ${this.toRadixString(10)}" : "¥ 0";
  }

  String toPrice() {
    return (this > 0) ? "${this.toRadixString(10)}" : "";
  }
}

extension StringExt on String {

  int toInt(int defaultint) {
    return (int.parse(this) > 0) ? int.parse(this) : defaultint;
  }

  String toBalance(List<int> amountlist, int counternum) {
    final balance = this.toInt(500) - amountlist.toSum(counternum);
    return (balance > 0) ? balance.toString() : "0";
  }

  double toPercent(List<int> amountlist, int counternum) {
    final percent = amountlist.toSum(counternum).toDouble() / this.toInt(500).toDouble();
    return (percent < 1) ? percent : 1;
  }
}

extension IntArrayExt on List<int> {
  int toSum(int counternum) {
    var sumvalue = 0;
    for (var i = 0; i < counternum; i++) {
      sumvalue += this[i];
    }
    return sumvalue;
  }
}