import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/chat_message_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_chatroom_db_functions.dart';
import 'package:flutter_chat/utils/widget_functions.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class ChatTextField extends StatelessWidget {
  ChatTextField(
      {super.key,
      required this.height,
      required this.width,
      required this.messageController,
      required this.loggedUserName,
      required this.chatRoomId,
      required this.scaffoldKey});

  final double height;
  final double width;
  final TextEditingController messageController;
  final String loggedUserName;
  final String chatRoomId;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ValueNotifier<bool> chatTextFieldNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      elevation: 4.0,
      child: Padding(
          padding: EdgeInsets.only(
              left: width * 0.03, top: width * 0.02, bottom: width * 0.01),
          child: ValueListenableBuilder(
              valueListenable: chatTextFieldNotifier,
              builder: (ctx, val, _) {
                return TextField(
                  controller: messageController,
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter a Message',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                        onTap: () async {
                          if (messageController.text.isNotEmpty) {
                            //Send-Chat-to-chatroom
                            DateTime dateTimeNow = DateTime.now();
                            String formattedDate =
                                DateFormat('h:mm a').format(dateTimeNow);
                            ChatMessageModel messageModel = ChatMessageModel(
                                messgId: const Uuid().v4(),
                                message: messageController.text,
                                sendBy: loggedUserName,
                                timeStamp: formattedDate,
                                serverTimeStamp: Timestamp.now());
                            final result = await FireStoreChatRoomDbFunc
                                .instance
                                .saveMessagetoChatRoom(
                                    messageModel: messageModel,
                                    chatRoomId: chatRoomId);
                            if (result is bool) {
                              //Success
                              messageController.text = "";
                              chatTextFieldNotifier.value =
                                  !chatTextFieldNotifier.value;
                            } else {
                              //Error-Sending-Message-To-ChatRoomDb
                              showFirebaseErrorSnackBar(
                                  result, scaffoldKey.currentContext!);
                            }
                          }
                        },
                        //Send-Message-Icon
                        child: Container(
                          margin: EdgeInsets.only(right: width * 0.005),
                          padding: EdgeInsets.only(left: width * 0.006),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.black12),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Color(0xff492E87),
                          ),
                        )),
                  ),
                );
              })),
    );
  }
}
