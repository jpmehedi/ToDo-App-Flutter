import 'package:flutter/material.dart';
import '../views/inherited_widget.dart';

enum NoteMode {
  Adding,
  Editing,
}

class Note extends StatefulWidget {
  final NoteMode noteMode;
  final int index;
  Note(this.noteMode, this.index);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController titleEditingController = TextEditingController();

  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.Editing) {
      textEditingController.text = _notes[widget.index]['title'];
      titleEditingController.text = _notes[widget.index]['text'];
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.noteMode == NoteMode.Adding ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: 'Write Title'),
              ),
            ),
            Divider(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 5,
                controller: titleEditingController,
                decoration:
                    InputDecoration.collapsed(hintText: 'Note Something'),
              ),
            ),
            Divider(height: 10.00),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _NoteButtons(() {
                  final title = titleEditingController.text;
                  final text = textEditingController.text;
                  if (widget?.noteMode == NoteMode.Adding) {
                    _notes.add({
                      'title': title,
                      'text': text,
                    });
                  } else if (widget?.noteMode == NoteMode.Editing) {
                    _notes[widget.index] = {
                      'title': title,
                      'text': text,
                    };
                  }
                  Navigator.pop(context);
                }, 'Save', Colors.green),
                _NoteButtons(() {
                  Navigator.pop(context);
                }, 'Discred', Colors.grey),
                widget.noteMode == NoteMode.Editing
                    ? _NoteButtons(() {
                        _notes.removeAt(widget.index);
                        Navigator.pop(context);
                      }, 'Delete', Colors.red)
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _NoteButtons extends StatelessWidget {
  _NoteButtons(this._onPressed, this._buttonText, this._buttonColor);

  final Function _onPressed;
  final String _buttonText;
  final Color _buttonColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _buttonText,
      ),
      color: _buttonColor,
    );
  }
}
