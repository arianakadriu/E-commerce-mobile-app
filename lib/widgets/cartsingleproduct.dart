import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final bool isCount;
  final int index;
  final String color;
  final String size;
   int quantity;
  final double price;
  CartSingleProduct({this.index, this.color, this.size, this.isCount, this.quantity, this.image, this.name, this.price});

  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}


TextStyle myStyle= TextStyle(fontSize: 18);
ProductProvider productProvider;

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    productProvider= Provider.of<ProductProvider>(context);

    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 130,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.fill,
                      )
                  ),
                ),
                Container(
                  height: 140,
                  width: 270,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.name, style: myStyle,),
                              IconButton(icon: Icon(Icons.close),
                                onPressed: (){
                                widget.isCount==false? productProvider
                                    .deleteCartProduct(widget.index):
                                productProvider.deleteCheckoutProduct(widget.index);
                                  // productProvider.deleteCartProduct(widget.index);
                                  // productProvider.deleteCheckoutProduct(widget.index);

                                  productProvider.removeNotification(widget.index);
                                productProvider.getNotificationIndex;
                                }
                                ,)
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.color, style: myStyle,),
                              Text(widget.size, style: myStyle,),
                            ],
                          ),
                        ),
                        Text(" ${widget.price.toString()} \€",
                          style: TextStyle(color: Color(0xff9b96d6),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                            height: 35,
                            width:  70,
                            color: Color(0xfff2f2f2),
                            child: widget.isCount==false? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.remove),
                                  onTap: (){
                                    setState(() {
                                      if(widget.quantity>1) {
                                        widget.quantity--;
                                        productProvider.getCheckoutData(
                                            quantity: widget.quantity,
                                          image: widget.image,
                                          color: widget.color,
                                          size: widget.size,
                                          name: widget.name,
                                          price: widget.price,
                                        );
                                      }
                                    });
                                  },
                                ),
                                Text(widget.quantity.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                GestureDetector(
                                  child: Icon(Icons.add),
                                  onTap: (){
                                    setState(() {
                                      widget.quantity++;
                                      productProvider.getCheckoutData(
                                        quantity: widget.quantity,
                                        image: widget.image,
                                        color: widget.color,
                                        size: widget.size,
                                        name: widget.name,
                                        price: widget.price,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ): Row (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Sasia"),
                                Text(widget.quantity.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
