import 'package:flutter/material.dart';

class TextFeild extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  String hintText;
  final IconData? icon ;
  Color  borderColor;
  Color fillColor;
  // Color hintColor;
  TextFeild({super.key,required this.hintText,required this.icon,required this.borderColor ,required this.fillColor, required this.controller,required this.keyboardType});

  @override
  State<TextFeild> createState() => _TextFeildState();
}

class _TextFeildState extends State<TextFeild> {
  @override

  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: true,
            hintText:widget.hintText,
            prefixIcon: Icon(widget.icon),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor),
              borderRadius: BorderRadius.circular(15),

            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor),
              borderRadius: BorderRadius.circular(15),

            ),
          ),

        ),

      ],
    );

  }
}


