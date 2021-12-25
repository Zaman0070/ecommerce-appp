import 'package:flutter/material.dart';
class OrderItems extends StatelessWidget {
  bool isTrue;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network('http://assets.stickpng.com/thumbs/5a5f614bee40df432bfac539.png',
      width: 60,
      ),
      title: Row(
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        children: [
          Text(isTrue == false ?'food name':'cart name',
            style:TextStyle(
              color: Colors.grey[600],
            ),
            ),
          Text('50 Gram',
            style:TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text('\$30',
            ),
        ],
      ),
      subtitle: Text('5'),
    );
  }
}
