import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {

  final VoidCallback press;
final String name;

MyButton({this.name,this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: double.infinity,
        child: RaisedButton(
            child: Text(name),
            color: Colors.lightBlue,
            onPressed: press,
        )
    );
  }
}


