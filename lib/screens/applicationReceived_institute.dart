import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/InstituteMessage.dart';

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
      'Email': 'Aliraza@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Sara Khan',
      'internshipTitle': 'UI Designer',
      'Email': 'Sara@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Ahmed Khan',
      'internshipTitle': 'Backend Developer',
      'Email': 'Ahmed@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Ahsan Khan',
      'internshipTitle': 'Backend Developer',
      'Email': 'Ahsan@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'AliKhan',
      'internshipTitle': 'Backend Developer',
      'Email': 'AliKhan@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Daniyal Khan',
      'internshipTitle': 'Backend Developer',
      'Email': 'Daniyal@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Samina Khan',
      'internshipTitle': 'Samina Developer',
      'Email': 'Aliraza@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Eman Khan',
      'internshipTitle': 'Backend Developer',
      'Email': 'Eman@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'AbuBakkar Khan',
      'internshipTitle': 'Backend Developer',
      'Email': 'AbuBakkar@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Taniya',
      'internshipTitle': 'Backend Developer',
      'Email': 'Taniya@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'ALiza',
      'internshipTitle': 'Backend Developer',
      'Email': 'ALiza@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Samia',
      'internshipTitle': 'Backend Developer',
      'Email': 'Samia@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Tahira',
      'internshipTitle': 'Backend Developer',
      'Email': 'Tahira@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Minahil',
      'internshipTitle': 'Backend Developer',
      'Email': 'Minahil@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Tamseela',
      'internshipTitle': 'Backend Developer',
      'Email': 'Tamseela@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Hassan',
      'internshipTitle': 'Backend Developer',
      'Email': 'Hassan@gmail.com',
      'status': 'New',
    },
    {
      'studentName': 'Haseeb',
      'internshipTitle': 'Backend Developer',
      'Email': 'Haseeb@gmail.com',
      'status': 'New',
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Applications Received", style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'New'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
              Tab(text: 'ShortListed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildApplicationsList('New'),
            buildApplicationsList('Accepted'),
            buildApplicationsList('Rejected'),
            buildApplicationsList('ShortListed'),
          ],
        ),
      ),
    );
  }

  Widget buildApplicationsList(String statusFilter) {
    List<Map<String, String>> filteredList = allApplications
        .where((app) => app['status'] == statusFilter)
        .toList();

    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          'No Application with Status "$statusFilter".',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final app = filteredList[index];
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

                //Name and Message Icon (only for Accepted)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Student: ${app['studentName']}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),

                    // Message Icon for Accepted Status
                    if (statusFilter == 'Accepted')
                      IconButton(
                        icon: const Icon(Icons.message, color: Colors.deepPurple),
                        tooltip: 'Message Student',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MessagesScreen(),
                            ),
                          );
                        },
                      ),
                  ],
                ),

                const SizedBox(height: 5),
                Text('Internship: ${app['internshipTitle']}'),
                Text('Email: ${app['Email']}'),
                const SizedBox(height: 5),

                if (statusFilter != 'New')
                  Text('Status: ${app['status']}',
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey)),

                const SizedBox(height: 10),

                // Buttons only for "New" Tab
                if (statusFilter == 'New')
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            updateStatus(originalIndex, 'Accepted'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text('Accept'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () =>
                            updateStatus(originalIndex, 'Rejected'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text('Reject'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () =>
                            updateStatus(originalIndex, 'ShortListed'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: const Text('ShortList'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

}
