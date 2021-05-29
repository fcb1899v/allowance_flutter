import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'datePickerView.dart';
import 'descTextFieldView.dart';
import 'amntTextFieldView.dart';
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

  DataColumn dataColumnTitle(String columntitle) {
    var lang = Localizations.localeOf(context).languageCode;
    return DataColumn(
      label: Text(columntitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: (lang != "ja") ? 'Pacifico': 'Irohamaru',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Text unitText() {
    return Text(viewModel.unitvalue,
        style: TextStyle(
          color: Colors.lightBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
    );
  }

  List<DataRow> getDataRows() {
    List<DataRow> datarows = [];
    for (var id = 0; id < viewModel.counter[viewModel.index]; id++) {
      datarows.add(DataRow(
        cells: <DataCell>[
          DataCell(datePickerView(viewModel, id),),
          DataCell(descTextFieldView(viewModel, id),),
          DataCell(unitText(),),
          DataCell(amntTextFieldView(viewModel, id),),
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
            padding: EdgeInsets.only(left: 20, right: 20,),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                headingRowHeight: 50,
                showCheckboxColumn: true,
                columnSpacing: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.lightBlue
                ),
                columns: <DataColumn>[
                  dataColumnTitle(AppLocalizations.of(context)!.date),
                  dataColumnTitle(AppLocalizations.of(context)!.desc),
                  dataColumnTitle(""),
                  dataColumnTitle(AppLocalizations.of(context)!.amnt),
                ],
                rows: getDataRows(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


