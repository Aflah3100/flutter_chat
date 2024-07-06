import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/chat_message_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_chatroom_db_functions.dart';
import 'package:flutter_chat/utils/widget_functions.dart';

//Send Message container widget
class SentMessageBox extends StatelessWidget {
  const SentMessageBox(
      {super.key,
      required this.height,
      required this.width,
      required this.messageModel,
      required this.chatRoomId,
      required this.scaffoldKey});

  final double height;
  final double width;
  final ChatMessageModel messageModel;
  final String chatRoomId;
  final GlobalKey<ScaffoldState> scaffoldKey;

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String chatRoomId, String messgId) async {
    return showDialog<void>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            icon: const Icon(Icons.delete_outline),
            iconColor: const Color(0xff26355D),
            backgroundColor: Colors.grey[200],
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  //Alert-Text
                  Center(
                    child: Text(
                      'Delete message from chat?',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff26355D)),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all(const Color(0xff4A249D))),
                  onPressed: () {
                    Navigator.of(scaffoldKey.currentContext!).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all(const Color(0xff4A249D))),
                  onPressed: () async {
                    final deleteResult = await FireStoreChatRoomDbFunc.instance
                        .deleteMessage(
                            chatRoomId: chatRoomId, messgId: messgId);

                    if (deleteResult) {
                      Navigator.of(scaffoldKey.currentContext!).pop();
                    } else {
                      showFirebaseErrorSnackBar(
                          deleteResult, scaffoldKey.currentContext!);
                    }
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: height * 0.02, right: height * 0.02, top: height * 0.02),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onLongPress: () {
            _showDeleteConfirmationDialog(
                context, chatRoomId, messageModel.messgId);
          },
          child: Container(
            margin: EdgeInsets.only(left: width * 0.10),
            padding: EdgeInsets.all(height * 0.01),
            decoration: const BoxDecoration(
              color: Color(0xff7FC7D9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Wrap(
              children: [
                Text(
                  //Display-chat-message
                  messageModel.message,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Recieved Message Container Widget
class RecievedMessageBox extends StatelessWidget {
  const RecievedMessageBox(
      {super.key,
      required this.height,
      required this.width,
      required this.messageModel});

  final double height;
  final double width;
  final ChatMessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: height * 0.01, right: height * 0.01, top: height * 0.01),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.only(right: width * 0.25),
          padding: EdgeInsets.all(height * 0.01),
          decoration: const BoxDecoration(
            color: Color(0xff67C6E3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Wrap(
            children: [
              Text(
                //Display-chat-message
                messageModel.message,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
