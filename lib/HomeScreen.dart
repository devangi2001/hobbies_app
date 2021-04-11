import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobbies/addNote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth.dart';


// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  
  @override
  HomeScreenState createState() => HomeScreenState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreenState extends State<HomeScreen> {
  final ref = FirebaseFirestore.instance
      .collection('userdata')
      .doc((firebaseAuth.currentUser).uid)
      .collection('notes');

      
      void signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthenticationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Write your Hobbies'),
          centerTitle: true,
          actions: [TextButton(onPressed:(){signOut();}, child: Text("SIGN OUT", style: TextStyle(color: Colors.white),),)],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNote()));
          },
        ),
        
        body: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        //padding: EdgeInsets.all(90),
                        height: 90,
                        color: Colors.cyanAccent[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("NAME:" + snapshot.data.docs[index].data()['name'], style: TextStyle(color: Colors.black, fontSize: 15),),
                            Text("HOBBIES:" +snapshot.data.docs[index].data()['hobby'],style: TextStyle(color: Colors.black, fontSize: 15),)
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}