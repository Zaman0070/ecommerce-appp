import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController  controller;
  final String labText;
  final TextInputType keyboard;
  CustomTextField({this.controller,this.labText,this.keyboard});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboard,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}
