import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/detailscreen.dart';
import 'package:ecommerce/screens/search_category.dart';
import 'package:ecommerce/screens/search_product.dart';
import 'package:ecommerce/widgets/notification_button.dart';
import 'package:ecommerce/widgets/singleproduct.dart';
import '../provider/category_provider.dart';
import '../provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
final String name;
bool isCategory=true;
final List<Product> snapShot;
ListProduct({this.name, this.isCategory, this.snapShot});
  @override
  Widget build(BuildContext context) {

    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            }),
        actions: <Widget>[
       isCategory==true? IconButton(icon: Icon(Icons.search, color: Colors.black,),onPressed: (){
          categoryProvider.getSearchList(list: snapShot);
          showSearch(context: context, delegate: SearchCategory());
        }, ): IconButton(icon: Icon(Icons.search, color: Colors.black),onPressed: (){
    productProvider.getSearchList(list: snapShot);
    showSearch(context: context, delegate: SearchProduct());
    }, ),
        // IconButton(icon: Icon(Icons.notifications_none, color: Colors.black), onPressed: (){},
        // ),
          NotificationButton(),

        ],

      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(name ?? '', style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 600,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    scrollDirection: Axis.vertical,
                    children: snapShot.map((e) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx)=>DetailScreen(
                              image: e.image,
                              name: e.name,
                              price: e.price
                            )));
                      },
                      child: SingleProduct(
                        price: e.price, image: e.image, name: e.name),
                    ))
                  .toList(),
                ),
                ),
    ],
    ),
          ],
        ),
      ),
    );
  }
}
