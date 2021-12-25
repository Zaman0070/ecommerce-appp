import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/review_cart.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/screens/delivert_details/delivery_details.dart';
import 'package:food_app/widgets/single_items.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
   CartProvider cartProvider;


  showAlertDialog(BuildContext context,ReviewCartModel delete) {

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
        cartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
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
   cartProvider =Provider.of(context);
    cartProvider.getReviewCartDta();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text('Total Amount'),
        subtitle: Text('\$ ${cartProvider.getTotalPrice()}',
          style: TextStyle(
            color: Colors.green[900],
        ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
              child: Text('Submit',
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.2,
              ),
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          color: primaryColor,
          onPressed: (){
                if(cartProvider.getReviewCartDataList.isEmpty){
                  return Fluttertoast.showToast(msg: 'No cart data found');
                }
                Navigator.push(context, MaterialPageRoute(builder: (_)=>DeliverDetails()));
          },
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        title: Text('Review Cart',
          style: TextStyle(color:textColor,
          ),
        ),
      ),
      body: cartProvider.getReviewCartDataList.isEmpty ? Center(
        child: Text('No Data'),
      )
          :
      ListView.builder(
        itemCount: cartProvider.getReviewCartDataList.length,
        itemBuilder: (context,index){
          ReviewCartModel data = cartProvider.getReviewCartDataList[index];
          return Column(
            children: [
              SizedBox(height: 20,),
              SingleItems(
                isBool: true,
                wishList: false,
                productName: data.cartName,
                productUrl: data.cartUrl,
                productPrice: data.cartPrice,
                productId: data.cartId,
                productQuantity: data.cartQuantity,
                productUnit: data.cartUnit,
                onDelete: (){
                  showAlertDialog(context,data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
