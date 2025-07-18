import 'package:flutter/material.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_label.dart';
import 'package:tech_linker_new/widget/coustomElevated_Button.dart';
class Institutedetailscreeen extends StatefulWidget {
  final Map<String, String> institute;
  final Function() onDelete;
  final Function() Notification;

  const Institutedetailscreeen({
    super.key,
    required this.institute,
    required this.onDelete,
    required this.Notification,
  });

  @override
  State<Institutedetailscreeen> createState() => _Institutedetailscreeen();
}

class _Institutedetailscreeen extends State<Institutedetailscreeen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _CourcesController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.institute['name']);
    _emailController = TextEditingController(text: widget.institute['email']);
    _CourcesController = TextEditingController(text: widget.institute['Cources']);
    _phoneController = TextEditingController(text: widget.institute['Phone']);
    _locationController = TextEditingController(text: widget.institute['Location']);

  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _CourcesController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
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
                  'Courses info required',
                  'Invalid Location',
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
        title: Text('Institute Profile',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),

        ),
        backgroundColor: Color(0XFF6750A4),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TextFieldLabel(controller: _nameController, readOnly: true, labelText: 'Name'),
            SizedBox(height: 25),
            TextFieldLabel(controller: _emailController, readOnly: true, labelText: 'Email'),
            SizedBox(height: 25),
            TextFieldLabel(controller:_CourcesController, readOnly: true, labelText: 'Courses'),
            SizedBox(height: 25),
            TextFieldLabel(controller: _phoneController, readOnly: true, labelText: 'Phone'),
            SizedBox(height: 25),
            TextFieldLabel(controller: _locationController, readOnly: true, labelText: 'Location'),
            SizedBox(height: 20),
            CustomelevatedButton(onPressed:  (){widget.onDelete(); Navigator.pop(context);}, text: 'Delete Institute', backgroundColor: Colors.redAccent, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.white),
            SizedBox(height: 20),
            CustomelevatedButton(onPressed:  (){_showNotificationReasonDialog(context);}, text: 'Send Notification', backgroundColor: Colors.green, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
