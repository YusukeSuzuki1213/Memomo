import 'package:flutter/material.dart';

class Choice {
  const Choice({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'sort', icon: Icons.sort),
  const Choice(title: 'search', icon: Icons.search),
  const Choice(title: 'memo', icon: Icons.insert_drive_file),
  const Choice(title: 'add', icon: Icons.add),
  const Choice(title: 'save', icon: Icons.save),
  const Choice(title: 'back', icon: Icons.arrow_back),

];