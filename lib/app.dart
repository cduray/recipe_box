import 'package:flutter/material.dart';
import 'package:recipe_box/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:recipe_box/ui/login.dart';

class RecipesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Box',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      // routes: {
      //   '/': (context) => Home(), // New code
      //   '/login': (context) => LoginScreen(),
      // },
    );

  }
}