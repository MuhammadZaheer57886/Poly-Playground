import 'package:flutter/material.dart';
import 'package:poly_playground/utils/my_utils.dart';
import '../../common/pop_message.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/constants/app_colors.dart';
import 'package:intl/intl.dart';
class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreen();
}

class _MessageScreen extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
  bool show = false;
  String prevMessageDate = '';
  String messageDate = '';

  late  List<MessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessagesFromFirestore();
  }

  void _fetchMessagesFromFirestore() {
    getMessagesFromFirestore('Bi3yqQn6jTZCDAF2m7UwQyY3USp2')
        .then((messages) {
      setState(() {
        _messages = messages;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Jane Doe',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return messageView(_messages[index]);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildSentMessage(MessageModel message) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.7,
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              // color: Colors.blue,
              color: AppColors.i.darkBrownColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.message,
              style: TextStyle(
                color: AppColors.i.whiteColor,
              ),
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(Store().userData.photoUrl),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(MessageModel message) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(Store().userData.photoUrl),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.7,
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.i.greyColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.message,
              style: TextStyle(
                color: AppColors.i.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                if(value.isNotEmpty) {
                  setState(() {
                     show = true;
                  });
                }else {
                  setState(() {
                     show = false;
                  });
                }
              },
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: show ? AppColors.i.blueColor : AppColors.i.greyColor,
            ),
            onPressed: () async {
              if (await sendMessage(messageController.text)) {
                messageController.clear();
              } else {
                showFailedToast(context,'Message cannot be empty');
              }
            },
          ),
        ],
      ),
    );
  }

  Future<bool> sendMessage(String data) async {
    if (data.isEmpty) {
      return false;
    }
    MessageModel message = MessageModel(
      message: data,
      senderId: Store().uid,
      receiverId: 'Bi3yqQn6jTZCDAF2m7UwQyY3USp2',
      timestamp: DateTime.now().toString(),
      isRead: false,
    );
    setMessagetoFirestore(message);
    setState(() {
      _messages.add(message);
    });
    return true;
  }

  String getMessageTime( String date) {
    DateTime messageTime = DateTime.parse(date);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime twoDaysAgo = today.subtract(const Duration(days: 2));
    DateTime weekAgo = today.subtract(const Duration(days: 7));

    if (messageTime.isAfter(today)) {
      return 'Today';
    } else if (messageTime.isAfter(yesterday)) {
      return 'Yesterday';
    } else if (messageTime.isAfter(twoDaysAgo)) {
      return '2 Days Ago';
    } else if (messageTime.isAfter(weekAgo)) {
      int numDays = today.difference(messageTime).inDays;
      return '$numDays Days Ago';
    } else {
      DateFormat formatter = DateFormat('MMMM dd, yyyy');
      return formatter.format(messageTime);
    }
  }

  Widget messageView(MessageModel message) {
    if (prevMessageDate != getMessageTime(message.timestamp)) {
      messageDate = getMessageTime(message.timestamp);
      prevMessageDate = messageDate;
    } else {
      messageDate = '';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(messageDate),
        message.senderId == Store().uid
            ? _buildSentMessage(message)
            : _buildReceivedMessage(message),
      ],
    );
  }
}
