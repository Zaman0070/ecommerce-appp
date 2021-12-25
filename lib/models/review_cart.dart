class ReviewCartModel{
  String cartId;
  String cartName;
  String cartUrl;
  int cartPrice;
  int cartQuantity;
  var cartUnit;

  ReviewCartModel({this.cartUnit,this.cartId,this.cartName,this.cartUrl,this.cartPrice,this.cartQuantity});
}