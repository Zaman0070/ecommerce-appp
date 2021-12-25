import 'package:flutter/material.dart';
import 'package:food_app/provider/user_provide.dart';
import 'package:food_app/screens/cart/cart.dart';
import 'package:food_app/screens/profile/profile.dart';
import 'package:food_app/screens/wish_list/wish_list.dart';

class DrawerSide extends StatefulWidget {
  UserProvider userProvider;
  DrawerSide({this.userProvider});

  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({IconData icon, String title,Function onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData =widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: Color(0xffd1ad17),
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(

                      radius: 43,
                      backgroundColor: Colors.white70,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            userData.userUrl ??
                            'https://s3.envato.com/files/328957910/vegi_thumb.png'),
                        radius: 40,
                        backgroundColor: Color(0xffd4d181),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userData.userName),
                        Text(userData.userEmail),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            listTile(icon: Icons.home_outlined, title: 'Home',),
            listTile(icon: Icons.shop_outlined, title: 'Review Cart',
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Cart()));
                }
            ),

            listTile(
                icon: Icons.person_outlined,
                title: 'My Profile',
                onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen(userProvider:widget.userProvider)));
                }
            ),
            listTile(icon: Icons.notification_add_outlined, title: 'Notification',),
            listTile(icon: Icons.star_outlined, title: 'Rating & Review',),
            listTile(icon: Icons.favorite_outline,
              title: 'Wishlist',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>WishList()));
            }
            ),
            listTile(icon: Icons.copy_outlined, title: 'Raise Complaint ',),
            listTile(icon: Icons.format_quote_outlined, title: 'FAQs',),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Support',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Call us :',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      SizedBox(width: 15,),
                      Text('+923044410007',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Mail us :',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      SizedBox(width: 15,),
                      Text('helo@retry.com',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
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
