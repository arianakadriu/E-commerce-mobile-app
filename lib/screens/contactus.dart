import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce/model/usermodel.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

  final TextEditingController message = TextEditingController();


  String name, email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ContactUsState extends State<ContactUs> {

  void validation() async {
    if (message.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Ju lutem plotësoni mesazhin"),
        ),
      );
    } else {
      User user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Mesazhi u dërgua me sukses!")));
    }
  }
ProductProvider provider;
//   void getEmail(){
//     provider.userModelList.map((e) {
//       name = e.userName;
//           email = e.userEmail;
//       return Container();
//     });
//   }
  Widget _buildSingleField({String name}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    ProductProvider provider;
    provider = Provider.of<ProductProvider>(context, listen: false);
    List<UserModel> user = provider.userModelList;
    user.map((e) {
      name = e.userName;
      email = e.userEmail;

      return Container();
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProductProvider>(context);
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xfff8f8f8),
          title: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff746bc9),
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => HomePage()));
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 27),
          height: 600,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Na dërgoni mesazhin tuaj",
                style: TextStyle(
                  color: Color(0xff746bc9),
                  fontSize: 28,
                ),
              ),
              _buildSingleField(name: name),
              _buildSingleField(name: email),
              Container(
                height: 200,
                child: TextFormField(
                  controller: message,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: " Mesazhi",
                  ),
                ),
              ),
              MyButton(
                name: "Dërgo",
                press: () {
                  validation();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}