import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/provider/wish_list_provider.dart';
import 'package:food_app/screens/cart/cart.dart';
import 'package:food_app/widgets/count.dart';
import 'package:provider/provider.dart';

enum SignInCharacter {fill, outline}


class ProductOverview extends StatefulWidget {

  final String productName;
  final String productUrl;
  final int productPrice;
  final String productId;


  ProductOverview({this.productId,this.productName,this.productUrl,this.productPrice});



  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {

  SignInCharacter _character = SignInCharacter.fill;


  Widget bottomNavigationBar(
    Color iconColor,
    Color backgroundColor,
    Color color,
    String title,
    IconData iconData,
    Function onTap,
  )
  {
    return Expanded(child: Container(
      padding: EdgeInsets.all(20),
      color: backgroundColor,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData,
            size: 20,
              color: iconColor,
            ),
            SizedBox(width: 10,),
            Text(title,
            style: TextStyle(
              color: color,
            ),
            ),
          ],
        ),
      ),
    ),
    );

  }

  bool wishListBool= false;

  getWishListBoll(){
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourWishList').doc(widget.productId)
        .get()
         .then((value)=> {
           if(this.mounted){
             if(value.exists){
               setState(() {
                 wishListBool = value.get('wishList');
               })
             }
           }

    });

  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider =Provider.of(context);
    getWishListBoll();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bottomNavigationBar(
              Colors.grey,
              textColor,
              Colors.white70,
              'Add to WishList',
              wishListBool== false?  Icons.favorite_outline: Icons.favorite,
              (){
                setState(() {
                  wishListBool =! wishListBool;
                });
                if(wishListBool == true){
                  wishListProvider.addWishListData(
                    wishListId: widget.productId,
                    wishListName: widget.productName,
                    wishListUrl: widget.productUrl,
                    wishListPrice: widget.productPrice,
                    wishListQuantity: 2,
                  );

                }else{
                  wishListProvider.deleteWishList(widget.productId);
                }
              }
          ),
          bottomNavigationBar(
            Colors.black,
            primaryColor,
            Colors.black,
            'Go to Cart',
           Icons.shop_outlined ,
              (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Cart()));

              }
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: textColor,
        ),
        title: Text('Product Overview',
        style: TextStyle(color: textColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                   ListTile(
                     title:  Text(widget.productName,
                     style: TextStyle(
                       fontWeight: FontWeight.w600,
                       fontSize: 20,
                     ),
                     ),
                     subtitle:  Text('\$50',
                       style: TextStyle(
                         fontWeight: FontWeight.w300,
                         fontSize: 16,
                       ),
                     ),
                   ),
                    Container(
                      padding: EdgeInsets.all(40),
                      height: 250,
                      child: Image(
                        image: NetworkImage(widget.productUrl??"",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Text('Available Option',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.green[700],
                              ),

                          Radio(
                              value: SignInCharacter.fill,
                              groupValue: _character,
                              activeColor: Colors.green[700],
                              onChanged: (value){
                                setState(() {
                                  _character = value;
                                });
                              },
                          ),
                            ],
                          ),
                          Text('\$${widget.productPrice}',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                          ),
                          Count(
                            productId: widget.productId,
                            productName: widget.productName,
                            productUrl: widget.productUrl,
                            productPrice: widget.productPrice,
                            productUnit: '500 Gram',
                          ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(30),
                          //     border: Border.all(
                          //       color: Colors.grey,
                          //     )
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Icon(Icons.add,size: 19,color: primaryColor),
                          //       SizedBox(width: 5,),
                          //       Text('ADD'),
                          //
                          //
                          //
                          //     ],
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('About This Product',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('Basil is an annual, or sometimes perennial,'
                              ' herb used for its leaves.'
                              ' Depending on the variety, plants can reach heights of between 30 and 150 cm (1 and 5 ft).'
                              ' Its leaves are richly green and ovate, but otherwise come in a wide variety of sizes and shapes depending on cultivar. '
                              'Leaf sizes range from 3 to 11 cm (1 to 4+1⁄2 in) long, and between 1 and 6 cm (1⁄2 and 2+1⁄2 in) wide. '
                              'Basil grows a thick, central taproot.',
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
              ),

          ),
        ],
      ),
    );
  }
}
