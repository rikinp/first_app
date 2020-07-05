import 'package:flutter/material.dart';

class Validation {

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    print(value);

    if(value.isEmpty){
      return 'Please Enter Email';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }
  }

  String validatePassword(String value) {
//    Pattern pattern =
//        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
//    RegExp regex = new RegExp(pattern);
//
//    print(value);

    if (value.isEmpty) {
      return 'Please Enter Password';
    } else {
      if (value.length<8)
        return 'Enter valid Password min 8 length';
      else
        return null;
    }
  }
}

//'Password must have At least one upper case letter,
//    At least one lower case letter,
//    At least one digit,
//    At least one special character,
//    Minimum eight in length'
