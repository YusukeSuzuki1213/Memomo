import 'package:flutter/material.dart';
import 'package:memomo/http.dart';
import 'package:memomo/main.dart';
import 'dart:async';


class EditCreatePageState extends State<StatefulWidget> with WidgetsBindingObserver{
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController contentController = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String savedTitle = "";
  String savedContent = "";
  bool isSaved = false;
  String memoId;

  updateOrSave(type){
    if(type=="create"){
      isSaved
          ? updateMemo(memoId,titleController.text, contentController.text)
          : saveMemo(titleController.text, contentController.text).then((id) => memoId = id);
    }else if(type=="edit"){
      updateMemo(memoId,titleController.text, contentController.text);
    }
  }

  bool hasUserEditedMemo(type) {
    if(titleController.text.isEmpty && contentController.text.isEmpty) {
      return false;
    }else if(titleController.text == savedTitle && contentController.text == savedContent){
      return false;
    }
    return true;
  }

  Future<bool> askToSave(type) {
    if (hasUserEditedMemo(type)) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        child: new AlertDialog(
          title: new Text('Do you want to save it?'),
          content: new Text(''),
          actions: <Widget>[
            new FlatButton(
              child: new Text('YES'),
              onPressed: () {
                updateOrSave(type);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return new Future.value(false);
    } else {
      Navigator.of(context).pop();
      return new Future.value(true);
    }
  }

  Future<bool> doNotSave() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      child: new AlertDialog(
        title: new Text('You can\'t save memo'),
        content: new Text('Memo is empty!'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return new Future.value(false);
  }

  Widget build(BuildContext context) {}

}

