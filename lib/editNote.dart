import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditNote extends StatefulWidget {
  DocumentSnapshot doctoEdit;
  EditNote({this.doctoEdit});
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.doctoEdit.data()['name']);
    content = TextEditingController(text: widget.doctoEdit.data()['hobby']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                widget.doctoEdit.reference.update({
                  'name': title.text,
                  'hobby': content.text
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text('Save')),
          ElevatedButton(
              onPressed: () {
                widget.doctoEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              child: Text('Delete')),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'NAME'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'hobbiess'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}