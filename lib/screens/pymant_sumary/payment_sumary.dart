import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';

import 'order_item.dart';



class PaymentSummary extends StatefulWidget {
  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}
enum addressType{
  Home,
  OnlinePayment,
}
class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = addressType.Home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        title: Text(
          'Payment Summary',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text('Total Amount',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
        ),
        subtitle: Text('\$300',style: TextStyle(
          color: Colors.green[900],
          fontSize: 17,
          fontWeight: FontWeight.w500
        ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: (){},
            child: Text('Place Order',style: TextStyle(color: textColor,fontSize: 16,fontWeight: FontWeight.w500),),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context,index){
          return Column(
            children: [
              ListTile(
                title: Text('First & LastName',style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: Text('area, Punjab/Pakistan, Gujranwala'),
              ),
              Divider(),
              ExpansionTile(
                children: [
                  OrderItems(),
                  OrderItems(),
                  OrderItems(),
                  OrderItems(),
                  OrderItems(),
                ],
                title: Center(
                  child: Text(
                    'Order Item 6',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  'Sub Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                trailing: Text(
                  '\$200',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  'Shipping Charge',
                  style: TextStyle(
                     color: Colors.grey[600],
                      fontSize: 16
                  ),
                ),
                trailing: Text(
                  '\$0',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  'Compen Discount',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16
                  ),
                ),
                trailing: Text(
                  '\$10',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Text('Payment Options'),
              ),
              RadioListTile(
                  title: Text('Home'),
                  secondary: Icon(Icons.home,color: primaryColor,),
                  value: addressType.Home,
                  groupValue: myType,
                  onChanged: (addressType value){
                    setState(() {
                      myType = value;
                    });
                  }
              ),
              RadioListTile(
                  title: Text('OnlinePayment'),
                  secondary: Icon(Icons.payment,color: primaryColor,),
                  value: addressType.OnlinePayment,
                  groupValue: myType,
                  onChanged: (addressType value){
                    setState(() {
                      myType = value;
                    });
                  }
              ),
            ],
          );
        })

        ),

    );
  }
}
