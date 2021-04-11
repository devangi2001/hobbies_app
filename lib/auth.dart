import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hobbies/HomeScreen.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;     //entrypoint for Firebase authentication
final GoogleSignIn _googleSignIn = GoogleSignIn();            //allow us to authenticate with google user

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  void _signInWithGoogle(BuildContext context) async {

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      await firebaseAuth.signInWithCredential(credential);

      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'Sign-In with Google',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                onPressed: () {
                  _signInWithGoogle(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}