import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/widgets/cartsingleproduct.dart';
import 'package:ecommerce/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextStyle myStyle= TextStyle(
    fontSize: 18,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductProvider productProvider;

  Widget _buildBottomDetail(String startName, String endName){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(startName, style: myStyle,),
        Text(endName, style: myStyle,),
      ],
    );
  }

  // final TextStyle myStyle= TextStyle(
  //   fontSize: 18,
  // );


  double total;
  int index;
  User user;
  Widget _buildButton(){
    return Column(
      children: productProvider.userModelList.map((e) {
       return Container(
         height: 55,
           width: double.infinity,
           child: RaisedButton(color: Color(0xff746bc9),
          child: Text("Blej",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {
             if(productProvider.CheckoutModelList.isNotEmpty){
               FirebaseFirestore.instance.collection("Order")
                   .doc(user.uid).set({
                 "Product": productProvider.CheckoutModelList
                     .map((c)=>{
                   "ProductName": c.name,
                   "ProductPrice": c.price,
                   "ProductQuantity": c.quantity,
                   "ProductImage": c.image,
                   "ProductColor": c.color,
                   "ProductSize": c.size,
                 }).toList(),
                 "TotalPrice": total.toStringAsFixed(2),
                 "UserName": e.userName,
                 "UserEmail": e.userEmail,
                 "PhoneNumber": e.userPhoneNumber,
                 "UserAddress": e.userAddress,
                 "UserUid": user.uid
               });
               productProvider.clearCheckoutProduct();
               productProvider.getNotificationOnCheckout;             }
             else {
               _scaffoldKey.currentState.showSnackBar(
                   SnackBar(content: Text("Nuk ka produkte")));
             }

          },
        )
       );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    user=FirebaseAuth.instance.currentUser;
    double subTotal=0;
    double discount=3;
    double discountPercentage;
    double shipping=10;
    productProvider=Provider.of<ProductProvider>(context);
    productProvider.getCartModelList.forEach((element) {
      subTotal+=element.price * element.quantity;
    });
    discountPercentage=discount/100*subTotal;
    total= subTotal+shipping-discountPercentage;
    if(productProvider.CheckoutModelList.isEmpty) {
      total=0.0;
      discount=0.0;
      shipping=0.0;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          title: Text("Pagesa", style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder:(ctx)=>HomePage(),),);
            },
          ),
          actions: <Widget>[
            NotificationButton(),
          ]
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        child: _buildButton(),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 480,
                child: ListView.builder(
                itemCount: productProvider.getCheckoutModelListLength,
                itemBuilder: (ctx, myIndex){
                  index=myIndex;
                  return CartSingleProduct(
                  isCount: true,
                  index: myIndex,
                    color: productProvider.CheckoutModelList[myIndex].color,
                    size: productProvider.CheckoutModelList[myIndex].size,
                    image: productProvider.CheckoutModelList[myIndex].image,
                  name: productProvider.CheckoutModelList[myIndex].name,
                  price: productProvider.CheckoutModelList[myIndex].price,
                  quantity: productProvider.CheckoutModelList[myIndex].quantity,
                );}),
              ),
              Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildBottomDetail( "Çmimi",  "${subTotal.toStringAsFixed(2)} \€"),
                    _buildBottomDetail( "Zbritja",  "${discount.toStringAsFixed(2)}%"),
                    _buildBottomDetail( "Transporti",  "${shipping.toStringAsFixed(2)} \€"),
                    _buildBottomDetail( "Totali",  " ${total.toStringAsFixed(2)} \€"),
                  ],
                ),
              )
            ],

      ),
      ),
    );
  }
}
