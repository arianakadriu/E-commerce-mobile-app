import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/widgets/cartsingleproduct.dart';
import 'package:ecommerce/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/screens/homepage.dart';

class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}
ProductProvider productProvider;

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    productProvider=Provider.of<ProductProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(color: Color(0xff746bc9), child: Text("Vazhdo",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
          onPressed: () {
          // productProvider.addNotification("Notification");
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder:(ctx)=>CheckOut(),),);
          },
        ),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: Text("Shporta", style: TextStyle(color: Colors.black),),
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
      body: ListView.builder(
        itemCount: productProvider.getCheckoutModelListLength,
        itemBuilder: (ctx, index)=> CartSingleProduct(
          isCount: false,
          color: productProvider.getCartModelList[index].color,
          size: productProvider.getCartModelList[index].size,
          index: index,
          image: productProvider.getCartModelList[index].image,
          name: productProvider.getCartModelList[index].name,
          price: productProvider.getCartModelList[index].price,
          quantity: productProvider.getCartModelList[index].quantity,
        ),
      ),
    );
  }
}
