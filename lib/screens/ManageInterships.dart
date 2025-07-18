import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Internship_detailScreeen.dart';
import 'package:tech_linker_new/widget/intern_Card.dart';

class Manageinterships extends StatefulWidget {
  const Manageinterships({super.key});

  @override
  State<Manageinterships> createState() => _ManageintershipsState();
}

class _ManageintershipsState extends State<Manageinterships> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  final List<Map<String, dynamic>> internships = [
    {
      'title': 'Flutter Developer',
      'posted': ' 15 May 2025',
      'institute': 'Code Lab',
      'location': 'Gujranwala',
       'duration': '3 Months',
      'description': 'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'Android Developer',
      'posted': ' 20 May 2025',
      'institute': ' EraTech',
      'location': 'Lahore',
      'duration': '3 Months',
      'description': 'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'iOS Developer',
      'posted': ' 10 May 2025',
      'institute': ' EraTech',
      'location': ' Islamabad',
      'duration': '3 Months',
      'description':'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'Web Developer',
      'posted': ' 8 May 2025',
      'institute': 'EraTech',
      'location': ' Gujrat',
      'duration': '3 Months',
      'description': 'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'Frontend Developer',
      'posted': ' 15 May 2025',
      'institute': ' EraTech',
      'location': ' Deena',
      'duration': '3 Months',
      'description': 'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'Backend Developer',
      'posted': ' 02 June 2025',
      'institute': 'EraTech',
      'location': ' Rahwali',
      'duration': '3 Months',
      'description': 'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'Full Stack Developer',
      'posted': '15 July 2025',
      'institute': 'EraTech',
      'location': ' Rawalpindi',
      'duration': '3 Months',
      'description':'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'React Developer',
      'posted': ' 20 October 2025',
      'institute': ' EraTech',
      'location': ' Karachi',
      'duration': '3 Months',
      'description':'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'Python Developer',
      'posted': ' 09 April 2025',
      'institute': ' EraTech',
      'location': ' Gujar Khan',
      'duration': '3 Months',
      'description': 'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
    {
      'title': 'Machine Learning Intern',
      'posted': ' 7 March 2025',
      'institute': ' EraTech',
      'location': 'Sadar',
      'duration': '3 Months',
      'description': 'This internship offers a hands-on opportunity to work with Flutter, building real mobile applications. You\'ll be collaborating with experienced developers and receive mentorship throughout. Participants will gain practical experience in Dart, state management, and UI/UX best practices. You will be required to participate in daily stand-ups and team meetings. Selected interns may be offered a full-time role after the program. Good communication and problem-solving skills are a plus. Apply now to kick-start your Flutter development journey!',
      'featured': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final sortedInternships=[...internships];
    sortedInternships.sort((a,b)=>(b['featured']? 1:0).compareTo(a['featured']?1:0));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor:  Color(0XFF6750A4),
        iconTheme: IconThemeData(color: Colors.white),
        title:  Text('Manage Internships',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
               EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by internship or location',
                  prefixIcon:  Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),

            ...sortedInternships
                .where((internship) => internship['title']!.toLowerCase().contains(searchQuery) || internship['location']!.toLowerCase().contains(searchQuery))
                .map((internship) => InternCard(
              text: internship['title']!,
              posted: internship['posted']!,
              institute: internship['institute']!,
              location: internship['location']!,
              featured:  internship['featured']!,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InternshipDetailscreeen(
                  title:  internship['title']!,
                  posted: internship['posted']!,
                  institute: internship['institute']!,
                  location: internship['location']!,
                  duration: internship['duration']!,
                  description: internship['description']!,

                )));

              },
              onFeaturedTap:(){
                 setState(() {
                 internship['featured']=!internship['featured'];
                  });
                },
               onDeleteTap:(){
                  setState(() {
                    internships.remove(internship);
                  });
              },
            )
            )
                .toList(),
          ],
        ),
      ),
    );
  }
}
