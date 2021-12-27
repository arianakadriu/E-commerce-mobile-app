import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/usermodel.dart';
import 'package:ecommerce/provider/category_provider.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/screens/cartscreen.dart';
import 'package:ecommerce/screens/profilescreen.dart';
import 'package:ecommerce/screens/search_category.dart';
import 'package:ecommerce/widgets/singleproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/screens/listproduct.dart';
import 'package:ecommerce/screens/detailscreen.dart';
import '../model/product.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../provider/category_provider.dart';
import '../model/categoryicon.dart';
import '../widgets/notification_button.dart';
import 'about.dart';
import 'contactus.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}
CategoryProvider categoryProvider;
ProductProvider productProvider;
Product dressData;
Product watchData;
Product monitorData;
Product systemUnitData;
var featuredSnapShot;
var newArrivalsSnapShot;
var hats;
var shoes;
var pants;
var dress;
var shirt;

class _HomePageState extends State<HomePage> {
  Widget _buildCategoryProduct(String image, int color) {
    return CircleAvatar(
        maxRadius: 34,
        backgroundColor: Color(color),
        child: Container(
          height: 30,
          child: Image(
            color: Colors.white,
            image: NetworkImage(image),
          ),
        )
    );
  }

  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = productProvider.userModelList;
    return Column(
      children: userModel.map((e)  {
        return  UserAccountsDrawerHeader(
            accountName: Text(e.userName, style: TextStyle(color: Colors.black),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: e.userImage==null ?
              AssetImage("images/man.png") :
              NetworkImage(e.userImage),
            ),
            decoration: BoxDecoration(color: Color(0xfff2f2f2)),
            accountEmail: Text(e.userEmail, style: TextStyle(color: Colors.black),)
        );}).toList());
  }

  Widget _buildDrawer() {
    return Drawer(
        child: ListView(
            children: <Widget>[
              _buildUserAccountsDrawerHeader(),
              ListTile(
                selected: homeColor,
                onTap: (){
                  setState((){
                    homeColor=true;
                    contactUsColor=false;
                    cartColor=false;
                    aboutColor=false;
                    profileColor=false;
                  });

                },
                leading: Icon(Icons.home),
                title: Text("Kryefaqja"),
              ),
              ListTile(
                selected: cartColor,
                onTap: (){
                  setState((){
                    cartColor=true;
                    contactUsColor=false;
                    homeColor=false;
                    aboutColor=false;
                    profileColor=false;
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (ctx)=> CartScreen())
                  );},
                leading: Icon(Icons.shopping_cart),
                title: Text("Shporta"),
              ),
              ListTile(
                selected: contactUsColor,
                onTap: (){
                  setState((){
                    contactUsColor=true;
                    homeColor=false;
                    cartColor=false;
                    aboutColor=false;
                    profileColor=false;
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (ctx)=> ContactUs())
                  );
                  },
                leading: Icon(Icons.phone),
                title: Text("Na kontaktoni"),

              ),
              ListTile(
                selected: aboutColor,
                onTap: (){
                  setState((){
                    aboutColor=true;
                    contactUsColor=false;
                    cartColor=false;
                    homeColor=false;
                    profileColor=false;
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (ctx)=> About())
                  );
                  },
                leading: Icon(Icons.info),
                title: Text("Rreth nesh"),
              ),
              ListTile(
                selected: profileColor,
                onTap: (){
                  setState((){
                    aboutColor=false;
                    contactUsColor=false;
                    cartColor=false;
                    homeColor=false;
                    profileColor=true;
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (ctx)=> ProfileScreen())
                  );
                  },
                leading: Icon(Icons.account_circle),
                title: Text("Profili"),
              ),
              ListTile(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Shkyçu"),
              ),
            ]
        )
    );
  }

  Widget _buildImageSlider(){
    return Container(
        height: 240,
        child: Carousel(
            autoplay: true,
            showIndicator: false,
            images: [
              AssetImage("images/dress.jpg"),
              AssetImage("images/jeans.jpg"),
              AssetImage("images/watch.png"),
            ]
        )
    );
  }


  Widget _buildDressIcon() {
    List<CategoryIcon> dressIcon = categoryProvider.getDressIconList;
    List<Product> dress = categoryProvider.getDressList;
    return Row(
      children: dressIcon.map((e) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx)=>ListProduct(
                name: "Fustana",
                snapShot: dress,
              ),
              ),
            );
          },
          child: _buildCategoryProduct( e.image, 0xff33dcfd),
        );
      }).toList()

    );
  }

  Widget _buildShoesIcon() {
    List<CategoryIcon> shoesIcon = categoryProvider.getShoesIconList;
    List<Product> shoes = categoryProvider.getShoesList;
    return Row(
        children: shoesIcon.map((e) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>ListProduct(
                  name: "Këpucë",
                  snapShot: shoes,
                ),
                ),
              );
            },
            child: _buildCategoryProduct( e.image, 0xfff38cdd),
          );
        }).toList()

    );
  }

  Widget _buildShirtIcon() {
    List<CategoryIcon> shirtIcon = categoryProvider.getShirtIconList;
    List<Product> shirts = categoryProvider.getShirtList;

    return Row(
        children: shirtIcon.map((e) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>ListProduct(
                  name: "Bluza",
                  snapShot: shirts,
                ),
                ),
              );
            },
            child: _buildCategoryProduct( e.image, 0xff4ff2af),
          );
        }).toList()

    );
  }

  Widget _buildPantsIcon() {
    List<CategoryIcon> pantsIcon = categoryProvider.getPantsIconList;
    List<Product> pants = categoryProvider.getPantsList;

    return Row(
        children: pantsIcon.map((e) {
          return  GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>ListProduct(
                  name: "Pantallona",
                  snapShot: pants,
                ),
                ),
              );
            },
            child: _buildCategoryProduct( e.image, 0xff74acf7),
          );
        }).toList()

    );
  }

  Widget _buildHatsIcon() {
    List<CategoryIcon> hatsIcon = categoryProvider.getHatsIconList;
    List<Product> hats = categoryProvider.getHatsList;
    return Row(
        children: hatsIcon.map((e) {
          return  GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>ListProduct(
                  name: "Kapele",
                  snapShot: hats,
                ),
                ),
              );
            },
            child: _buildCategoryProduct( e.image, 0xfffc6c8d),
          );
        }).toList()

    );
  }

  Widget _buildCategory(){

    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Kategoritë", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            children: <Widget>[
              _buildDressIcon(),
              _buildShoesIcon(),
              _buildShirtIcon(),
              _buildPantsIcon(),
              _buildHatsIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatured() {
    List<Product> homeFeaturedProduct;
    List<Product> featuredProduct;
    homeFeaturedProduct= productProvider.getHomeFeaturedList;
    featuredProduct = productProvider.getFeaturedList;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Të përzgjedhurat", style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold),),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx)=>ListProduct
                  (name: "Të përzgjedhurat",
                    isCategory: false,
                    snapShot: featuredProduct,
                ),
                ),
                );
              },
              child: Text("Shiko më shumë", style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold)
              ),
            ),
          ],
        ),
        Row (children: homeFeaturedProduct.map((e) {
         return Expanded(
           child: Row  (
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx)=>DetailScreen(
                                image: e.image,
                                price: e.price,
                                name: e.name
                            )),
                          );
                        },
                        child: SingleProduct(
                            image: e.image,
                            price: e.price,
                            name: e.name
                        ),

                    ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx)=>DetailScreen(
                            image: e.image,
                            price: e.price,
                            name: e.name
                        )),
                      );
                    },
                    child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name
                    ),
                  ),
                )




              ]
              ),
         );
    }).toList()


        ),
      ]
    );
  }

  Widget _buildNewArrivals() {
    List<Product> newArrivals = productProvider.getNewArrivalsList;
    return Column(
    children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Ardhjet e reja", style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx)=>ListProduct
                        (name: "Ardhjet e reja",
                        isCategory: false,
                        snapShot: newArrivals,
                      ),
                      ),
                      );
                    },
                    child: Text("Shiko më shumë", style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: productProvider.getHomeArrivalsList.map((e){

            return Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
              Row(
              children: <Widget>[
              Expanded(
              child: Row(
              children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                    onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx)=>DetailScreen(
                        image: e.image,
                        price: e.price,
                        name: e.name
                    )),
                );
              },
              child: SingleProduct(
              image: e.image,
              price: e.price,
              name: e.name
              ),
              ),
                  ),
              Expanded(
              child: GestureDetector(
              onTap: (){
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx)=>DetailScreen(
              image: e.image,
              price: e.price,
              name: e.name
              )),
              );
              },
              child: SingleProduct(
              image: e.image,
              price: e.price,
              name: e.name
              ),
              ),
              ),
              ]
              ),
              )

           ]
              )
              ]
              ),
            );
    }).toList()
    ),
    ],
    );

  }

   bool homeColor=true;

   bool cartColor=false;

   bool aboutColor=false;

   bool contactUsColor=false;

   bool profileColor=false;


  final GlobalKey<ScaffoldState> _key=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider.getShirtData();
    categoryProvider.getDressData();
    categoryProvider.getShoesData();
    categoryProvider.getPantsData();
    categoryProvider.getHatsData();
    categoryProvider.getDressIcon();
    categoryProvider.getShoesIcon();
    categoryProvider.getShirtIcon();
    categoryProvider.getPantsIcon();
    categoryProvider.getHatsIcon();

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getFeaturedData();
    productProvider.getNewArrivalsData();
    productProvider.getHomeFeaturedData();
    productProvider.getHomeArrivalsData();
    productProvider.getUserData();

    return Scaffold(
      key: _key,
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text("Kryefaqja", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.black),
            onPressed: (){
          _key.currentState.openDrawer();

        }),
        actions: <Widget>[

          NotificationButton(),
        ],
      ),
      body: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildImageSlider(),
                              _buildCategory(),
                              SizedBox(
                                  height: 20
                              ),
                              _buildFeatured(),
                              _buildNewArrivals(),
                            ],
                          ),
                        )
                      ]
                     )
                    ),
                  );
  }
}
