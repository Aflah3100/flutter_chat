import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/chat_message_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_chatroom_db_functions.dart';
import 'package:flutter_chat/screens/chat_screen/widgets/message_widget.dart';

class FetchChatsStreamBuilder extends StatelessWidget {
  const FetchChatsStreamBuilder({
    super.key,
    required this.chatRoomId,
    required this.loggedUserName,
    required this.height,
    required this.width,
    required this.scaffoldKey
  });

  final String chatRoomId;
  final String loggedUserName;
  final double height;
  final double width;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireStoreChatRoomDbFunc.instance
            .fetchChatRoomChats(chatRoomId: chatRoomId),
        builder: (ctx, snapshots) {
          //Connection-State-Waiting
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } //Snapshots has data
          else if (snapshots.hasData) {
            final snapShotsLists = snapshots.data!.docs;
            if (snapShotsLists.isEmpty) {
              //No-messages-sent-or-recieved
              return const Center(
                  child: Text(
                'Send a Hii!',
                style: TextStyle(fontSize: 20.0, color: Color(0xff492E87)),
              ));
            } else {
              //Fecthed-Messages
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    ChatMessageModel currentChat =
                        ChatMessageModel.fromMap(snapShotsLists[index].data());
                    
                    //Send-Chat-Widget
                    if (currentChat.sendBy == loggedUserName) {
                      return SentMessageBox(
                        height: height,
                        width: width,
                        messageModel: currentChat,
                        chatRoomId: chatRoomId, scaffoldKey: scaffoldKey,
                      );
                    }
                    //Recieved-Chat-Widget
                    else {
                      return RecievedMessageBox(
                          height: height,
                          width: width,
                          messageModel: currentChat);
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox();
                  },
                  itemCount: snapShotsLists.length);
            }
          } else {
            return const Center(
              child: Text(
                'Send a Hii!',
                style: TextStyle(fontSize: 30.0, color: Colors.blue),
              ),
            );
          }
        });
  }
}
