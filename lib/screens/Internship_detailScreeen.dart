import 'package:flutter/material.dart';
class InternshipDetailscreeen extends StatefulWidget {
  final String title , posted , institute, location, description,duration;
  const InternshipDetailscreeen({super.key,required this.title,required this.posted, required this.institute, required this.location,required this.description,required this.duration});

  @override
  State<InternshipDetailscreeen> createState() => _InternshipDetailscreeenState();
}

class _InternshipDetailscreeenState extends State<InternshipDetailscreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color(0XFF6750A4),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Institute : ${widget.institute}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 22),
              Text('Posted : ${widget.posted}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 22,),
              Text('Location : ${widget.location}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 22,),
              Text('Description :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
              Padding(
                padding: const EdgeInsets.only(left:15,top: 10),
                child: Text(widget.description,style: TextStyle(color: Colors.white,fontSize: 16,height: 1.5),textAlign: TextAlign.left),
              ),
              SizedBox(height: 22,),
              Text('Duration : ${widget.duration}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 22,),

            ],
          ),
        ),
      )
    );
  }
}
