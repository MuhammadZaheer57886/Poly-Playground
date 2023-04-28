import 'package:flutter/material.dart';
import 'package:poly_playground/ui/ui_components/custom_text_field.dart';
import 'package:poly_playground/utils/my_utils.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/firebase_utils.dart';

class MessageScreen extends StatefulWidget {
  final String receiverId;

  const MessageScreen({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreen();
}

class _MessageScreen extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
  bool show = false;
  String prevMessageDate = '';
  String messageDate = '';
  late FriendModel friend;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friend = Store().friends.firstWhere((frnd) => frnd.uid == widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.i.greyColor.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(friend.photoUrl),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(friend.fullName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: size.width * 0.06)),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.2,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: listenForNewMessages(friend.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> messages = snapshot.data!;
                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) =>
                            messageView(messages[index]),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              _buildMessageComposer(),
            ],
          ),
        ),
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
            backgroundImage: NetworkImage(friend.photoUrl),
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
            child: CustomTextField(
              controller: messageController,
              // hintText: 'Type a message...',
              titleText: 'Type a message...',
              color: AppColors.i.greyColor.withOpacity(0.2),
              radius: 15,
              pl: 20,
              isDark: false,

              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    show = true;
                  });
                } else {
                  setState(() {
                    show = false;
                  });
                }
              },
            ),
          ),
          Padding(

            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
              icon: Icon(
                Icons.send,
                size: 30,

                color: show ? AppColors.i.blueColor : AppColors.i.greyColor,
              ),
              onPressed: () async {
                if (await sendMessage(messageController.text)) {
                  messageController.clear();
                }
              },
            ),
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
      receiverId: friend.uid,
      timestamp: formatDate().toString(),
      isRead: false,
      type: 'text',
    );
    setMessagetoFirestore(message);
    setState(() {
      show = false;
    });
    return true;
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
