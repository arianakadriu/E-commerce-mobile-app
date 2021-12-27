import 'package:ecommerce/model/cartmodel.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ProductProvider with ChangeNotifier {
  List<Product> featured = [];
  Product featuredData;
  List<CartModel> CheckoutModelList = [];
  CartModel checkOutModel;
  // List<CartModel> myCheckOut;
  List<UserModel> userModelList=[];
  UserModel userModel;
  Future<void> getUserData() async {
    List<UserModel> newList=[];
    User currentUser= FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot = await FirebaseFirestore.instance.
    collection("User").get();
    userSnapShot.docs.forEach((element) {
      if(currentUser.uid==element.data()["UserId"]){
        userModel=UserModel(
          userImage: element.data()["UserImage"],
          userEmail: element.data()["UserEmail"],
          userGender: element.data()["UserGender"],
          userName: element.data()["UserName"],
          userPhoneNumber: element.data()["PhoneNumber"],
          userAddress: element.data()["UserAddress"]
        );
        newList.add(userModel);
      }
      userModelList=newList;

    },
    );
    notifyListeners();

  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  void deleteCartProduct(int index) {
    CheckoutModelList.removeAt(index);
    notifyListeners();
  }

  void deleteCheckoutProduct(int index) {
    CheckoutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    CheckoutModelList.clear();
    notifyListeners();
  }

  void getCheckoutData({
    String name,
    String image,
    String color,
    String size,
    int quantity,
    double price,
  }) {
    checkOutModel = CartModel(
        color: color,
        size: size,
        price: price,
        name: name,
        image: image,
        quantity: quantity);
    CheckoutModelList.add(checkOutModel);
  }

  List<CartModel> get getCartModelList {
    return List.from(CheckoutModelList);
  }

  int get getCheckoutModelListLength {
    return CheckoutModelList.length;
  }


  Future<void> getFeaturedData() async {
    List<Product> newList = [];
    QuerySnapshot featuredSnapShot = await FirebaseFirestore.instance.
    collection("products").
    doc("q2A6eyrmCvEqtL91Rb9u").
    collection("featuredproduct").get();
    featuredSnapShot.docs.forEach((element) {
      featuredData = Product(
          image: element.data()["image"],
          name: element.data()["name"],
          price: element.data()["price"]);
      newList.add(featuredData);
    },
    );
    featured = newList;
  }

  List<Product> get getFeaturedList {
    return featured;
  }

  List<Product> homeFeatured = [];

  Future<void> getHomeFeaturedData() async {
    List<Product> newList = [];
    QuerySnapshot featuredSnapShot = await FirebaseFirestore.instance.
    collection("homefeatured").get();
    featuredSnapShot.docs.forEach((element) {
      featuredData = Product(
          image: element.data()["image"],
          name: element.data()["name"],
          price: element.data()["price"]);
      newList.add(featuredData);
    },
    );
    homeFeatured = newList;
    notifyListeners();
  }

  List<Product> get getHomeFeaturedList {
    return homeFeatured;
  }


  List<Product> homeArrivals = [];

  Future<void> getHomeArrivalsData() async {
    List<Product> newList = [];
    QuerySnapshot featuredSnapShot = await FirebaseFirestore.instance.
    collection("homearrivals").get();
    featuredSnapShot.docs.forEach((element) {
      featuredData = Product(
          image: element.data()["image"],
          name: element.data()["name"],
          price: element.data()["price"]);
      newList.add(featuredData);
    },
    );
    homeArrivals = newList;
    notifyListeners();
  }

  List<Product> get getHomeArrivalsList {
    return homeArrivals;
  }


  List<Product> newArrivals = [];
  Product newArrivalsData;

  Future<void> getNewArrivalsData() async {
    List<Product> newList = [];
    QuerySnapshot newArrivalsSnapShot = await FirebaseFirestore.instance.
    collection("products").
    doc("q2A6eyrmCvEqtL91Rb9u").
    collection("newarrivals").get();
    newArrivalsSnapShot.docs.forEach((element) {
      newArrivalsData = Product(
          image: element.data()["image"],
          name: element.data()["name"],
          price: element.data()["price"]);
      newList.add(newArrivalsData);
    },
    );
    newArrivals = newList;
    notifyListeners();
  }

  List<Product> get getNewArrivalsList {
    return newArrivals;
  }

  List<String> notificationList=[];

  void addNotification(String notification) {
    notificationList.add(notification);

  }
 void removeNotification(int index) {
    notificationList.removeAt(index);
 }
  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  int get getNotificationOnCheckout {
    notificationList.clear();
    return notificationList.length;
  }

  List<Product> searchList;
  void getSearchList({List<Product> list}){
    searchList= list;
  }

  List<Product> searchProductList(String query){
    List<Product> searchShirt=searchList.where((element){
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }

}

