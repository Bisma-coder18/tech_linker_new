import 'package:flutter/material.dart';
class Institutenotification extends StatefulWidget {
  const Institutenotification({super.key});

  @override
  State<Institutenotification> createState() => _InstitutenotificationState();
}

class _InstitutenotificationState extends State<Institutenotification> {
  List<Map<String,dynamic>> Notification =[
    {
      'Student' : 'Ayesha',
      'Title' :'Flutter Developer',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Bisma',
      'Title' :'Application Developer',
      'isRead' : false,
      'timeStamp': DateTime.now()
    },
    {
      'Student' : 'Haseeb',
      'Title' :'React Native',
      'isRead' : false,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Uzma',
      'Title' :'Andriod Studio',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Fariha',
      'Title' :'React Node',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Mustabshara',
      'Title' :'Flutter',
      'isRead' : false,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Nimra',
      'Title' :'Developer',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Tamseela',
      'Title' :'Flutter Developer',
      'isRead' : false,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Sania',
      'Title' :'Flutter Developer',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Tania',
      'Title' :'Flutter Developer',
      'isRead' : false,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Tahmoor',
      'Title' :'Flutter Developer',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Laiba',
      'Title' :'Flutter Developer',
      'isRead' : false,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Minahil',
      'Title' :'Flutter Developer',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Zunaira',
      'Title' :'Flutter Developer',
      'isRead' : false,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Laiba',
      'Title' :'Flutter Developer',
      'isRead' : true,
      'timeStamp': DateTime.now(),
    },
    {
      'Student' : 'Abdullah',
      'Title' :'Flutter Developer',
      'isRead' : false,
      'timeStamp': DateTime.now(),
    },

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
          itemCount: Notification.length ,
          itemBuilder:(context,index){
            return Card(
              color: Notification[index]['isRead']?Colors.white:Colors.grey,
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
              child: ListTile(
                onTap: (){
                  setState(() {
                    Notification[index]['isRead']=true;
                  });
                },
                title: Text('${Notification[index]['Student']} applied for ${Notification[index]['Title']}'),
                subtitle: Text('${Notification[index]['timeStamp']}'),
              ),
            );
          }
      ),
    );
  }
}
