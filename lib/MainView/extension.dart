
extension DoubleExt on double {

  double toBalance(List<List<double>> amntlist, int index, List<int> count) {
    final balance = this - amntlist.toAmountSum(index, count[index]);
    return (balance > 0) ? balance : 0;
  }

  double toPercent(List<List<double>> amntlist, int index, List<int> count) {
    final percent = (amntlist.toAmountSum(index, count[index]) / this);
    print("percent: $percent");
    return (percent < 1) ? percent : 1;
  }
}

extension StringExt on String {
  int toInt(int defaultint) {
    return (int.parse(this) > 0) ? int.parse(this) : defaultint;
  }

  double toDouble(double defaultdouble) {
    return (double.parse(this) > 0) ? double.parse(this) : defaultdouble;
  }

  String addZero() {
    return (this.toInt(0) < 10) ? "0${this}": "${this}";
  }

  int removeZero() {
    return (this[0] == "0") ? this[1].toInt(1): this.toInt(1);
  }

  int toDay() {
    return this.split("/")[1].removeZero();
  }

  int toMonth() {
    return this.split("/")[0].removeZero();
  }

  int toYear() {
    return this.split("/")[2].toInt(2021);
  }

  DateTime toDate() {
    return DateTime(this.toYear(), this.toMonth(), this.toDay());
  }

  DateTime toDisplayDate(int index) {
    return DateTime(this.toDate().displayYear(index), this.toDate().displayMonth(index),);
  }

  int toCurrentIndex() {
    print("now : ${DateTime.now()}, startdate : $this");
    return 12 * (DateTime.now().year - this.toYear()) + DateTime.now().month - this.toMonth();
  }
}

extension intExt on int {

  int monthIndex(String startdate) {
    return (startdate.toMonth() - 1 + this) % 12;
  }

  int yearIndex() {
    return (this / 12).toInt();
  }
}

extension IntArrayExt on List<int> {
  int toSum(int count) {
    var sumvalue = 0;
    for (var i = 0; i < count; i++) {
      sumvalue += this[i];
    }
    return sumvalue;
  }
}

extension DateExt on DateTime? {
  String toDateString(String defaultdate) {
    if (this != null) {
      final month = (this!.month < 10) ? "0${this!.month}": "${this!.month}";
      final day = (this!.day < 10) ? "0${this!.day}": "${this!.day}";
      return "$month/$day/${this!.year}";
    } else {
      return defaultdate;
    }
  }

  int displayMonth(int index) {
    return (this != null && (this!.month + index) % 12 != 0) ?
        (this!.month + index) % 12: 12;
  }

  int displayYear(int index) {
    final addindextoyear = this!.year + ((this!.month + index) / 12).toInt();
    return (this != null && (this!.month + index) % 12 != 0) ?
      addindextoyear: addindextoyear - 1;
  }

  String displayMonthYear(int index) {
    return "${this.displayMonth(index)}/${this.displayYear(index)}";
  }
}

extension ListListIntExt on List<List<double>> {
  double toAmountSum(int index, int count) {
    double amntsum = 0;
    for (var i = 0; i < count; i++) {
      amntsum += this[index][i];
    }
    return amntsum;
  }
}