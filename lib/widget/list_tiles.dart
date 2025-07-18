import 'package:flutter/material.dart';
class CustomListTiles extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const CustomListTiles({super.key,required this.icon,required this.title,required this.onTap,required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,color: color,),
      title: Text(title,style: TextStyle(color: color),),
    );
  }
}
