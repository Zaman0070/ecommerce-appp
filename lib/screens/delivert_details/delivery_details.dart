import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/deliver_address_model.dart';
import 'package:food_app/provider/check_out_provider.dart';
import 'package:food_app/screens/delivert_details/single_dilevery_items.dart';
import 'package:food_app/screens/pymant_sumary/payment_sumary.dart';
import 'package:provider/provider.dart';

import 'add_delivery_address.dart';


class DeliverDetails extends StatefulWidget {



  @override
  _DeliverDetailsState createState() => _DeliverDetailsState();
}

class _DeliverDetailsState extends State<DeliverDetails> {

  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliverAddressData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        title: Text(
          'Delivery Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => AddDeliverAddress()));
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          colorBrightness: Brightness.dark,
          color: primaryColor,
          child:deliveryAddressProvider.getDeliverAddressList.isEmpty ? Text(
            'Add new address',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ):Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            deliveryAddressProvider.getDeliverAddressList.isEmpty?  Navigator.push(context,
                MaterialPageRoute(builder: (_) => AddDeliverAddress()))
                : Navigator.push(context,
                MaterialPageRoute(builder: (_) => PaymentSummary()));
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Deliver To',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Image.asset(
              'assets/location.png',
              height: 30,
            ),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliverAddressList.isEmpty
              ? Container(
            child: Center(
              child: Text('No Data'),
            ),
          )
              :
          Column(
            children:deliveryAddressProvider.getDeliverAddressList.map((e) {
              return SingleDeliveryItem(
                address: 'area, ${e.area}, street${e.street}, pinCode${e.pinCode}',
                title: '${e.firstName} ${e.lastName}',
                number: e.mobileNo,
                addressType: e.addressType == 'AddressType.Other' ?'Other': e.addressType == 'AddressType.Home'?'Home':'Work',
              );
            }).toList(),
            // children: [
            //   deliveryAddressProvider.getDeliverAddressList.isEmpty
            //       ? Container(
            //     child: Center(
            //       child: Text('No Data'),
            //     ),
            //   )
            //       : SingleDeliveryItem(
            //     address: 'area, Punjab/Pakistan, Gujranwala',
            //     title: 'Developer',
            //     number: '+923044410007',
            //     addressType: 'Home',
            //   ),
            //
            // ],
          ),
        ],
      ),
    );
  }
}
