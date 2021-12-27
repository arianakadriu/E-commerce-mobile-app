import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obserText;
  final TextEditingController controller;
  final String name;
  final Function onTap;
  PasswordTextFormField({this.controller, this.onTap, this.name, this.obserText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obserText,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: name,
        suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
                obserText==true
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.black)
        ),
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}