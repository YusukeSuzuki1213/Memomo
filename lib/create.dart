import 'package:flutter/material.dart';
//
class CreatePageState extends State<CreatePage>{
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _bodyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 5.0,
      ),
      body: new Column(
        children: <Widget>[
          new TextField(
            controller: _titleController,
            decoration: new InputDecoration(
              hintText: 'Title',
            ),
          ),

          new TextField(
            controller: _bodyController,
            decoration: new InputDecoration(
              hintText: '',
            ),
            maxLines: 20,
          ),

          new RaisedButton(
            child: const Text('save'),
            textColor:Colors.pink,
            color: Colors.white,
            elevation: 2.0,
            splashColor: Colors.pink,
            onPressed: () {
              //ここに保存処理
            },
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

