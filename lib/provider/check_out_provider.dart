import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/models/deliver_address_model.dart';
import 'package:food_app/screens/delivert_details/add_delivery_address.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier{

  bool isLoading = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  LocationData setLocation;

  void validator(context, addressType myType)async{
    if(firstName.text.isEmpty){
      Fluttertoast.showToast(msg: 'firstname is empty');
    }
    else  if(lastName.text.isEmpty){
      Fluttertoast.showToast(msg: 'lastname is empty');
    }
    else  if(mobileNo.text.isEmpty){
      Fluttertoast.showToast(msg: 'mobileno is empty');
    }
    else  if(society.text.isEmpty){
      Fluttertoast.showToast(msg: 'society is empty');
    }
    else  if(street.text.isEmpty){
      Fluttertoast.showToast(msg: 'street is empty');
    }
    else  if(landmark.text.isEmpty){
      Fluttertoast.showToast(msg: 'landmark is empty');
    }
    else  if(city.text.isEmpty){
      Fluttertoast.showToast(msg: 'city is empty');
    }
    else  if(area.text.isEmpty){
      Fluttertoast.showToast(msg: 'area is empty');
    }
    else  if(pincode.text.isEmpty){
      Fluttertoast.showToast(msg: 'pincode is empty');
    }
    else  if(setLocation == null){
      Fluttertoast.showToast(msg: 'setLocation is empty');
    }
    else{
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance.collection('AddDeliveryAddress')
    .doc(FirebaseAuth.instance.currentUser.uid).set({
        'firstName':firstName.text,
        'lastName':lastName.text,
        'mobileNo':mobileNo.text,
        'society':society.text,
        'street':street.text,
        'landmark':landmark.text,
        'city':city.text,
        'area':area.text,
        'pincode':pincode.text,
        'addressType':myType.toString(),
        'latitude':setLocation.latitude,
        'longitude':setLocation.longitude
        //'setLocation':setLocation.text,
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: 'add your deliver address');
         Navigator.of(context).pop();
         notifyListeners();
      });
      notifyListeners();
    }


  }

  List<DeliverAddressModel> deliveryAddressList = [];

   getDeliverAddressData()async{

     List<DeliverAddressModel> nerList = [];
    DeliverAddressModel deliverAddressModel ;
    DocumentSnapshot _db = await FirebaseFirestore.instance.collection('AddDeliveryAddress')
        .doc(FirebaseAuth.instance.currentUser.uid).get();
    if(_db.exists){
      deliverAddressModel = DeliverAddressModel(
        firstName: _db.get('firstName'),
        lastName: _db.get('lastName'),
        mobileNo: _db.get('mobileNo'),
        society: _db.get('society'),
        street: _db.get('street'),
        landmark: _db.get('landmark'),
        city: _db.get('city'),
        area: _db.get('area'),
        pinCode: _db.get('pincode'),
        addressType: _db.get('addressType'),
      );
      nerList.add(deliverAddressModel);
      notifyListeners();
    }

    deliveryAddressList = nerList;
    notifyListeners();
  }

  List<DeliverAddressModel> get getDeliverAddressList{
     return deliveryAddressList;
}




}