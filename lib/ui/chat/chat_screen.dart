import 'package:flutter/material.dart';
import 'package:poly_playground/utils/my_utils.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/firebase_utils.dart';
import 'components/message_composer.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  const ChatScreen({Key? key, required this.receiverId}) : super(key: key);
  
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String prevMessageDate = '';
  String messageDate = '';
  late UserDataModel friend;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Store().friend = Store().friends. firstWhere((frnd) => frnd.uid == widget.receiverId);
    friend = Store().friend!;
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
                      // onPressed: () => screenPush(context, const ChatUserList()),
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
                                color: AppColors.i.blackColor,
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
              MessageComposer( receiverId: friend.uid,),
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
