import 'package:flutter/material.dart';
import 'package:ecommerce/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/categoryicon.dart';

class CategoryProvider with ChangeNotifier {
  List<Product> shirt=[];
  Product shirtData;
  List<Product> dress=[];
  Product dressData;
  List<Product> shoes=[];
  Product shoesData;
  List<Product> pants=[];
  Product pantsData;
  List<Product> hats=[];
  Product hatsData;
  List<CategoryIcon> dressIcon=[];
  CategoryIcon dressiconData;

  Future<void> getDressIcon() async {
    List<CategoryIcon> newList=[];
    QuerySnapshot dressSnapShot= await FirebaseFirestore.instance.
    collection("categoryicon").
    doc("u4TDBz7Fc8Ifwqvg2Yw4").
    collection("dress").get();
    dressSnapShot.docs.forEach((element) {dressiconData=CategoryIcon(
        image: element["image"]);
    newList.add(dressiconData);
    },
    );
    dressIcon= newList;
    notifyListeners();
  }

  List<CategoryIcon> get getDressIconList {
    return dressIcon;
  }

  List<CategoryIcon> shoesIcon=[];
  CategoryIcon shoesiconData;

  Future<void> getShoesIcon() async {
    List<CategoryIcon> newList=[];
    QuerySnapshot shoesSnapShot= await FirebaseFirestore.instance.
    collection("categoryicon").
    doc("u4TDBz7Fc8Ifwqvg2Yw4").
    collection("shoes").get();
    shoesSnapShot.docs.forEach((element) {shoesiconData=CategoryIcon(
        image: element["image"]);
    newList.add(shoesiconData);
    },
    );
    shoesIcon= newList;
    notifyListeners();
  }

  List<CategoryIcon> get getShoesIconList {
    return shoesIcon;
  }

  List<CategoryIcon> shirtIcon=[];
  CategoryIcon shirticonData;

  Future<void> getShirtIcon() async {
    List<CategoryIcon> newList=[];
    QuerySnapshot shirtSnapShot= await FirebaseFirestore.instance.
    collection("categoryicon").
    doc("u4TDBz7Fc8Ifwqvg2Yw4").
    collection("shirt").get();
    shirtSnapShot.docs.forEach((element) {shirticonData=CategoryIcon(
        image: element["image"]);
    newList.add(shirticonData);
    },
    );
    shirtIcon= newList;
    notifyListeners();
  }

  List<CategoryIcon> get getShirtIconList {
    return shirtIcon;
  }

  List<CategoryIcon> pantsIcon=[];
  CategoryIcon pantsiconData;

  Future<void> getPantsIcon() async {
    List<CategoryIcon> newList=[];
    QuerySnapshot pantsSnapShot= await FirebaseFirestore.instance.
    collection("categoryicon").
    doc("u4TDBz7Fc8Ifwqvg2Yw4").
    collection("pants").get();
    pantsSnapShot.docs.forEach((element) {pantsiconData=CategoryIcon(
        image: element["image"]);
    newList.add(pantsiconData);
    },
    );
    pantsIcon= newList;
    notifyListeners();
  }

  List<CategoryIcon> get getPantsIconList {
    return pantsIcon;
  }

  List<CategoryIcon> hatsIcon=[];
  CategoryIcon hatsiconData;

  Future<void> getHatsIcon() async {
    List<CategoryIcon> newList=[];
    QuerySnapshot hatsSnapShot= await FirebaseFirestore.instance.
    collection("categoryicon").
    doc("u4TDBz7Fc8Ifwqvg2Yw4").
    collection("hats").get();
    hatsSnapShot.docs.forEach((element) {hatsiconData=CategoryIcon(
        image: element["image"]);
    newList.add(hatsiconData);
    },
    );
    hatsIcon= newList;
    notifyListeners();
  }

  List<CategoryIcon> get getHatsIconList {
    return hatsIcon;
  }


  Future<void> getShirtData() async {
    List<Product> newList=[];
    QuerySnapshot shirtSnapShot= await FirebaseFirestore.instance.
    collection("category").
    doc("mdLOBscsd3HHTSuUmnou").
    collection("shirt").get();
    shirtSnapShot.docs.forEach((element) {shirtData=Product(
      image: element.data()["image"],
      name: element.data()["name"],
      price: element.data()["price"]);
      newList.add(shirtData);
    }, 
    );
    shirt= newList;
    notifyListeners();
  }


  List<Product> get getShirtList {
    return shirt;
  }

  Future<void> getDressData() async {
    List<Product> newList=[];
    QuerySnapshot dressSnapShot= await FirebaseFirestore.instance.
    collection("category").
    doc("mdLOBscsd3HHTSuUmnou").
    collection("dress").get();
    dressSnapShot.docs.forEach((element) {dressData=Product(
        image: element.data()["image"],
        name: element.data()["name"],
        price: element.data()["price"]);
    newList.add(dressData);
    },
    );
    dress= newList;
    notifyListeners();
  }


  List<Product> get getDressList {
    return dress;
  }
  Future<void> getShoesData() async {
    List<Product> newList=[];
    QuerySnapshot shoesSnapShot= await FirebaseFirestore.instance.
    collection("category").
    doc("mdLOBscsd3HHTSuUmnou").
    collection("shoes").get();
    shoesSnapShot.docs.forEach((element) {shoesData=Product(
        image: element.data()["image"],
        name: element.data()["name"],
        price: element.data()["price"]);
    newList.add(shoesData);
    },
    );
    shoes= newList;
    notifyListeners();
  }


  List<Product> get getShoesList {
    return shoes;
  }
  Future<void> getPantsData() async {
    List<Product> newList=[];
    QuerySnapshot pantsSnapShot= await FirebaseFirestore.instance.
    collection("category").
    doc("mdLOBscsd3HHTSuUmnou").
    collection("pants").get();
    pantsSnapShot.docs.forEach((element) {pantsData=Product(
        image: element.data()["image"],
        name: element.data()["name"],
        price: element.data()["price"]);
    newList.add(pantsData);
    },
    );
    pants= newList;
    notifyListeners();
  }


  List<Product> get getPantsList {
    return pants;
  }
  Future<void> getHatsData() async {
    List<Product> newList=[];
    QuerySnapshot hatsSnapShot= await FirebaseFirestore.instance.
    collection("category").
    doc("mdLOBscsd3HHTSuUmnou").
    collection("hats").get();
    hatsSnapShot.docs.forEach((element) {hatsData=Product(
        image: element.data()["image"],
        name: element.data()["name"],
        price: element.data()["price"]);
    newList.add(hatsData);
    },
    );
    hats= newList;
    notifyListeners();
  }


  List<Product> get getHatsList {
    return hats;
  }


  List<Product> searchList;
  void getSearchList({List<Product> list}){
    searchList= list;
  }

  List<Product> searchCategoryList(String query){
    List<Product> searchShirt=searchList.where((element){
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }


}