import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> chatMessages = [];

  @override
  void initState() {
    super.initState();
    loadChat();
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    final url = Uri.parse('http://192.168.1.18:3000/api/messages/send');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'senderId': senderId,
          'receiverId': receiverId,
          'message': message,
        }),
      );

      if (response.statusCode == 201) {
        print('✅ Message sent successfully');
      } else {
        print('❌ Failed to send message: ${response.body}');
      }
    } catch (e) {
      print('⚠️ Error sending message: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchMessages(
      String senderId, String receiverId) async {
    final url =
    Uri.parse('http://192.168.1.18:3000/api/messages/chat/$senderId/$receiverId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['messages']);
      } else {
        print('Failed to load messages: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  void loadChat() async {
    final messages = await fetchMessages("institute123", "student456");
    setState(() {
      chatMessages = messages;
    });
  }

  Widget buildMessageBubble(Map<String, dynamic> msg) {
    bool isMe = msg['senderId'] == 'institute123';
    String time = DateTime.parse(msg['timestamp'])
        .toLocal()
        .toString()
        .substring(11, 16); // HH:mm format

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Color(0xFFDCF8C6) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(isMe ? 12 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              msg['message'],
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final msg = chatMessages[chatMessages.length - 1 - index];
                return buildMessageBubble(msg);
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                    InputDecoration(hintText: 'Type your message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      await sendMessage(
                        senderId: 'institute123',
                        receiverId: 'student456',
                        message: text,
                      );
                      _controller.clear();
                      await Future.delayed(Duration(milliseconds: 300));
                      loadChat();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
