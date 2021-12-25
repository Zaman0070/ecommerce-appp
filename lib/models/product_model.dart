class ProductModel{
  String productName;
  String productUrl;
  int productPrice;
  String productId;
  int productQuantity;
  List<dynamic>productUnit;

  ProductModel({this.productUnit,this.productQuantity,this.productId,this.productName,this.productUrl,this.productPrice});
}