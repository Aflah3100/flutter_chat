import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/chat_screen/widgets/chat_text_field.dart';
import 'package:flutter_chat/screens/chat_screen/widgets/fetch_chats_stream_builder.dart';

// ignore: must_be_immutable
class ScreenUserChat extends StatelessWidget {
  ScreenUserChat(
      {super.key,
      required this.chatuserName,
      required this.loggedUserName,
      required this.chatRoomId});
  //User and chat details
  String chatuserName, loggedUserName, chatRoomId;

  //keys
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xff492E87),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          chatuserName,
          style: const TextStyle(
              fontSize: 25.0,
              color: Colors.white70,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body:
          //Base-Container
          Container(
        margin: EdgeInsets.only(top: height * 0.01),
        height: height,
        width: width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        child: Column(
          children: [
            Expanded(
              //Fetch-Chats-Stream
              child: FetchChatsStreamBuilder(
                  chatRoomId: chatRoomId,
                  loggedUserName: loggedUserName,
                  height: height,
                  width: width),
            ),

            //Chat-Text-Field
            Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: ChatTextField(
                height: height,
                width: width,
                messageController: messageController,
                loggedUserName: loggedUserName,
                chatRoomId: chatRoomId,
                scaffoldKey: scaffoldKey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
