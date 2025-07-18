import 'package:flutter/material.dart';
class TextFieldLabel extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
   final String  labelText;

  const TextFieldLabel({super.key,required this.controller,required this.readOnly,required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      decoration: InputDecoration(labelText: labelText,labelStyle: TextStyle(color: Colors.white,fontSize: 20),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 3)),focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF48A6A7),width: 4))),
    );
  }
}
