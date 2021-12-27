import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/provider/category_provider.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailscreen.dart';
class SearchCategory extends SearchDelegate<void>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.close),
        onPressed: (){
        query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(icon: Icon(Icons.arrow_back),
        onPressed: (){
        close(context, null);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    CategoryProvider categoryProvider=Provider.of(context);
    List<Product> searchProduct= categoryProvider.searchCategoryList(query);
    return GridView.count(
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        // children: searchProduct.map((e)=>SingleProduct(
        //   image: e.image,
        //   name: e.name,
        //   price: e.price
        // )).toList()
        children: searchProduct
            .map((e) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => DetailScreen(
                  image: e.image,
                  name: e.name,
                  price: e.price,
                ),
              ),
            );
          },
          child: SingleProduct(
            image: e.image,
            name: e.name,
            price: e.price,
          ),
        ))
            .toList()
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    CategoryProvider categoryPprovider=Provider.of(context);
    List<Product> searchProduct= categoryPprovider.searchCategoryList(query);
     return GridView.count(
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        // children: searchProduct.map((e)=>SingleProduct(
        //     image: e.image,
        //     name: e.name,
        //     price: e.price
        // )).toList()
         children: searchProduct
             .map((e) => GestureDetector(
           onTap: () {
             Navigator.of(context).push(
               MaterialPageRoute(
                 builder: (ctx) => DetailScreen(
                   image: e.image,
                   name: e.name,
                   price: e.price,
                 ),
               ),
             );
           },
           child: SingleProduct(
             image: e.image,
             name: e.name,
             price: e.price,
           ),
         ))
             .toList()
    );
  }

}