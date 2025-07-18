import 'package:flutter/material.dart';

class ApplicationsReceivedScreen extends StatefulWidget {
  const ApplicationsReceivedScreen({super.key});

  @override
  State<ApplicationsReceivedScreen> createState() =>
      _ApplicationsReceivedScreenState();
}

class _ApplicationsReceivedScreenState
    extends State<ApplicationsReceivedScreen> {
  List<Map<String, String>> allApplications = [
    {
      'studentName': 'Ali Raza',
      'internshipTitle': 'Flutter Developer',
      'status': 'ShortListed',
    },
    {
      'studentName': 'Sara Khan',
      'internshipTitle': 'UI Designer',
      'status': 'Accepted',
    },
    {
      'studentName': 'Ahmed Khan',
      'internshipTitle': 'Backend Developer',
      'status': 'ShortListed',
    },
    {
      'studentName': 'Ahsan Khan',
      'internshipTitle': 'Backend Developer',
      'status': 'Rejected',
    },
    {
      'studentName': 'AliKhan',
      'internshipTitle': 'Backend Developer',
      'status': 'ShortListed',
    },
    {
      'studentName': 'Daniyal Khan',
      'internshipTitle': 'Backend Developer',
      'status': 'Accepted',
    },
    {
      'studentName': 'Samina Khan',
      'internshipTitle': 'Backend Developer',
      'status': 'Rejected',
    },
    {
      'studentName': 'Eman Khan',
      'internshipTitle': 'Backend Developer',
      'status': 'ShortListed',
    },
    {
      'studentName': 'AbuBakkar Khan',
      'internshipTitle': 'Backend Developer',
      'status': 'Accepted',
    },
    {
      'studentName': 'Taniya',
      'internshipTitle': 'Backend Developer',
      'status': 'ShortListed',
    },
    {
      'studentName': 'ALiza',
      'internshipTitle': 'Backend Developer',
      'status': 'Accepted',
    },
    {
      'studentName': 'Samia',
      'internshipTitle': 'Backend Developer',
      'status': 'Rejected',
    },
    {
      'studentName': 'Tahira',
      'internshipTitle': 'Backend Developer',
      'status': 'ShortListed',
    },
    {
      'studentName': 'Minahil',
      'internshipTitle': 'Backend Developer',
      'status': 'Rejected',
    },
    {
      'studentName': 'Tamseela',
      'internshipTitle': 'Backend Developer',
      'status': 'Accepted',
    },
    {
      'studentName': 'Haseeb',
      'internshipTitle': 'Backend Developer',
      'status': 'ShortListed',
    },

  ];

  void updateStatus(int index, String newStatus) {
    setState(() {
      allApplications[index]['status'] = newStatus;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // All, Accepted, Rejected
      child: Scaffold(
        appBar: AppBar(
          title: Text("Applications Received",style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.deepPurple,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
              Tab(text: 'ShortListed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildApplicationsList('All'),
            buildApplicationsList('Accepted'),
            buildApplicationsList('Rejected'),
            buildApplicationsList('ShortListed'),
          ],
        ),
      ),
    );
  }

  Widget buildApplicationsList(String statusFilter) {
    List<Map<String, String>> filteredList;
    if(statusFilter=='All'){
      filteredList = allApplications;
    } else{
      filteredList=allApplications.where((app)=> app['status']== statusFilter).toList();
    }
    if(filteredList.isEmpty){
      return Center(child: Text('No Application with Status "$statusFilter".',style: TextStyle(color: Colors.grey,fontSize: 16),));
    }


    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final app = filteredList[index];
        // Get original index from allApplications
        final originalIndex = allApplications.indexOf(app);

        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Student: ${app['studentName']}',
                    style:  TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                 SizedBox(height: 5),
                Text('Internship: ${app['internshipTitle']}'),
                 SizedBox(height: 5),
                Text('Status: ${app['status']}',
                    style:  TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey)),
                 SizedBox(height: 10),

                /// Show Accept/Reject/Restore buttons
                Row(
                  children: [
                    if (app['status'] != 'Accepted')
                      ElevatedButton(
                        onPressed: () =>
                            updateStatus(originalIndex, 'Accepted'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child:  Text('Accept'),
                      ),
                     SizedBox(width: 10),
                    if (app['status'] != 'Rejected')
                      ElevatedButton(
                        onPressed: () =>
                            updateStatus(originalIndex, 'Rejected'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: Text('Reject'),
                      ),
                    SizedBox(width: 7,),
                    if (app['status'] != 'ShortListed')
                      ElevatedButton(
                        onPressed: () =>
                            updateStatus(originalIndex, 'ShortListed'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: Text('ShortListed'),
                      ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
