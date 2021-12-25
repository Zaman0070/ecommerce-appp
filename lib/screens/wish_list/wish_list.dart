import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/provider/wish_list_provider.dart';
import 'package:food_app/widgets/single_items.dart';

import 'package:provider/provider.dart';

class WishList extends StatefulWidget {

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  WishListProvider wishListProvider;
  showAlertDialog(BuildContext context,ProductModel delete) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        wishListProvider.deleteWishList(delete.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WishList Product"),
      content: Text("Are your sure delete this?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishListData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        title: Text('Wish List',
          style: TextStyle(color:textColor,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: wishListProvider.getWishList.length,
        itemBuilder: (context,index){
          ProductModel data = wishListProvider.getWishList[index];
          return Column(
            children: [
              SizedBox(height: 20,),
              SingleItems(
                isBool: true,
                productName: data.productName,
                productUrl: data.productUrl,
                productPrice: data.productPrice,
                productId: data.productId,
                productQuantity: data.productQuantity,
                onDelete: (){
                  showAlertDialog(context, data);

                },
              ),
            ],
          );
        },
      ),
    );
  }
}
