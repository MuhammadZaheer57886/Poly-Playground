import 'package:flutter/material.dart';
import 'package:poly_playground/common/pop_message.dart';
import '../../../common/store.dart';
import '../../../model/user_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/firebase_utils.dart';
import '../../../utils/http_requests.dart';
import '../../../utils/my_utils.dart';
import '../../ui_components/custom_text_field.dart';

class MessageComposer extends StatefulWidget {
  final String receiverId;
  const MessageComposer({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  final TextEditingController _messageController = TextEditingController();
  bool show = false;

  late String receeiverId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receeiverId = widget.receiverId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: _messageController,
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
                String msg = _messageController.text;
                  _messageController.clear();

                if (! await send(msg)) {
                  showFailedToast(context, "something went wrong");
                  _messageController.text = msg;

                }
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<bool> send(String data) async {
    if (data.isEmpty) {
      return false;
    }
    MessageModel message = MessageModel(
      message: data,
      senderId: Store().uid,
      receiverId: receeiverId,
      timestamp: formatDate().toString(),
      isRead: false,
      type: 'text',
    );
    await setMessageToFirestore(message);
    ChatModel chat = createChatModel(Store().friend!, message);
    ChatModel chat2 = createChatModel(Store().userData, message);
    await updateLastMessageToFirestore(chat,chat2);
    setState(() {
      show = false;
    });
    await messageNotification();
    return true;
  }

}
