import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/constants.dart';
import 'package:firstapp/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseUser loggedInUser;

class NotesScreen extends StatefulWidget {
  static String id = 'notes_screen';

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  //GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle),
          title: Row(
            children: <Widget>[
              Text('Welcome'),
              SizedBox(
                width: 5.0,
              ),
              Text(
                  loggedInUser.email.substring(0,5) + "!"
              ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Welcome'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
