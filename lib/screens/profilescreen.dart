import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/usermodel.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/widgets/mybutton.dart';
import 'package:ecommerce/widgets/mytextformfield.dart';
import 'package:ecommerce/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'homepage.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _formKey= GlobalKey<FormState>();
  UserModel userModel;
   TextEditingController phoneNumber;
   TextEditingController userName;
  TextEditingController address;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> finalValidation() async {
   await _uploadImage(image: _pickedImage);
   await userDetailUpdate();
   _scaffoldKey.currentState.showSnackBar(
       SnackBar(content: Text("Profili u editua me sukses!")));
  }
  bool isMale = false;

  void validation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Të gjitha fushat janë të zbrazëta"),
        ),
      );
    } else if (userName.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Emri është i zbrazët"),
        ),
      );
    } else if (userName.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Emri duhet të jetë 6 "),
        ),
      );
    } else if (phoneNumber.text.length < 9 || phoneNumber.text.length > 9) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Numri i telefonit duhet të jetë 9"),
        ),
      );
    } else {
      finalValidation();
    }
  }
  Future<void> userDetailUpdate() {
    FirebaseFirestore.instance.collection("User").doc(user.uid).update({
      "UserName": userName.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "PhoneNumber": phoneNumber.text,
      "UserImage": imageUrl==null?"":imageUrl,
      "UserAddress":address.text
    });
    return null;
  }
  File _pickedImage;
  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image= await ImagePicker().getImage(source: source);
    if (_image !=null) {
      setState(() {
        _pickedImage=File(_image.path);
      });
    }
  }
  String imageUrl;
  User user;
  Future<void> _uploadImage({File image})async {
    user=FirebaseAuth.instance.currentUser;
    StorageReference storageReference=FirebaseStorage.instance.ref().child("UserImage/${user.uid}");
    StorageUploadTask uploadTask= storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    imageUrl= await snapshot.ref.getDownloadURL();
  }


Widget _buildSingleContainer({Color color, String startText, String endText}) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)),
    child: Container(
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: edit==true? color: Colors.white,
          borderRadius: edit==false ?
          BorderRadius.circular(30) :
          BorderRadius.circular(0)),
      width: double.infinity,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(startText,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(endText,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ]
      ),
    ),
  );
}

Widget _buildSingleTextFormField({String name}) {
  return TextFormField(
    decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
    ),
  );
}
String userImage;
bool edit=false;
Widget _buildContainerPart(){
  userName=TextEditingController(text: userModel.userName);
  phoneNumber=TextEditingController(text: userModel.userPhoneNumber);
  address=TextEditingController(text: userModel.userAddress);
  userImage=userModel.userImage;
  if(userModel.userGender=="Mashkull") {
      isMale = true;
  } else {
    isMale=false;
  }
        return Container(
          height: 315,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSingleContainer(
                endText: userModel.userName,
                startText: "Emri",
              ),
              _buildSingleContainer(
                endText: userModel.userEmail,
                startText: "Email-i",
              ),
              _buildSingleContainer(
                endText: userModel.userGender,
                startText: "Gjinia",
              ),
              _buildSingleContainer(
                endText: userModel.userPhoneNumber,
                startText: "Numri i telefonit",
              ),
              _buildSingleContainer(
                endText: userModel.userAddress,
                startText: "Adresa",
              ),
            ],
          ),
        );
}

  Widget _buildTextFormFieldPart(){
    return Container(
          height: 320,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyTextFormField(
                    name: "Emri i përdoruesit",
                  controller: userName,
                ),
                _buildSingleContainer(
                    color: Colors.grey[300],
                    endText: userModel.userEmail,
                    startText: "Email-i"
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isMale=!isMale;
                    });
                  },
                  child: _buildSingleContainer(
                      color: Colors.white,
                      endText: isMale==true? "Mashkull":"Femër",
                      startText: "Gjinia"
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
        );
  }

  Future<void> myDialogBox() {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Zgjedh nga kamera"),
              onTap: (){
               getImage(source: ImageSource.camera);
               Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Zgjedh nga galeria"),
              onTap: (){
                getImage(source: ImageSource.gallery);
                Navigator.of(context).pop();
              },
            )
          ]
        )
      )
    );
    }
  );
  }

  @override
  Widget build(BuildContext context) {
    User user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit==true? IconButton(icon: Icon(
          Icons.close, color: Colors.redAccent, size: 30,),
          onPressed: (){
          setState(() {
            edit=false;
          });
          },
        ):IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            });
          },
        ),
        backgroundColor: Colors.white,
        actions: [
          edit==false ? NotificationButton():
              IconButton(
                icon: Icon(Icons.check, size: 30, color: Color(0xff746bc9),),
                onPressed: (){
                  validation();
                },)
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("User").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var myDoc=snapshot.data.docs;
          myDoc.forEach((checkDocs){
            if (checkDocs.data()["UserId"]==user.uid) {
              userModel=UserModel(
                  userEmail: checkDocs.data()["UserEmail"],
                  userImage: checkDocs.data()["UserImage"],
                  userGender: checkDocs.data()["UserGender"],
                  userName: checkDocs.data()["UserName"],
                  userPhoneNumber: checkDocs.data()["PhoneNumber"],
                  userAddress: checkDocs.data()["UserAddress"]
              );
            }
          });
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                height: 620,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                maxRadius: 65,
                                backgroundImage: _pickedImage==null? userModel.userImage==null ?
                                AssetImage("images/man.png") :
                                NetworkImage(userModel.userImage): FileImage(_pickedImage),
                              ),
                            ],
                          ),
                        ),
                      edit==true?  Padding(
                          padding: const EdgeInsets.only(left: 210, top: 100),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                myDialogBox();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.camera_alt, color: Color(0xff746bc9)),
                              ),
                            ),
                          ),
                        ): Container(),
                      ],
                    ),
                    Container(
                      height: 350,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         Expanded(
                           child: Container(
                             child: edit==true
                                 ? _buildTextFormFieldPart() :
                             _buildContainerPart(),
                             // Container()
                           ),
                         ),
                        ]
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 200,
                        child: edit==false ? MyButton(
                          name: "Edito profilin",
                          press: (){
                            setState(() {
                              edit=true;
                            });
                          },
                        ) : Container(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
