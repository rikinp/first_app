import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {

  GoogleButton(
      {@required this.colour, @required this.image, @required this.title, @required this.onPressed});

  final Color colour;
  final String title;
  final AssetImage image;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(40),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                height: 20.0,
                image: image,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}