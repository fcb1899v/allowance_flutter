import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '../MainView/mainViewModel.dart';

class descTextFieldView extends StatefulWidget{
  final mainViewModel viewModel;
  final int id;
  descTextFieldView(this.viewModel, this.id);
  @override
  descTextFieldViewState createState() => new descTextFieldViewState(viewModel);
}

class descTextFieldViewState extends State<descTextFieldView> {

  final mainViewModel viewModel;
  descTextFieldViewState(this.viewModel);

  //TextFieldが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    final inputdesc = AppLocalizations.of(context)!.inputdesc;
    final descstring = viewModel.desclist[viewModel.index][widget.id];
    final displaydesc = (descstring == "") ? inputdesc: descstring;
    return TextButton(
      child: Text(displaydesc,
        style: TextStyle(
          color: (displaydesc == inputdesc) ? Colors.grey[400]: Colors.lightBlue,
          fontSize: (displaydesc == inputdesc) ? 14: 15,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () => {
        viewModel.clearDesc(widget.id),
        descFieldDialog(context),
        setState(() {
          viewModel.getDescList();
        }),
      },
    );
  }

  Future<void> descFieldDialog(BuildContext context) async {
    String inputtext = viewModel.desclist[viewModel.index][widget.id];
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context)!.settingdesctitle
          ),
          content: TextField(
            onChanged: (value) {
              if (isNotBlank(value)) inputtext = value;
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.settingdeschint,
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text("OK",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                viewModel.saveDescList(widget.id, inputtext);
                setState(() {
                  viewModel.getDescList();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
