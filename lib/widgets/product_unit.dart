import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  final Function onTap;
  final String title;
  ProductUnit({this.onTap,this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        height: 35,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$title',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200),
              ),
            ),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: Color(0xffd1ad17),
            )
          ],
        ),
      ),
    );
  }
}
