 import 'package:ecommerce/provider/category_provider.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/screens/cartscreen.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/signup.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/homepage.dart';
import 'package:ecommerce/screens/listproduct.dart';
import 'package:ecommerce/screens/detailscreen.dart';
import 'package:ecommerce/screens/cartscreen.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/screens/welcomescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff746bc9),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return WelcomeScreen();
              //  return ProfileScreen();
            }
          },
        ),
      ),
    );
  }
}


