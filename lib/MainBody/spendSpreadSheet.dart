import 'package:allowance_app/MainView/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'datePickerView.dart';
import 'descTextFieldView.dart';
import 'amntTextFieldView.dart';
import 'deleteButtonView.dart';
import '../MainView/mainViewModel.dart';

class spendSpreadSheet extends StatefulWidget{
  final mainViewModel viewModel;
  spendSpreadSheet(this.viewModel);
  @override
  spendSpreadSheetState createState() => new spendSpreadSheetState(viewModel);
}

class spendSpreadSheetState extends State<spendSpreadSheet> {

  final mainViewModel viewModel;
  spendSpreadSheetState(this.viewModel);

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.lightBlue),
          child: Container(
            padding: EdgeInsets.only(left: 0, right: 0,),
            width: MediaQuery.of(context).size.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                headingRowHeight: 40,
                dataRowHeight: 40,
                showCheckboxColumn: true,
                columnSpacing: 10,
                decoration: BoxDecoration(color: Colors.white,),
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.lightBlue
                ),
                columns: <DataColumn>[
                  dataColumnTitle(context, AppLocalizations.of(context)!.day),
                  dataColumnTitle(context, AppLocalizations.of(context)!.desc),
                  dataColumnTitle(context, "${AppLocalizations.of(context)!.amnt} [${viewModel.unitvalue}]"),
                  dataColumnTitle(context, ""),
                ],
                rows: getDataRows(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> getDataRows() {
    List<DataRow> datarows = [];
    for (var id = 0; id < viewModel.counter[viewModel.index]; id++) {
      datarows.add(DataRow(
        cells: <DataCell>[
          DataCell(datePickerView(viewModel, id),),
          DataCell(descTextFieldView(viewModel, id),),
          DataCell(amntTextFieldView(viewModel, id),),
          DataCell(deleteButtonView(viewModel, id),),
        ],
      ));
    }
    return datarows;
  }
}


