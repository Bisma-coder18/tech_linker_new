import 'package:flutter/material.dart';

class InternCard extends StatelessWidget {
  final String text, posted, institute, location;
  final bool featured;
  final VoidCallback onTap,onFeaturedTap,onDeleteTap;


  const InternCard(
      {super.key,
      required this.text,
      required this.posted,
      required this.institute,
      required this.location,
      required this.onTap,
      required this.featured,
      required this.onFeaturedTap,
      required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children:[ Container(
          width: double.infinity,
          child: Card(
            elevation: 4,
            color: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      // color: Color(0xFF2A0845),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Posted On :$posted',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      // color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Institute :    $institute',
                    style: TextStyle(
                      color: Colors.white,
                      // color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Location :   $location',
                    style: TextStyle(
                      color: Colors.white,
                      // color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: onFeaturedTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[200],
                          foregroundColor: Color(0xFF2A0845),
                          minimumSize: Size(100, 40),
                        ),
                        child: Text('Featured'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: onDeleteTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[300],
                          foregroundColor: Colors.white,
                          minimumSize: Size(100, 40),
                        ),
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
          if(featured)
            Positioned(
              top:10,
              right:20,
              child:Icon(Icons.star,color: Colors.amber,size: 28,),
            ),

      ],
      ),
    );
  }
}
