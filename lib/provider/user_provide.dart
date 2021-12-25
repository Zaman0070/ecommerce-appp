import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';

class UserProvider with ChangeNotifier {

  void addUserData({
    User currentUser,
    String userName,
    String userEmail,
    String userUrl,
  }) async {
    await FirebaseFirestore.instance.collection('usersData')
        .doc(currentUser.uid)
        .set(
        {
          'userName': userName,
          'userEmail': userEmail,
          'userUrl': userUrl,
          'userUid': currentUser.uid,

        });
  }
  UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance.collection('usersData')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    if(value.exists){
      userModel= UserModel(
        userEmail: value.get('userEmail'),
        userName: value.get('userName'),
        userUrl: value.get('userUrl'),
        userUid: value.get('userUid'),
      );
      currentData = userModel;
      notifyListeners();

    }
  }

  UserModel get currentUserData{
    return currentData;
  }
}
