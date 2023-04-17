import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _currentUser = 'user1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
            'Welcome to our Chat Room!',
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data!.docs.reversed;
                  List<MessageBubble> messageBubbles = [];

                  for (var message in messages) {

                    final messageText = message['text'];
                    final messageSender = message['sender'];
                    final messageTime = message['timestamp'] as Timestamp;

                    final messageBubble = MessageBubble(
                      text: messageText,
                      sender: messageSender,
                      isCurrentUser: messageSender == _currentUser,
                      time: messageTime.toDate(),
                    );
                    messageBubbles.add(messageBubble);
                  }
                  return ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    children: messageBubbles,
                  );
                },
              ),
            ),

            const Divider(height: 1),

            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Send a message...',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      final text = _textController.text.trim();
                      if (text.isNotEmpty) {
                        _firestore.collection('messages').add({
                          'text': text,
                          'sender': _currentUser,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        _textController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isCurrentUser;
  final DateTime time;
  final double radiusDim = 40; // dimension of a message cell

  const MessageBubble({
    super.key,
    required this.text,
    required this.sender,
    required this.isCurrentUser,
    required this.time
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          const Text(
            'You',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),

          Material(
            color: isCurrentUser ? Colors.black.withOpacity(0.8) : Colors.black.withOpacity(0.8),
            elevation: 5,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusDim),
              topRight: Radius.circular(radiusDim),
              bottomLeft: isCurrentUser ? Radius.circular(radiusDim) : Radius.circular(radiusDim),
              bottomRight: isCurrentUser ? const Radius.circular(10) : const Radius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('dd/MM/yyyy hh:mm').format(time),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}