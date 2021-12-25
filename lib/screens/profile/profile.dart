import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/provider/user_provide.dart';
import 'package:food_app/screens/home_screen/drawer_side.dart';


class ProfileScreen extends StatefulWidget {
  UserProvider userProvider;
  ProfileScreen({this.userProvider});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget listTile({IconData icon,String title}){
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title,style: TextStyle(fontWeight: FontWeight.w500),),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData =widget.userProvider.currentUserData;
    return Scaffold(
     // backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        title: Text('My Profile',
        style: TextStyle(
          color: Colors.black
        ),
        ),
      ),
      drawer: DrawerSide(userProvider: widget.userProvider,),
      body: Stack(
        children: [
              ClipPath(
                clipper: MultipleRoundedCurveClipper(),
                child: Container(
                  width: double.infinity,
                  height: 150,//MediaQuery.of(context).size.height/2.5,
                  color: primaryColor,

                ),

              ),
             Container(
               child: Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 54.0,vertical: 90),
                 child: CircleAvatar(
                   radius: 55,
                   backgroundColor: primaryColor,
                   child: CircleAvatar(
                     radius: 50,
                     backgroundImage: NetworkImage(
                    userData.userUrl??     'https://s3.envato.com/files/328957910/vegi_thumb.png'),
                   ),
                 ),
               ),
             ),
           Column(
              children: [
                SizedBox(height: 180,),
                Padding(
                  padding:  EdgeInsets.only(left: 130.0),
                  child: Container(
                    height: 100,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userData.userName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              ),
                              SizedBox(height: 10,),
                              Text(userData.userEmail,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: primaryColor,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white70,
                              child: Icon(Icons.edit,
                              size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
                listTile(
                  icon: Icons.shop_outlined,
                  title: 'My Order',
                ),
                listTile(
                  icon: Icons.location_on_outlined,
                  title: 'My Delivery Address',
                ),
                listTile(
                  icon: Icons.person_outlined,
                  title: 'Refer A Friends',
                ),
                listTile(
                  icon: Icons.file_copy_outlined,
                  title: 'Term & Condition',
                ),
                listTile(
                  icon: Icons.policy_outlined,
                  title: 'Privacy Policy',
                ),
                listTile(
                  icon: Icons.add_chart,
                  title: 'About',
                ),
                listTile(
                  icon: Icons.exit_to_app_outlined,
                  title: 'LOG OUT',
                ),


              ],
            ),


        ],
      ),
    );
  }
}
