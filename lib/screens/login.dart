import 'package:ecommerce/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/widgets/mybutton.dart';
import 'package:ecommerce/widgets/changescreen.dart';
import 'package:ecommerce/widgets/mytextformfield.dart';
import 'package:ecommerce/widgets/passwordtextformfield.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController username = TextEditingController();

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);


bool obserText = true;

class _LoginState extends State<Login> {
  void validation() async {
    if (
    email.text.isEmpty &&
        password.text.isEmpty
    ) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Dy fushat janë të zbrazëta"),
        ),
      );
    } else if (email.text.isEmpty){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Email-i është i zbrazët"))
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Ju lutem provoni një email valide"))
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Fjalëkalimi është i zbrazët"))
      );
    } else if (password.text.length < 8) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Fjalëkalimi është shumë i shkurtër"))
      );
    }
    else {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email.text, password: password.text);
        print(result);
      } on PlatformException catch (e) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(e.message),
          ),
        );
      }
    }
  }
Widget _buildAllPart(){
  return  Container(
      height:300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Kyçu", style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold),
          ),
          MyTextFormField(
              name: "Email-i",
            controller: email,
          ),
          PasswordTextFormField(
            obserText: obserText,
            controller: password,
            name: "Fjalëkalimi",
            onTap: (){
              FocusScope.of(context).unfocus();
              setState(() {
                obserText=!obserText;
              });
            },
          ),
          MyButton(press: (){
            validation();
          },
            name: "Kyçu",
          ),
          ChangeScreen(name: "Regjistrohu", whichAccount: "Nuk kam një llogari!",
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => SignUp(),
              ),
              );
            },
          ),
        ],
      )
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildAllPart(),
                ],
              )
          ),
        )
    );
  }
}