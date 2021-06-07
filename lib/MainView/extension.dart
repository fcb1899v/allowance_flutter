
extension DoubleExt on double {

  double toAbs() {
    return (this < 0.0) ? (-1)* this: this;
  }

  String stringBalance(String unitvalue) {
    final numberdigit = (unitvalue == '¥') ? 0: 2;
    return this.toStringAsFixed(numberdigit);
  }

  String stringAmount(String unitvalue) {
    final numberdigit = (unitvalue == '¥') ? 0: 2;
    final plusminus = (this < 0) ? "-": "+";
    final stringamount = "$plusminus${this.toAbs().toStringAsFixed(numberdigit)}";
    final defaultvalue = "$plusminus${(0.0).toStringAsFixed(numberdigit)}";
    return (stringamount == defaultvalue) ? "-": stringamount;
  }
}

extension ListDoubleExt on List<double> {
  double toMaxBalance() {
    double maxbalance = 500;
    double newmaxbalance = 500;
    for (var i = 0; i < 120; i++) {
      if (this[i] > maxbalance) {
        newmaxbalance = this[i];
        maxbalance = newmaxbalance;
      }
    }
    print("maxbalance: $maxbalance");
    return maxbalance;
  }
}

extension StringExt on String {

  int toInt(int defaultint) {
    return (int.parse(this) > 0) ? int.parse(this) : defaultint;
  }

  int toIntDay(int defaultint) {
    return (int.parse(this) > 0 || int.parse(this) < 32) ? int.parse(this) : defaultint;
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

  String displayMonthDay(int index, int day) {
    return "${this.displayMonth(index)}/$day";
  }
}

extension ListListDoubleExt on List<List<double>> {

  double toAmountSum(int index, int count) {
    double amntsum = 0;
    for (var i = 0; i < count; i++) {
      if (this[index][i] > 0) {
        amntsum += this[index][i];
      }
    }
    return amntsum;
  }

  double toSum(int index, int count) {
    double sum = 0;
    for (var i = 0; i < count; i++) {
      sum += this[index][i];
    }
    return sum;
  }

  double toBalance(int index, List<int> count) {
    return this.toSum(index, count[index]);
  }

  double toPercent(int index, List<int> count) {
    double sum = (this.toSum(index, count[index]) > 0.0) ? this.toSum(index, count[index]): 0.0;
    double amountsum = (this.toAmountSum(index, count[index]) > 0.0) ? this.toAmountSum(index, count[index]): 0.0;
    double percent = (sum == 0.0 || amountsum ==0.0) ? 1: (1 - sum / amountsum);
    return (percent > 1.0) ? 1.0: (percent < 0) ? 0.0: percent;
  }
}