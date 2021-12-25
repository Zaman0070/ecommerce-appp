import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/review_cart.dart';


class CartProvider with ChangeNotifier {
  void addCartData({
    String cartId,
    String cartName,
    String cartUrl,
    int cartPrice,
    int cartQuantity,
    var cartUnit,
  }) async {
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourCart')
        .doc(cartId)
        .set({
      'cartId': cartId,
      'cartName': cartName,
      'cartUrl': cartUrl,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'isAdd':true,
      'cartUnit': cartUnit,
    });
  }




  void updateCartData({
    String cartId,
    String cartName,
    String cartUrl,
    int cartPrice,
    int cartQuantity,

  }) async {
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourCart')
        .doc(cartId)
        .update({
      'cartId': cartId,
      'cartName': cartName,
      'cartUrl': cartUrl,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'isAdd':true,

    });
  }





  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartDta() async{
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue= await FirebaseFirestore.instance.collection('Cart')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourCart').get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get('cartId'),
        cartName: element.get('cartName'),
        cartUrl: element.get('cartUrl'),
        cartQuantity: element.get('cartQuantity'),
        cartPrice: element.get('cartPrice'),
        cartUnit: element.get('cartUnit'),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList =newList;
    notifyListeners();
  }

  List<ReviewCartModel> get  getReviewCartDataList {
    return  reviewCartDataList;
  }
//////////// Total Price//////////////////////


  getTotalPrice(){
    double total =0.0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice *element.cartQuantity;
    });
    return total;
  }

  //////////////////// \review cart del ///////////////////

  reviewCartDataDelete(cartId){
    FirebaseFirestore.instance.collection('Cart')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourCart').doc(cartId).delete();
    notifyListeners();
  }
}
