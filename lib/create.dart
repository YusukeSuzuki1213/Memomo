import 'package:flutter/material.dart';
//
class CreatePageState extends State<CreatePage>{
  final TextEditingController _titleController = new TextEditingController();

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
              hintText: 'Type something',
            ),
          ),

          new RaisedButton(
            onPressed: () {
              showDialog(
                context: context,
                child: new AlertDialog(
                  title: new Text('What you typed'),
                  content: new Text(_titleController.text),
                ),
              );
            },
            child: new Text('save'),
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

