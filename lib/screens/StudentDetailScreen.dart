import 'package:flutter/material.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_label.dart';
import 'package:tech_linker_new/widget/coustomElevated_Button.dart';
class Studentdetailscreen extends StatefulWidget {
  final Map<String, String> student;
  final Function() onDelete;
  final Function() Notification;

  const Studentdetailscreen({
    super.key,
    required this.student,
    required this.onDelete,
    required this.Notification,
  });

  @override
  State<Studentdetailscreen> createState() => _StudentdetailscreenState();
}

class _StudentdetailscreenState extends State<Studentdetailscreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _studyController;
  late TextEditingController _identityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student['name']);
    _emailController = TextEditingController(text: widget.student['email']);
    _addressController = TextEditingController(text: widget.student['Address']);
    _phoneController = TextEditingController(text: widget.student['Phone']);
    _studyController = TextEditingController(text: widget.student['Graduation']);
    _identityController = TextEditingController(text: widget.student['Identity']);

  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _studyController.dispose();
    _identityController.dispose();
    super.dispose();
  }
  void _showNotificationReasonDialog(BuildContext context) {
    String? selectedReason;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Notification Reason'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButtonFormField<String>(
                value: selectedReason,
                items: [
                  'Profile incomplete',
                  'Invalid email',
                  'Missing phone number',
                  'Education info required',
                  'Invalid identity info',
                ].map((reason) {
                  return DropdownMenuItem<String>(
                    value: reason,
                    child: Text(reason),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedReason = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cancel
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedReason != null) {
                  widget.Notification(); // call your actual logic here
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notification sent: $selectedReason')),
                  );
                }
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),
        title: Text('Student Profile',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),

      ),
        backgroundColor: Color(0XFF6750A4),
    ),


      body: Padding(
        padding:EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFieldLabel(controller: _nameController, readOnly: true, labelText: 'Name'),
            SizedBox(height: 18),
            TextFieldLabel(controller: _emailController, readOnly: true, labelText: 'Email'),
            SizedBox(height: 18),
            TextFieldLabel(controller: _addressController, readOnly: true, labelText: 'Address'),
            SizedBox(height: 18),
            TextFieldLabel(controller: _phoneController, readOnly: true, labelText: 'Phone'),
            SizedBox(height: 18),
            TextFieldLabel(controller: _studyController, readOnly: true, labelText: 'Graduation'),
            SizedBox(height: 18),
            TextFieldLabel(controller: _identityController, readOnly: true, labelText: 'Identity'),
            SizedBox(height: 20),
            CustomelevatedButton(onPressed: (){widget.onDelete();Navigator.pop(context);}, text: 'Delete Student', backgroundColor: Colors.redAccent, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.white),
            SizedBox(height: 20),
            CustomelevatedButton(onPressed: (){_showNotificationReasonDialog(context);}, text: 'Send Notifications', backgroundColor: Colors.green, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
