import 'package:flutter/material.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/widgets/count.dart';
import 'package:food_app/widgets/product_unit.dart';

class SingleProduct extends StatefulWidget {
  final String productUrl;
  final String productName;
  final int productPrice;
  final Function onTap;
  final String productId;
  final ProductModel productUnit;

  SingleProduct({this.productUnit,this.productUrl,this.productName,this.onTap,this.productPrice,this.productId});

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;

      });
      return true;
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
      Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 250.0,
      width: 170.0,
      decoration: BoxDecoration(
        color: Color(0xffd9dad9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap:widget.onTap,
            child: Container(
              height: 150,
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Image.network(
                widget.productUrl,
              ),
            ),
          ),
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productName,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    '${widget.productPrice}\$/${unitData == null
                        ? firstValue
                        :unitData}',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductUnit(
                        onTap: (){

                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children:widget.productUnit.productUnit.map<Widget>((data){
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                          child: InkWell(
                                            onTap: ()async {
                                              setState(() {
                                                unitData = data;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(data,
                                            style: TextStyle(
                                            fontSize: 18,
                                            ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),

                                );
                              });

                        },
                        title:unitData == null
                            ? firstValue
                            :unitData,

                      ),
                      SizedBox(
                        width: 5,
                      ),
                     Count(
                       productId: widget.productId,
                       productName: widget.productName,
                       productUrl: widget.productUrl,
                       productPrice: widget.productPrice,
                       productUnit: unitData == null
                           ? firstValue
                           :unitData,
                     ),
                    ],
                  ),
                ],
              ),

        ],
      ),
    ),
        ],
      ),
    );
  }
}
