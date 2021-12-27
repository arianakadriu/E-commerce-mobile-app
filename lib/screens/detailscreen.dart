import 'package:ecommerce/screens/cartscreen.dart';
import 'package:ecommerce/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/homepage.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  DetailScreen({this.image, this.name, this.price});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count=1;
  ProductProvider productProvider;

  // Widget _buildSizeProduct({String name}){
  //   return Container(
  //       height: 60,
  //       width: 60,
  //       color: Color(0xfff2f2f2),
  //       child: Center(
  //           child: Text(
  //             name,
  //             style: TextStyle(
  //               fontSize: 17,
  //             ),
  //           )
  //       )
  //   );
  //
  // }

  Widget _buildColorProduct({Color color}){
    return Container(
        height: 40,
        width: 40,
        color: color,
    );

  }

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 350,
        child: Card(
            child: Container(
              padding: EdgeInsets.all(13),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.fill),
                ),
              ),
            )
        ),
      ),
    );
  }

  Widget _buildNameToDescPart() {
   return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.name,
                  style: myStyle
              ),
              Text(" ${widget.price.toString()} \€",
                style: TextStyle(
                  color: Color(0xff9b96d6),
                  fontSize: 18,
                ),
              ),
              Text("Përshkrimi",
                style: myStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
        height: 100,
        child: Wrap(
          children: <Widget>[
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. "
              ,style: TextStyle(fontSize: 15),
            )
          ],
        )
    );
  }
List<bool> isSelected=[true, false, false, false];
  List<bool> colorSelected=[true, false, false, false];
  int sizeIndex=0;
  String size;
  void getSize(){
    if(sizeIndex==0){
      setState(() {
        size="S";
      });
    } else if(sizeIndex==1){
      setState(() {
        size="M";
      });
    } else if(sizeIndex==2){
      setState(() {
        size="L";
      });
    } else if(sizeIndex==3){
      setState(() {
        size="XL";
      });
    }
  }

  int colorIndex=0;
  String color;
  void getColor(){
    if(colorIndex==0){
      setState(() {
        color="Blu";
      });
    } else if(colorIndex==1){
      setState(() {
        color="Jeshile";
      });
    } else if(colorIndex==2){
      setState(() {
        color="Verdhë";
      });
    } else if(colorIndex==3){
      setState(() {
        color="Rozë";
      });
    }
  }

  Widget _buildSizePart() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Text("Madhësia",
          style: myStyle,
        ),
        SizedBox(
          height: 15,
        ),
      Container(
        width: 265,
        child: ToggleButtons(children: [
          Text("S"),
          Text("M"),
          Text("L"),
          Text("XL"),
        ],
          onPressed: (int index) {
          setState(() {
            for (int indexBtn=0; indexBtn<isSelected.length;indexBtn++){
              if(indexBtn==index) {
                isSelected[indexBtn]=true;
              }
              else {
                isSelected[indexBtn]=false;
              }
            }
          });
          setState(() {
            sizeIndex=index;
          });
          },
          isSelected: isSelected,
        )
      )
        ]
    );
  }

  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Ngjyra",
          style: myStyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            width: 265,
            child: ToggleButtons(
              fillColor: Color(0xff746bc9),
              renderBorder: false,
              children: [
              _buildColorProduct(color: Colors.blue[200]),
              _buildColorProduct(color: Colors.green[200]),
              _buildColorProduct(color: Colors.yellow[200]),
              _buildColorProduct(color: Colors.red[300]),
            ],
              onPressed: (int index) {
                setState(() {
                  for (int indexBtn=0; indexBtn<colorSelected.length;indexBtn++){
                    if(indexBtn==index) {
                      colorSelected[indexBtn]=true;
                    }
                    else {
                      colorSelected[indexBtn]=false;
                    }
                  }
                });
                setState(() {
                  colorIndex=index;
                });
              },
              isSelected: colorSelected,
            )
        )
      ],
    );
  }

  Widget _buildQuantityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height:10,
        ),
        _buildColorPart(),
        SizedBox(height: 10,),
        Text("Sasia",
            style: myStyle
        ),
        SizedBox(height: 10,),
        Container(
            height: 40,
            width: 130,
            decoration: BoxDecoration(
                color: Color(0xff746bc9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.remove, color: Colors.white),
                  onTap: (){
                    setState(() {
                      if(count>1) {
                        count--;
                      }
                    });
                  },
                ),
                Text(count.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.add, color: Colors.white,),
                  onTap: (){
                    setState(() {
                      count++;
                    });
                  },
                ),
              ],
            )
        ),
      ],
    );
  }

  Widget _buildButtonPart() {
    return Container(
      height:60,
      width: double.infinity,
      child: RaisedButton(
        color: Color(0xff746bc9),
        child: Text("Shto në shportë", style: TextStyle(color: Colors.white,
            fontSize: 18),),
        onPressed: (){
          getSize();
          getColor();
          productProvider.getCheckoutData(
            image: widget.image,
            color: color,
            size: size,
            name: widget.name,
            price: widget.price,
            quantity: count,
          );
          productProvider.addNotification("Notification");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx)=>CartScreen(),
          ),

          );
        },

      ),
    );
  }

final TextStyle myStyle= TextStyle(
  fontSize: 18,
);

  @override
  Widget build(BuildContext context) {
    productProvider= Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Produkti", style: TextStyle(color: Colors.black),),
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
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildImage(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 _buildNameToDescPart(),
                  _buildDescription(),
                  _buildSizePart(),
                  _buildQuantityPart(),
                  SizedBox(
                    height:15,
                  ),
                  _buildButtonPart(),
                ],
              )
            ),
          ],
        )
      )
    );
  }
}
