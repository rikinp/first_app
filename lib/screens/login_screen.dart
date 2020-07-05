import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/components/rounded_button.dart';
import 'package:firstapp/components/google_button.dart';
import 'notes_screen.dart';
import 'package:firstapp/validation.dart';
import 'package:firstapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validation {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  bool showSpinner = false;
  bool showPassword = false;
  String email;
  String password;
  String errorMsg;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: loginForm(),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      autovalidate: false,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          TextFormField(
            validator: validateEmail,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onSaved: (value) {
              email = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            validator: validatePassword,
            textAlign: TextAlign.center,
            obscureText: !this.showPassword,
            onSaved: (value) {
              password = value;
            },
            decoration: kTextFieldDecoration.copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this.showPassword ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      this.showPassword = !this.showPassword;
                    });
                  },
                ),
                hintText: 'Enter Your Password'),
          ),
          SizedBox(
            height: 24.0,
          ),
          RoundedButton(
            colour: Colors.lightBlueAccent,
            title: 'Log In',
            onPressed: () {
              logIn();
            },
          ),
          Center(
            child: SizedBox(
              height: 20.0,
              child: Text('OR',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
          GoogleButton(
              colour: Colors.white,
              image: AssetImage('images/google_logo.png'),
              title: 'Sign In With Google',
              onPressed: () {
                //print('google');
                _handleSignIn();
              }),
        ],
      ),
    );
  }

  logIn() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        showSpinner = true;
      });
    }
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamed(context, NotesScreen.id);
      }
      setState(() {
        showSpinner = false;
      });
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          {
            setState(() {
              errorMsg =
                  "There is no user with such entries. Please try again.";

              showSpinner = false;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  Widget okButton = FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  return AlertDialog(
                    content: Text(errorMsg),
                    actions: <Widget>[okButton],
                  );
                });
          }
          break;
        case "ERROR_WRONG_PASSWORD":
          {
            setState(() {
              errorMsg = "Password doesn\'t match your email.";
              showSpinner = false;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  Widget okButton = FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  return AlertDialog(
                    content: Text(errorMsg),
                    actions: <Widget>[okButton],
                  );
                });
          }
          break;
        default:
          {
            setState(() {
              errorMsg = "";
            });
          }
      }
    }
  }

  Future<FirebaseUser> _handleSignIn() async{
    FirebaseUser user;
    bool isSignedIn = await _googleSignIn.isSignedIn();

    if(isSignedIn){
      user = await _auth.currentUser();
      if (user != null) {
        Navigator.pushNamed(context, NotesScreen.id);
      }
      setState(() {
        showSpinner = false;
      });
    }
    else{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        Navigator.pushNamed(context, NotesScreen.id);
      }
      setState(() {
        showSpinner = false;
      });
    }
    return user;
  }

}
