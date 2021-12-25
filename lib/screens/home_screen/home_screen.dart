import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/user_provide.dart';
import 'package:food_app/screens/cart/cart.dart';
import 'package:food_app/screens/home_screen/single_product.dart';
import 'package:food_app/screens/product_overview/product_over_view.dart';
import 'package:food_app/screens/search/search.dart';

import 'package:provider/provider.dart';

import 'drawer_side.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
   ProductProvider productProvider;

  Widget _buildHerbsProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Herbs Seasonings',
                style: TextStyle(
                    fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen(
                    search: productProvider.getHerbsProductDataList,
                  )));
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getHerbsProductDataList.map((herbsProductData) {
              return  SingleProduct(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductOverview(
                    productPrice: herbsProductData.productPrice,
                    productName:herbsProductData.productName,
                    productUrl: herbsProductData.productUrl,
                    productId: herbsProductData.productId,


                  )));
                },
                productUrl:herbsProductData.productUrl,
                productName:herbsProductData.productName,
                productPrice: herbsProductData.productPrice,
                productId: herbsProductData.productId,
                productUnit: herbsProductData,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFreshProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fresh Fruits',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen(
                    search: productProvider.getFreshProductDataList,
                  )));
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getFreshProductDataList.map((freshProductData){

              return  SingleProduct(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductOverview(
                    productPrice: freshProductData.productPrice,
                    productName:freshProductData.productName,
                    productUrl: freshProductData.productUrl,
                    productId: freshProductData.productId,

                  )));
                },
                productId: freshProductData.productId,
                productUrl: freshProductData.productUrl,
                productName: freshProductData.productName,
                productPrice: freshProductData.productPrice,
                productUnit: freshProductData,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  Widget _buildRootProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Root vegetables',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen(
                    search: productProvider.getRootProductDataList,
                  )));
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getRootProductDataList.map((rootProductData){

              return  SingleProduct(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductOverview(
                    productPrice: rootProductData.productPrice,
                    productName:rootProductData.productName,
                    productUrl: rootProductData.productUrl,
                    productId: rootProductData.productId,

                  )));
                },
                productId: rootProductData.productId,
                productUrl: rootProductData.productUrl,
                productName: rootProductData.productName,
                productPrice: rootProductData.productPrice,
                productUnit: rootProductData,
              );
            }).toList(),

          ),
        ),
      ],
    );
  }

 @override
  void initState() {
    ProductProvider initProductProvider =  Provider.of(context,listen: false );
    initProductProvider.fetchHerbsProductData();
    initProductProvider.fetchFreshProductData();
    initProductProvider.fetchRootProductData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =Provider.of(context);
    userProvider.getUserData();
    productProvider =Provider.of(context);
    return Scaffold(
      drawer: DrawerSide(userProvider : userProvider),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd1ad17),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xffd4d181),
            child: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen(
                  search: productProvider.getAllProductSearch,
                )));
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: ( ){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Cart()));
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xffd4d181),
                child: Icon(
                  Icons.shop,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn.nohat.cc/thumb/f/720/4997877097037824.jpg'),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.red,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 145, bottom: 10),
                            child: Container(
                              height: 60,
                              width: 85,
                              decoration: BoxDecoration(
                                  color: Color(0xffd1ad17),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(75),
                                    bottomLeft: Radius.circular(75),
                                    topLeft: Radius.circular(18),
                                  )),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 17.0, top: 14),
                                    child: Text(
                                      'Vegi',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        //color: Colors.white,
                                        //letterSpacing: 2,
                                        fontWeight: FontWeight.w900,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 2.5
                                          ..color = Colors.green.shade900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '30% Off',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              //color: Colors.white,
                              //letterSpacing: 2,
                              fontWeight: FontWeight.w900,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.white,
                              shadows: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 80,
                                  offset: Offset(0, 0),
                                  spreadRadius: 50,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Text(
                              'On all vegetable products',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            _buildHerbsProduct(context),
            _buildFreshProduct(),
            _buildRootProduct(),


          ],
        ),
      ),
    );
  }
}
