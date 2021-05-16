import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'datePickerView.dart';
import 'descFieldView.dart';
import 'amntFieldView.dart';
import 'mainViewModel.dart';

class spendSpreadSheet extends StatefulWidget{
  final mainViewModel viewModel;
  spendSpreadSheet(this.viewModel);
  @override
  spendSpreadSheetState createState() => new spendSpreadSheetState(viewModel);
}

class spendSpreadSheetState extends State<spendSpreadSheet> {

  final mainViewModel viewModel;
  spendSpreadSheetState(this.viewModel);

  @override
  void initState() {
    super.initState();
    setState(() {
      viewModel.getCounter();
      viewModel.getAmntList();
    });
  }

  DataColumn dataColumnTitle(String columntitle) {
    return DataColumn(
      label: Text(columntitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Pacifico',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<DataRow> getDataRows() {
    List<DataRow> datarows = [];
    for (var i = 0; i < viewModel.counter; i++) {
      datarows.add(DataRow(
        cells: <DataCell>[
          DataCell(datePickerView(i),),
          DataCell(descFieldView(viewModel, i),),
          DataCell(amntFieldView(viewModel, i),),
        ],
      ));
    }
    return datarows;
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: Theme(
          data: Theme.of(context).copyWith(
              dividerColor: Colors.lightBlue
          ),
          child: Container(
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: DataTable(
              headingRowHeight: 40,
              showCheckboxColumn: true,
              columnSpacing: 30,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.lightBlue
              ),
              columns: <DataColumn>[
                dataColumnTitle("Date"),
                dataColumnTitle("Description"),
                dataColumnTitle("Amount"),
              ],
              rows: getDataRows(),
            ),
          ),
        ),
      ),
    );
  }
}


