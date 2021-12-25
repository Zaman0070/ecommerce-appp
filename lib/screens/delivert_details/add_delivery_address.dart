import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/provider/check_out_provider.dart';
import 'package:food_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import 'google_map.dart';

class AddDeliverAddress extends StatefulWidget {


  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum addressType{
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = addressType.Home;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        title: Text('Add Delivery Address',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        height: 50,
        child:  checkOutProvider.isLoading == false? MaterialButton(
          colorBrightness: Brightness.dark,
          color: primaryColor,
          child:

          Text('Add  address',style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          ),
          //       :Center(
          //   child: CircularProgressIndicator(),
          // ),
          onPressed: (){
            checkOutProvider.validator(context,myType);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
        ) :Center(
          child: CircularProgressIndicator(),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomTextField(
              labText: 'First Name',
              keyboard:TextInputType.text ,
              controller: checkOutProvider.firstName,
            ),
            CustomTextField(
              labText: 'Last Name',
              keyboard:TextInputType.text ,
              controller: checkOutProvider.lastName,
            ),
            CustomTextField(
              labText: 'Mobile No',
              keyboard:TextInputType.phone ,
              controller: checkOutProvider.mobileNo,
            ),
            CustomTextField(
              labText: 'Society ',
              keyboard:TextInputType.text ,
              controller: checkOutProvider.society,
            ),
            CustomTextField(
              labText: 'Street',
              keyboard:TextInputType.text ,
              controller: checkOutProvider.street,
            ),
            CustomTextField(
              labText: 'Landmark',
              keyboard:TextInputType.text ,
              controller: checkOutProvider.landmark,
            ),
            CustomTextField(
              labText: 'City',
              keyboard:TextInputType.text ,
              controller: checkOutProvider.city,
            ),
            CustomTextField(
              labText: 'Area',
              keyboard:TextInputType.text ,
              controller: checkOutProvider.area,
            ),
            CustomTextField(
              labText: 'Pincode',
              keyboard:TextInputType.number ,
              controller: checkOutProvider.pincode ,
            ),
            InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomGoogleMap()));
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkOutProvider.setLocation == null?
                    // checkOutProvider.setLocation == null ?
                    Center(
                      child: Text('Set Location',
                  style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),),
                    )
                        : Center(
                          child: Text('Done!',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                      ),
                    ),
                        ),


                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text('Address Type*'),
            ),
            RadioListTile(
                title: Text('Home'),
                secondary: Icon(Icons.home,color: primaryColor,),
                value: addressType.Home,
                groupValue:myType,
                onChanged: (addressType value){
                  setState(() {
                    myType = value;
                  });
                }
            ),
            RadioListTile(
                title: Text('Work'),
                secondary: Icon(Icons.work,color: primaryColor,),
                value: addressType.Work,
                groupValue:myType,
                onChanged: (addressType value){
                  setState(() {
                    myType = value;
                  });
                }
            ),

            RadioListTile(
                title: Text('Others'),
                secondary: Icon(Icons.devices_other_sharp,color: primaryColor,),
                value: addressType.Other,
                groupValue:myType,
                onChanged: (addressType value){
                  setState(() {
                    myType = value;
                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}
