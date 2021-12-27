import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:flutter/services.dart';
import '../widgets/mybutton.dart';
import '../widgets/changescreen.dart';
import '../widgets/mytextformfield.dart';
import '../widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText= true;
final TextEditingController email = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController username = TextEditingController();
final TextEditingController address = TextEditingController();

// String email;
// String phoneNumber;
bool isMale=true;
// String password;
// String username;

class _SignUpState extends State<SignUp> {
  void validation() async {
   if(username.text.isEmpty &&
   email.text.isEmpty &&
   password.text.isEmpty &&
   phoneNumber.text.isEmpty &&
   address.text.isEmpty) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(
         content: Text("Të gjitha fushat janë të zbrazëta"),
       ),
     );
   } else if (username.text.length < 6) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(
         content: Text("Emri duhet të jetë 6 "),
       ),
     );
   }else if (!regExp.hasMatch(email.text)){
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(content: Text("Ju lutem provoni një email valide"))
     );
   } else if (password.text.isEmpty) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(content: Text("Fjalëkalimi është i zbrazët"))
     );
   } else if (phoneNumber.text.length<8) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(content: Text("Fjalëkalimi është shumë i shkurtër"))
     );
   } else if (phoneNumber.text.length < 9 || phoneNumber.text.length > 9) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(
         content: Text("Numri i telefonit duhet të jetë 9 "),
       ),
     );
   } else if (address.text.isEmpty) {
     _scaffoldKey.currentState.showSnackBar(
         SnackBar(content: Text("Adresa është e zbrazët"))
     );
   } else {
     try {
           UserCredential result = await FirebaseAuth.instance
               .createUserWithEmailAndPassword(email: email.text, password: password.text);
           FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
             "UserName":username.text,
             "UserId":result.user.uid,
             "UserEmail":email.text,
             "UserAddress":address.text,
             "UserGender":isMale==true?"Male": "Female",
             "PhoneNumber":phoneNumber.text,
           });
         } on PlatformException catch (e) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar( content: Text(e.message),
             ),
           );
         }
   }
  }

  Widget _buildAllTextFormField() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 340,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyTextFormField(
                name: "Emri i përdoruesit",
              controller: username,
            ),
            MyTextFormField(
                name: "Email",
              controller: email,
            ),
            PasswordTextFormField(
              obserText: obserText,
              controller: password,
              name: "Fjalëkalimi",
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  obserText = !obserText;
                });
              },
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  isMale=!isMale;
                });
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left:10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
                ),
                child: Center(
                  child: Row(
                    children: [
                      Text(isMale==true? "Mashkull": "Femër", style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18
                      )),
                    ],
                  ),
                )
              ),
            ),
            MyTextFormField(
                  name: "Numri i telefonit",
              controller: phoneNumber,
              ),
            MyTextFormField(
              name: "Adresa",
              controller: address,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
        height: 500,
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildAllTextFormField(),
            MyButton(press: () {
              validation();
            },
              name: "Regjistrohu",
            ),
            ChangeScreen(
              name: "Kyçu", whichAccount: "Kam llogari!",
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => Login(),
                ),
                );
              },
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 180,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Regjistrohu", style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildBottomPart(),
                ],
              ),
            ),
          ),
        )
    );
  }
}
