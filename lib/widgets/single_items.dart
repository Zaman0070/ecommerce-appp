import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import 'count.dart';

class SingleItems extends StatefulWidget {
  bool isBool = false;
  String productName;
  String productUrl;
  int productPrice;
  String productId;
  int productQuantity;
  Function onDelete;
  bool wishList = false;
  var productUnit;
  SingleItems(
      {this.productId,
      this.productQuantity,
      this.isBool,
      this.productName,
      this.productUrl,
      this.productPrice,
      this.onDelete,
      this.wishList,
        this.productUnit
      });

  @override
  _SingleItemsState createState() => _SingleItemsState();
}

class _SingleItemsState extends State<SingleItems> {
  int count;

  getCount(){
  setState(() {
    count = widget.productQuantity;
  });
  }

  CartProvider cartProvider;
// @override
//   void initState() {
//   getCount();
//     // TODO: implement initState
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
  getCount();
    cartProvider =Provider.of<CartProvider>(context);
    cartProvider.getReviewCartDta();
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 50,
              child: Center(
                child: Image.network(widget.productUrl),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 80,
              width: 100,
              child: Column(
                mainAxisAlignment: widget.isBool == false
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${widget.productPrice}\$',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  widget.isBool == false
                      ? GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title:  Text('50 Gram'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title:  Text('500 Gram'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(

                                  title:  Text('1 KG'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                        child: Container(
                            margin: EdgeInsets.only(right: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            // height: 35,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              children: [
                                Text(
                                 '50 Gram',
                                  style: TextStyle(
                                      fontSize: 10, fontWeight: FontWeight.w300),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                      )
                      : Text(widget.productUnit),
                ],
              ),
            ),
            SizedBox(
              width: 80,
            ),
            Container(
              //height: 60,
              width: 90,
              padding: widget.isBool == false
                  ? EdgeInsets.symmetric(horizontal: 10, vertical: 25)
                  : EdgeInsets.only(left: 15, right: 15),
              child: widget.isBool == false
                  ? Count(
                      productId: widget.productId,
                      productName: widget.productName,
                      productUrl: widget.productUrl,
                      productPrice: widget.productPrice,
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: widget.onDelete,
                              child: Icon(
                                Icons.delete,
                                color: Colors.black45,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          widget.wishList == false
                              ? Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.grey)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          if(count == 1){
                                            Fluttertoast.showToast(msg: 'you reach minimum limits');
                                          }else{
                                            setState(() {
                                              count--;
                                            });
                                            cartProvider.updateCartData(
                                              cartName: widget.productName,
                                              cartUrl: widget.productUrl,
                                              cartPrice: widget.productPrice,
                                              cartId: widget.productId,
                                              cartQuantity: count,
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        '$count',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          if(count<10){
                                            setState(() {
                                              count++;
                                            });
                                            cartProvider.updateCartData(
                                              cartName: widget.productName,
                                              cartUrl: widget.productUrl,
                                              cartPrice: widget.productPrice,
                                              cartId: widget.productId,
                                              cartQuantity: count,
                                            );
                                          }
                                          
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              ),
      ],
    );
  }
}
