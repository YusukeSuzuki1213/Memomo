import 'package:flutter/material.dart';
import 'package:memomo/icons.dart';
import 'package:memomo/http.dart';
import 'dart:async';

class CreatePageState extends State<CreatePage> with WidgetsBindingObserver{
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _contentController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _hasUserEditedMemo() {
    return true;//保存されてbackキーが押されているか、あと無入力のときは無条件でtrue
  }
  Future<bool> _requestPop() {
    if (_hasUserEditedMemo()) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        child: new AlertDialog(
          title: new Text('Discard your changes?'),
          content: new Text(''),
          actions: <Widget>[
            new FlatButton(
              child: new Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('DISCARD'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      return new Future.value(false);
    } else {
      return new Future.value(true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          leading: new IconButton(
              icon: new Icon(choices[5].icon),
              onPressed:_requestPop
          ),
          title: new Text(widget.title),
          elevation: 5.0,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(choices[4].icon),
              onPressed: (){
                saveMemo(_titleController.text, _contentController.text);
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                    content: new Text('saved')
                ));
              },//保存処理,
            ),
          ]
      ),

      body:new Column(
      children: <Widget>[
        new TextField(
          controller: _titleController,
          decoration: new InputDecoration(
              hintText: 'Title',
            ),
          ),
        new TextField(
          controller: _contentController,
          maxLengthEnforced: false,
          maxLines: null,
          decoration: new InputDecoration(
            hintText: '',
            ),
          ),
        ],
      )
    );


    }

  }



class CreatePage extends StatefulWidget {
  final String title;
  CreatePage({Key key, this.title}) : super(key: key);

  @override
  CreatePageState createState() => new CreatePageState();
}

