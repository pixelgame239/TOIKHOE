// chat_doc_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';

import '../database/connection.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;
  const ChatScreen({Key? key, required this.userId, required this.userName}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final String _receiverId;
  late final String _receiverName;
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final String _senderId = 'user123'; // Assuming senderId is set here

  @override
  void initState() {
    super.initState();
    _receiverId = widget.userId;
    _receiverName = widget.userName;

    // Ngăn không cho nhắn tin với chính mình
    if (_senderId == _receiverId) {
      Future.microtask(() {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Bạn không thể nhắn tin với chính mình!"),
          ),
        );
      });
    }

    _loadMessages();
  }

  void _loadMessages() async {
    final messages = await DatabaseService.fetchMessages(_senderId, _receiverId);
    setState(() {
      _messages.addAll(messages);
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final message = _messageController.text.trim();
      final timestamp = DateTime.now();

      setState(() {
        _messages.add({
          'text': message,
          'isSentByMe': true,
          'timestamp': timestamp,
        });
      });

      await DatabaseService.sendMessage(_senderId, _receiverId, message);
      _messageController.clear();
    }
  }

  bool _shouldShowTimestamp(int index) {
    if (index == 0) return true;
    final DateTime currentMessageTime = _messages[index]['timestamp'];
    final DateTime previousMessageTime = _messages[index - 1]['timestamp'];
    return currentMessageTime.difference(previousMessageTime).inMinutes >= 5;
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f5f6),
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        child: Column(
          children: [
            // Header của màn hình chat
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/chat111.png'),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _receiverName, // Use the receiver's name here
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Danh sách tin nhắn
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final bool showTimestamp = _shouldShowTimestamp(index);
                  final bool isSentByMe = message['isSentByMe'];

                  return Column(
                    crossAxisAlignment: isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (showTimestamp)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              _formatTime(message['timestamp']),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      _buildMessageBubble(
                        text: message['text'],
                        isSentByMe: isSentByMe,
                      ),
                    ],
                  );
                },
              ),
            ),

            // Thanh nhập tin nhắn
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble({required String text, required bool isSentByMe}) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isSentByMe ? 15 : 0),
            topRight: Radius.circular(isSentByMe ? 0 : 15),
            bottomLeft: const Radius.circular(15),
            bottomRight: const Radius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
