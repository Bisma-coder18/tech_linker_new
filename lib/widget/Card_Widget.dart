import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color color;
  const CustomCard({super.key,required this.title,required this.icon,required this.subTitle,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         color: color,
         
         borderRadius: BorderRadius.circular(10)
       ) ,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 35, color:Colors.white),
              SizedBox(height: 09),
              Text(title,style: TextStyle(color:Colors.white,fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(subTitle,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );


  }
}
