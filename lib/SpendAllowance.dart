extension IntExt on int {
  String toBalancePrice() {
    return (this > 0) ? "¥ ${this.toRadixString(10)}" : "¥ 0";
  }

  String toBalance(List<int> amountlist, int counternum) {
    final balance = this - amountlist.toSum(counternum);
    return (balance > 0) ? balance.toString() : "0";
  }

  double toPercent(List<int> amountlist, int counternum) {
    final percent = amountlist.toSum(counternum).toDouble() / this.toDouble();
    return (percent < 1) ? percent : 1;
  }

  String toPrice() {
    return (this > 0) ? "${this.toRadixString(10)}" : "";
  }
}

extension StringExt on String {
  int toInt(int defaultint) {
    return (int.parse(this) > 0) ? int.parse(this) : defaultint;
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

extension DateExt on DateTime? {
  String toDateString(String defaultdate) {
    return (this != null) ?
      "${this!.month}/${this!.day}/${this!.year}":
      defaultdate;
  }

  int defYear(){
    return (this != null) ? DateTime.now().year - this!.year: 0;
  }

  int defMonth(){
    return (this != null) ? DateTime.now().month - this!.month: 0;
  }

  int addIndexToMonth(int index) {
    print("${(this!.month + index) % 12}");
    return (this != null && (this!.month + index) % 12 != 0) ?
        (this!.month + index) % 12: 12;
  }

  int addIndexToYear(int index) {
    final addindextoyear = this!.year + ((this!.month + index) / 12).toInt();
    print("${(this!.month + index) % 12}");
    return (this != null && (this!.month + index) % 12 != 0) ?
      addindextoyear: addindextoyear - 1;
  }

  String displayMonthYear(int index) {
    return "${this.addIndexToMonth(index)}/${this.addIndexToYear(index)}";
  }
}