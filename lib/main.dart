import 'package:firstapp/screens/notes_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(NoteDown());

class NoteDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        NotesScreen.id : (context) => NotesScreen(),
      },
    );
  }
}
