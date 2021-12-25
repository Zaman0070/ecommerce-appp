import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';


class WishListProvider with ChangeNotifier{

  void addWishListData({
    String wishListId,
    String wishListName,
    String wishListUrl,
    int wishListPrice,
    int wishListQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourWishList')
        .doc(wishListId)
        .set({
      'wishListId': wishListId,
      'wishListName': wishListName,
      'wishListUrl': wishListUrl,
      'wishListPrice': wishListPrice,
      'wishListQuantity': wishListQuantity,
      'wishList':true,
    });
  }



  /////////////Get Wish List Data///////////////////

  List<ProductModel> wishList = [];

  getWishListData() async{

    List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourWishList')
        .get();
    value.docs.forEach((element) {
      ProductModel productModel = ProductModel(
        productId: element.get('wishListId'),
        productName: element.get('wishListName'),
        productUrl: element.get('wishListUrl'),
        productPrice: element.get('wishListPrice'),
        productQuantity: element.get('wishListQuantity'),

      );
      newList.add(productModel);
    });
    wishList = newList;
    notifyListeners();

  }
  List<ProductModel> get getWishList{
    return wishList;
  }
////////////// Delete WishList/////////////////

  deleteWishList(wishListId){
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourWishList').doc(wishListId).delete();
  }

}