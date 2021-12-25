import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/widgets/single_items.dart';

enum SignInCharacter { lowToHeight, highToLow, alphabetically }

class SearchScreen extends StatefulWidget {
  final List<ProductModel> search;
  SearchScreen({this.search});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
////////////////////List search////////////////////////

  String query='';

  searchItem(String query){

    List<ProductModel>searchFood =widget.search.where((element){
      return element.productName.toLowerCase().contains(query);
    } ).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel>_searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        title: Text(
          'Search',
          style: TextStyle(
            color: textColor,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
            },
              icon: Icon(Icons.sort),)
          ),
        ],
      ),
      body: ListView (
        children :[
            ListTile(
              title: Text(
                'Items',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 55.0,
              margin: EdgeInsets.symmetric(horizontal: 22),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color(0xffc2c2c2),
                  filled: true,
                  hintText: '  Search Items',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children:_searchItem.map((e) {
                return  SingleItems(
                  isBool: false,
                  productName: e.productName,
                  productPrice: e.productPrice,
                  productUrl: e.productUrl,
                );

              }).toList()
            ),




        ]
      ),
    );
  }
}
