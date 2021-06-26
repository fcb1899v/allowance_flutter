
extension DoubleExt on double {

  double toAbs() {
    return (this < 0.0) ? (-1)* this: this;
  }

  String stringMoney(String unitvalue) {
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
  double toMaxDouble() {
    double maxdouble = 0.0;
    for (var i = 0; i < 120; i++) {
      if (this[i] > maxdouble) {
        maxdouble = this[i];
      }
    }
    return maxdouble;
  }
}

extension ListListDoubleExt on List<List<double>> {
  double toMax() {
    return this.expand((List<double> values) => values).toList().toMaxDouble();
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

  int toMonthIndex(int i) {
    return (this.toMonth() - 1 + i) % 12;
  }

  int toYearIndex() {
    return DateTime.now().year - this.toYear();
  }


  DateTime toDate() {
    return DateTime(this.toYear(), this.toMonth(), this.toDay());
  }

  DateTime toDisplayDate(int index) {
    return DateTime(this.toDate().displayYear(index), this.toDate().displayMonth(index),);
  }

  String displayMonthDay(int index, int day) {
    return "${this.toDate().displayMonth(index)}/$day";
  }

  String displayMonthYear(int index) {
    return "${this.toDate().displayMonth(index)}/${this.toDate().displayYear(index)}";
  }

  int toCurrentIndex() {
    return 12 * (DateTime.now().year - this.toYear()) + DateTime.now().month - this.toMonth();
  }
}

extension intExt on int {

  int monthIndex(String startdate) {
    return (startdate.toMonth() - 1 + this) % 12;
  }

  int yearIndex() {
    return this ~/ 12;
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
    final addindextoyear = this!.year + (this!.month + index) ~/ 12;
    return (this != null && (this!.month + index) % 12 != 0) ?
      addindextoyear: addindextoyear - 1;
  }
}

extension ListListMapExt on List<List<Map>> {

  Map toMap(int index, int id) {
    int date = this[index][id]["date"];
    String desc = this[index][id]["desc"];
    double amnt = this[index][id]["amnt"];
    return  {"date": date, "desc": desc, "amnt": amnt};
  }

  void dateSort(int index) {
    this[index].sort((a, b) => a["date"].compareTo(b["date"]));
  }

  double toSum(int index, int count) {
    double amntsum = 0;
    for (var i = 0; i < count; i++) {
      amntsum += this[index][i]["amnt"];
    }
    return amntsum;
  }

  double toAllowanceSum(int index, int count) {
    double amntsum = 0;
    for (var i = 0; i < count; i++) {
      if (this[index][i]["amnt"] > 0) {
        amntsum += this[index][i]["amnt"];
      }
    }
    return amntsum;
  }

  double toSpendSum(int index, int count) {
    double amntsum = 0;
    for (var i = 0; i < count; i++) {
      if (this[index][i]["amnt"] < 0) {
        amntsum += this[index][i]["amnt"];
      }
    }
    return (-1.0) * amntsum;
  }

  double toBalance(int index, int count) {
    return this.toSum(index, count);
  }

  double toPercent(int index, List<int> count) {
    double sum = (this.toSum(index, count[index]) > 0.0) ? this.toSum(index, count[index]): 0.0;
    double amountsum = (this.toAllowanceSum(index, count[index]) > 0.0) ? this.toAllowanceSum(index, count[index]): 0.0;
    double percent = (sum == 0.0 || amountsum ==0.0) ? 1: (1 - sum / amountsum);
    return (percent > 1.0) ? 1.0: (percent < 0) ? 0.0: percent;
  }
}