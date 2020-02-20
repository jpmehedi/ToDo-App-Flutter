import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {
  final notes = [
    {
      'title': 'titleText',
      'text': 'Notetext',
    },
    {
      'title': 'titleText',
      'text': 'Notetext',
    },
    {
      'title': 'titleText',
      'text': 'Notetext',
    },
  ];
  NoteInheritedWidget(Widget child):super(child:child);

 static NoteInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>();
  }

  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    return oldWidget.notes!=notes;
  }
}
