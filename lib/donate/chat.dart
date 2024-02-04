import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController textController = TextEditingController();
  final TextEditingController receiveridController = TextEditingController();
  late User currentUser;
  late String currentUserId;
  late String currentUserName;
  late String receiverId = "abc@gmail.com";
  late String receiverName = "abc";

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser!;
    currentUserId = currentUser.uid;
    currentUserName = currentUser.displayName ?? currentUser.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('messages')
                  .where('senderId', isEqualTo: currentUserId)
                  .where('receiverId', isEqualTo: receiverId)
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("No messages"));
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message['text']),
                      subtitle: Text(formatTime(message['createdAt'])),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Type a message', border: InputBorder.none),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: receiveridController,
                    decoration: InputDecoration(
                        hintText: 'Reciever\'\s id: ',
                        border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    firestore.collection('messages').add({
                      'text': textController.text.trim(),
                      'senderId': currentUserId,
                      'senderName': currentUserName,
                      'receiverId': receiverId,
                      'receiverName': receiverName,
                      'createdAt': DateTime.now(),
                    });
                    textController.clear();
                    receiveridController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final timeFormatter = DateFormat.jm();
    return timeFormatter.format(dateTime);
  }
}
