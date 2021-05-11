import 'package:flutter/material.dart';
import 'package:recipe_box/ui/googleSignInButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // New private method which includes the background image:
    BoxDecoration _buildBackground() {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/annie-spratt-5XZ2SyTOyvQ-unsplash.jpg"),
          fit: BoxFit.cover,
        ),
      );
    }

    Text _buildText() {
      return Text(
        'Recipes',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 75.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      );
    }

    Widget LoginWidget() {
      return Scaffold(
        // We do not use backgroundColor property anymore.
        // New Container widget wraps our Center widget:
        body: Container(
          decoration: _buildBackground(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Login needed"),
                _buildText(),
                SizedBox(height: 50.0),
                GoogleSignInButton(
                  onPressed: () async {
                    //setState(() async {
                    // do authenication
                    userCredential = await signInWithGoogle();
                    userID = userCredential.user.uid;
                    print("Button onPressed DONE");
                    // });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        print("Checking if user is logged in");
        if (snapshot.hasData) {
          print("===== User  exists");
          userID = FirebaseAuth.instance.currentUser.uid;
          return Home();
        }
        else {
          print("===== User  does not exists");
          return LoginWidget();
        }
      },
    );
  }

  // ======== Added for Authentication  ========
  UserCredential userCredential;
  String userID;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


}