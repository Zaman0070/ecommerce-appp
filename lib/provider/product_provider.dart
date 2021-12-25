import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';


class ProductProvider with ChangeNotifier{

  ProductModel productModel;

  List<ProductModel>search=[];

  productModels(QueryDocumentSnapshot element){
    productModel = ProductModel(
      productUrl: element.get('productUrl'),
      productName: element.get('productName'),
      productPrice: element.get('productPrice'),
      productId: element.get('productId'),
      productUnit: element.get('productUnit'),
    );
    search.add(productModel);
  }


  ///////////////herbsProduct///////////////////////
  List<ProductModel> herbsProductList =[];



  fetchHerbsProductData() async{

    List<ProductModel> newList =[];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("HerbProduct").get();
    snapshot.docs.forEach((element) {
      productModels(element);
      newList.add(productModel);
    }
    );
    herbsProductList = newList;
    notifyListeners();
  }


  List<ProductModel> get getHerbsProductDataList{
    return herbsProductList;
  }


  //////////////fresh product///////////////////////

  List<ProductModel> freshProductList =[];



  fetchFreshProductData() async{

    List<ProductModel> newList =[];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("FreshProduct").get();
    snapshot.docs.forEach((element) {
      productModels(element);
      newList.add(productModel);
    }
    );
    freshProductList = newList;
    notifyListeners();
  }


  List<ProductModel> get getFreshProductDataList{
    return freshProductList;
  }

  ////////////////Root Product///////////////////////


  List<ProductModel> rootProductList = [];

  fetchRootProductData() async{
    List<ProductModel> newList =[];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('RootProduct').get();
    snapshot.docs.forEach((element) {
      productModels(element);
      newList.add(productModel);
    });
    rootProductList = newList;
    notifyListeners();

  }
  List<ProductModel> get getRootProductDataList{
    return rootProductList;
  }


  /////////////search return////////////////////

  List<ProductModel> get getAllProductSearch{
    return search;
  }
}