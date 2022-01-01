import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/check_out_provider.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/user_provide.dart';
import 'package:food_app/provider/wish_list_provider.dart';
import 'package:food_app/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

import 'auth/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckOutProvider>(
          create: (context) => CheckOutProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffcbcbcb),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return HomeScreen();
            }
            return SignIn();
          },
        ),
      ),
    );
  }
}
