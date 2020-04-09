import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddRecycleBinView extends StatefulWidget {

  String recycleBinName = "";
  bool dialogResult = false;
  @override
  _AddRecycleBinViewState createState() => _AddRecycleBinViewState();
}

class _AddRecycleBinViewState extends State<AddRecycleBinView> {

  static const double _padding = 16.0;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _recycleBinNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(_padding, 50, _padding, 0),
                  child: Text('recycle bin name', style: Theme
                      .of(context)
                      .textTheme
                      .title)
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(_padding, 0, _padding, 0),
                  child: TextFormField(
                      controller: _recycleBinNameController, style: Theme
                      .of(context)
                      .textTheme
                      .body1)
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                      _padding, _padding, _padding, 0),
                  child: RaisedButton(
                    onPressed: () {
                      widget.recycleBinName = _recycleBinNameController.text;

                      if (widget.recycleBinName.isNotEmpty) {
                        Navigator.pop(context, true);
                      }
                      else {
                        Navigator.pop(context, false);
                      }
                    },
                    child: new Text("Save", style: Theme
                        .of(context)
                        .textTheme
                        .title,),
                  )
              ),
            ],
          ),
        )
    );
  }
}