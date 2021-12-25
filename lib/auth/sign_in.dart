import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food_app/provider/user_provide.dart';
import 'package:food_app/screens/home_screen/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  UserProvider userProvider;

  Future<void> _googleSignUP() async{
    try{
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(

        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final User user =(await _auth.signInWithCredential(authCredential)).user;
      // print("Sign in" +user.displayName);
      userProvider.addUserData(
        currentUser: user,
        userEmail: user.email,
        userName: user.displayName,
        userUrl: user.photoURL,
      );

      return user;
    }catch(e){
      print(e.message);
    }
  }


  @override
  Widget build(BuildContext context) {
   userProvider  =Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background.png'),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Sign in to Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                  Text('Vegi',
                  style: TextStyle(
                    fontSize: 60,
                    //color: Colors.white,
                    //letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                    foreground: Paint(

                    ) ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Colors.green.shade900,
                    shadows: [
                      BoxShadow(
                        color: Colors.green.shade900,
                        blurRadius: 80,
                        offset: Offset(0,0),
                        spreadRadius: 50,
                      ),
                    ],
                  ),
                  ),
                  Column(
                    children: [
                      SignInButton(

                        Buttons.Apple,
                        text: "Sign in with Apple",
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () async {
                         await _googleSignUP().then((value) =>
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_)=>HomeScreen())),
                          );
                        },
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Text('By signing in you are agreeing to our',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Term and Private Policy',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
