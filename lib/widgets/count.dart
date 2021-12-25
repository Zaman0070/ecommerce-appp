import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/provider/cart_provider.dart';

import 'package:provider/provider.dart';

class Count extends StatefulWidget {

  String productName;
  String productUrl;
  String productId;
  int productPrice;
  var productUnit;
  Count({this.productUnit,this.productName,this.productUrl,this.productId,this.productPrice});

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  getAddANdQuantity(){
    FirebaseFirestore.instance.collection('Cart')
        .doc(FirebaseAuth.instance.currentUser.uid)
  //////doc(FirebaseAuth.instance.currentUser.uid)  such method call it google service device
    .collection('YourCart').doc(widget.productId)
        .get().then((value) {
      if(this.mounted){
        if(value.exists){
          setState(() {
            count =value.get('cartQuantity');
            isTrue = value.get('isAdd');
          });
        }

      }
    } );
  }

  @override
  Widget build(BuildContext context) {
   getAddANdQuantity();
    CartProvider cartProvider = Provider.of(context);
    return Container(
         height: 35,
         width: 75,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(15),
           border: Border.all(color: Colors.grey),
         ),
         child:isTrue== true ? Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             InkWell(
               onTap: (){
                 if(count == 1 ){
                   setState(() {
                     isTrue= false;
                   });
                   cartProvider.reviewCartDataDelete(widget.productId);
                 }
                 else if(count > 1){
                   setState(() {
                     count --;
                   });
                   cartProvider.updateCartData(
                     cartId: widget.productId,
                     cartName: widget.productName,
                     cartUrl: widget.productUrl,
                     cartPrice: widget.productPrice,
                     cartQuantity: count,
                   );
                 }


               },
               child: Icon(
                 Icons.remove,
                 size: 15,
                 color: Color(0xffd1ad17),
               ),
             ),
             Text(
               '$count',
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 color: Color(0xffd1ad17),
               ),
             ),
             InkWell(
               onTap: (){
                 setState(() {
                   count ++;
                 });
                 cartProvider.updateCartData(
                   cartId: widget.productId,
                   cartName: widget.productName,
                   cartUrl: widget.productUrl,
                   cartPrice: widget.productPrice,
                   cartQuantity: count,
                 );
               },
               child: Icon(
                 Icons.add,
                 size: 15,
                 color: Color(0xffd1ad17),
               ),
             ),
           ],
         ):Center(
           child: InkWell(
             onTap: (){
               setState(() {
                 isTrue = true;
               });
               cartProvider.addCartData(
                 cartId: widget.productId,
                 cartName: widget.productName,
                 cartUrl: widget.productUrl,
                 cartPrice: widget.productPrice,
                 cartQuantity: count,
                 cartUnit: widget.productUnit,
               );

             },
             child: Text('ADD',
             style: TextStyle(
               color: primaryColor,
             ),
             ),
           ),
         ),
       );

  }
}
