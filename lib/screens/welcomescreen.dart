import 'package:flutter/material.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/signup.dart';
class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 600,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
    Container(
    height: 250,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.cover,
    image: AssetImage("images/shopping-2.png")),
    ),
    ),
    Text("Mirë se vini",
    style: TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    Container(
    height: 110,
    width: double.infinity,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text("Për të filluar",
    style: TextStyle(fontSize: 18),
    ),
    Container(
    height: 45,
    width: double.infinity,
    child: RaisedButton(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10)
    ),
    child: Text("Regjistrohu",
    style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    color: Color(0xff746bc9),
    onPressed: (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx)=>SignUp()));
    },
    ),
    ),
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text("Ke një llogari?",
    style: TextStyle(fontSize: 18, color: Color(0xff746bc9)),),
    GestureDetector(
    onTap: (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx)=>Login()));
    },
    child: Text("Kyçu",
    style: TextStyle(fontSize: 18, color: Color(0xff746bc9)),),
    )
    ],
    ),
      ],
    ),
    ),
                  ],
                ),
              )
            ],
                ),
              ),
          ),
    );
  }
}
