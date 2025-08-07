import 'package:flutter/material.dart';
class CustomelevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontsize;
  final FontWeight fontWeight;
  const CustomelevatedButton({super.key,required this.onPressed,required this.text,required this.backgroundColor,required this.fontsize,required this.fontWeight,required this.textColor});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child:Text(text, style: TextStyle(
            color: textColor,
            fontSize: fontsize,
            fontWeight: fontWeight),
        ),),
    );


  }
}
