import 'package:flutter/material.dart';
import 'package:tech_linker_new/widget/intern_Card.dart';

class Instituteinternships extends StatefulWidget {
  const Instituteinternships({super.key});

  @override
  State<Instituteinternships> createState() => _InstituteinternshipsState();
}

class _InstituteinternshipsState extends State<Instituteinternships> {
  String searchQuery='';
  TextEditingController searchController =TextEditingController();
  List<Map<String,dynamic>>Internships= [
    {
      "text": "Flutter Developer",
      "posted": "12May2025",
      "institute": "Era Tech",
      "location": "Mumtaz Market",
      "featured":false,
      "featuredAt":null,

    },
    {
      "text": "UI/Ux",
      "posted": "15Feb2025",
      "institute": "Era Tech",
      "location": "Mumtaz Market",
      "featured":false,
      "featuredAt":null,


    },
    {
      "text": "React Native",
      "posted": "12Jan2025",
      "institute": "Era Tech",
      "location": "Mumtaz Market",
      "featured":false,
      "featuredAt":null,


    },
    {
      "text": "React Node",
      "posted": "09April2025",
      "institute": "Era Tech",
      "location": "Mumtaz Market",
      "featured":false,
      "featuredAt":null,


    },
    {
      "text": "Java",
      "posted": "12June2025",
      "institute": "Era Tech",
      "location": "Mumtaz Market",
      "featured":false,
      "featuredAt":null,

    },
    {
      "text": "Java Script",
      "posted": "01August2025",
      "institute": "Era Tech",
      "location": "Mumtaz Market",
      "featured":false,
      "featuredAt":null,

    },
    {
      "text": "Graphic Designing",
      "posted": "27March2025",
      "institute": "Era Tech",
      "location": "Mumtaz Market",
      "featured":false,
      "featuredAt":null,
    },

  ];
  void onFeatured(int index){
    setState(() {
      Internships[index]['featured']=!(Internships[index]['featured']??false);
      Internships = List.from(Internships); // force rebuild
      Internships.sort((a, b) {
        if ((a['featured'] ?? false) && (b['featured'] ?? false)) {
          return (b['featuredAt'] as DateTime).compareTo(a['featuredAt'] as DateTime);
        }
        return (b['featured'] ? 1 : 0).compareTo(a['featured'] ? 1 : 0);
      });
    });
  }
  void onDelete(int index){
   setState(() {
     Internships.removeAt(index);
   });
  }
  @override
  Widget build(BuildContext context) {
    final filteredList =Internships.where((item)=>
    item['text'].toLowerCase().contains(searchQuery.toLowerCase())||
    item['institute'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('My Internships', style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            shadows: [
              Shadow(color: Colors.black, blurRadius: 2, offset: Offset(2, 2)),
              Shadow(
                  color: Colors.deepPurple, blurRadius: 6, offset: Offset(2, 2))
            ]),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
             onChanged: (value){setState(() {
               searchQuery=value;
             });},
              decoration: InputDecoration(
                hintText: 'Search by name or institute',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)
                ),
                filled: true,
                fillColor: Colors.white
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final item = filteredList[index];
                  final realIndex = Internships.indexOf(item);
                  return InternCard(
                    text: item['text'],
                    posted: item['posted'],
                    institute: item['institute'],
                    location: item['location'],
                    featured:item['featured'],
                    onTap: () {},
                    onDeleteTap: () {
                      if (realIndex != -1) {
                        onDelete(realIndex); // ✅ Use real index
                      }
                    },
                onFeaturedTap: () {
                setState(() {
                Internships[index]['featured'] = !(Internships[index]['featured'] ?? false);
                Internships[index]['featuredAt'] = Internships[index]['featured'] ? DateTime.now() : null;

                Internships = List.from(Internships); // force rebuild
                Internships.sort((a, b) {
                if ((a['featured'] ?? false) && (b['featured'] ?? false)) {
                return (b['featuredAt'] as DateTime).compareTo(a['featuredAt'] as DateTime);
                }
                return (b['featured'] ? 1 : 0).compareTo(a['featured'] ? 1 : 0);
                });
                });
                },
                //     onDeleteTap: () => onDelete(index),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
  }

