
extension IntExt on int {

  String toBalance(List<List<int>> amntlist, int index, List<int> count) {
    final balance = this - amntlist.toAmountSum(index, count[index]);
    return (balance > 0) ? balance.toString() : "0";
  }

  double toPercent(List<List<int>> amntlist, int index, List<int> count) {
    final percent = amntlist.toAmountSum(index, count[index]).toDouble() / this.toDouble();
    return (percent < 1) ? percent : 1;
  }

  String toNumberString() {
    return (this > 0) ? "${this.toRadixString(10)}" : "";
  }
}

extension StringExt on String {
  int toInt(int defaultint) {
    return (int.parse(this) > 0) ? int.parse(this) : defaultint;
  }

  int toDay() {
    return (this.split("/")[1].substring(0, 1) == "0") ?
      this.split("/")[1].substring(1).toInt(1):
      this.split("/")[1].toInt(1);
  }

  int toMonth() {
    return (this.split("/")[0].substring(0, 1) == "0") ?
      this.split("/")[0].substring(1).toInt(1):
      this.split("/")[0].toInt(1);
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

  int defYear(){
    return (this != null) ? DateTime.now().year - this!.year: 0;
  }

  int defMonth(){
    return (this != null) ? DateTime.now().month - this!.month: 0;
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

extension ListListStringExt on List<List<String>> {

  List<String> toDateStringList(int index, int count) {
    List<String> datestringlist = [];
    for (var i = 0; i < count; i++) {
      datestringlist.add(this[index][i]);
    }
    return datestringlist;
  }

  List<String> toDescriptionList(int index, int count) {
    List<String> desclist = [];
    for (var i = 0; i < count; i++) {
      desclist.add(this[index][i]);
    }
    return desclist;
  }
}

extension ListListIntExt on List<List<int>> {

  List<int> toAmountList(int index, int count) {
    List<int> amountlist = [];
    for (var i = 0; i < count; i++) {
      amountlist.add(this[index][i]);
    }
    return amountlist;
  }

  int toAmountSum(int index, int count) {
    int amntsum = 0;
    for (var i = 0; i < count; i++) {
      amntsum += this[index][i];
    }
    return amntsum;
  }
}