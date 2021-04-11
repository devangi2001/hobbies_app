import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobbies/HomeScreen.dart';

// ignore: must_be_immutable
class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _AddNoteState extends State<AddNote> {
  TextEditingController name = TextEditingController();
  TextEditingController body = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance
      .collection('userdata')
      .doc((firebaseAuth.currentUser).uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Notes"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
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
                  controller: body,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'hobbiess'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.add({
                  //.doc.set
                  'name': name.text,
                  'hobby': body.text
                }).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())));
              },
              child: Text('Save'))
          ],
        ),
      ),
    );
  }
}