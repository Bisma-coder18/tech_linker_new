import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/InstituteDetailScreeen.dart';

class Manageinstitute extends StatefulWidget {
  const Manageinstitute({super.key});

  @override
  State<Manageinstitute> createState() => _ManageinstituteState();
}

class _ManageinstituteState extends State<Manageinstitute> {
  Map<String, List<Map<String, String>>> studentNotifications = {};
  List<Map<String, String>> allInstitute = [
    {
      "name": "EraTech",
      "email": "era12@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "Byets",
      "email": "bytes@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "KualitySoft",
      "email": "kuality@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "LuxoSoft Technologies",
      "email": "luxo1@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "Digital Logicx",
      "email": "logix@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "Technotz",
      "email": "technotz@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "Brackets Private Limited",
      "email": "private@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "Sarck Solution",
      "email": "Sarck@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "29-GC, Opposite Main Park, Phase 2 Garden Town, Gujranwala, 52250, Pakistan"
    },
    {
      "name": "Technic Mentors Software Solutions",
      "email": "mentors23@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "148 Mumtaz Market, Opposite to ChaseUp, GT Road, Gujranwala, Pakistan"
    },
    {
      "name": "Innovate Technologies Pakistan",
      "email": "pak12@bisma.com",
      "Cources": "flutter,UI/UX",
      "Phone": "12345678",
      "Location": "Mumtaz Market, Gujranwala, Pakistan"
    },
  ];


  List<Map<String, String>> filteredInstitue = [];
  List<Map<String, String>> deletedInstitute = [];



  @override
  void initState() {
    super.initState();
    filteredInstitue = allInstitute;
  }

  void _filterInstitute(String query) {
    final results = allInstitute.where((institute) {
      final name = institute['name']!.toLowerCase();
      final email = institute['email']!.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input) || email.contains(input);
    }).toList();

    setState(() {
      filteredInstitue = results;
    });
  }
  void _deleteinstitute(int index) {
    final deleted = allInstitute[index]; // store deleted institute

    setState(() {
      deletedInstitute.add(deleted);
      allInstitute.removeAt(index);
      filteredInstitue = List.from(allInstitute);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Institute deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              allInstitute.insert(index, deleted);
              deletedInstitute.remove(deleted);
              filteredInstitue = List.from(allInstitute);
            });
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Manage Institutes',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0XFF6750A4),
      ),
      body: Column(
        children: [
         Padding(
           padding: const EdgeInsets.all(12),
           child: TextField(
             onChanged: _filterInstitute,
             decoration: InputDecoration(
               hintText: 'Search by name or email',
               prefixIcon: Icon(Icons.search),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
               filled: true,
               fillColor: Colors.grey[200],
             ),
           ),
         ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredInstitue.length,
            
                itemBuilder: (context,index){
                  final institute = filteredInstitue[index];
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person),),
                  title: Text(institute['name']!,style: TextStyle(color: Colors.white,fontSize: 18),),
                  subtitle: Text(institute['email']!,style: TextStyle(color: Colors.white),),
                  onTap: ()async{
                    final orignalIndex= allInstitute.indexOf(institute);
                    final result= await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Institutedetailscreeen(institute: institute, onDelete :()=> _deleteinstitute(orignalIndex), Notification: ()=>Notification)));

                  },
                );
                }),
          )
        ],
      ),
    );
  }
}
