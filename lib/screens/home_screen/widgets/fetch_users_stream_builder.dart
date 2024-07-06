import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_chatroom_db_functions.dart';
import 'package:flutter_chat/screens/chat_screen/user_chat_screen.dart';
import 'package:flutter_chat/utils/enums.dart';
import 'package:flutter_chat/utils/utils.dart';
import 'package:flutter_chat/utils/widget_functions.dart';

class FetchUsersStreamBuilder extends StatelessWidget {
  const FetchUsersStreamBuilder(
      {super.key,
      required this.loggedUser,
      required this.width,
      required this.height,
      required this.stream,
      required this.scaffoldKey});

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final UserModel loggedUser;
  final double width;
  final double height;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    bool userClicked = false;
    return StreamBuilder(
        stream: stream,
        builder: (ctx, userSnapshots) {
          //Connection-State-Waiting
          if (userSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //Snapshots has data
          else if (userSnapshots.hasData) {
            final snapshotLists = userSnapshots.data!.docs;
            if (snapshotLists.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    UserModel currentChatUser =
                        UserModel.fromMap(snapshotLists[index].data());

                    Future<String> lastMessage = FireStoreChatRoomDbFunc
                        .instance
                        .retrieveLastMessageIfExists(
                            user1: loggedUser, user2: currentChatUser);

                    Future<String> lastMessageTime = FireStoreChatRoomDbFunc
                        .instance
                        .retrieveLastMessageTimeIfExists(
                            user1: loggedUser, user2: currentChatUser);

                    if (currentChatUser.userId != loggedUser.userId) {
                      return //User-Widget
                          GestureDetector(
                        onTap: () async {
                          if (!userClicked) {
                            userClicked = true;
                            final result = await FireStoreChatRoomDbFunc
                                .instance
                                .createChatRoom(
                                    user1: loggedUser, user2: currentChatUser);
                            if (result is String) {
                              //Routing to chat screen
                              Navigator.of(scaffoldKey.currentContext!)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (ctx) => ScreenUserChat(
                                            chatuserName: currentChatUser.name,
                                            loggedUserName: loggedUser.name,
                                            chatRoomId: result,
                                          )));
                            } else {
                              //Error-creating/fetching-chat-room
                              showFirebaseErrorSnackBar(
                                  result, scaffoldKey.currentContext!);
                            }
                          }
                        },
                        //User-Box
                        child: SizedBox(
                            width: width,
                            height: height * 0.07,
                            child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset(
                                    maleAvatar,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Text(
                                  currentChatUser.name,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: MessageFutureBuilder(
                                  lastMessage: lastMessage,
                                  messgType: MessageType.message,
                                ),
                                trailing: MessageFutureBuilder(
                                  lastMessage: lastMessageTime,
                                  messgType: MessageType.messageTime,
                                ))),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return SizedBox(height: height * 0.01);
                  },
                  itemCount: snapshotLists.length);
            }
          }
          //No-Users
          return const Center(
            child: Text(
              'Ouch! No Users Found!',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xff492E87),
                  fontWeight: FontWeight.w600),
            ),
          );
        });
  }
}

class MessageFutureBuilder extends StatelessWidget {
  const MessageFutureBuilder(
      {super.key, required this.lastMessage, required this.messgType});

  final Future<String?> lastMessage;
  final MessageType messgType;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: lastMessage,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          if (snapshot.hasData) {
            //Fetched-Last-Message
            final String lastMessage = snapshot.data!;
            return (messgType == MessageType.message)
                //Last-Message-Text
                ? Text(
                    (lastMessage.isEmpty) ? 'Click to Chat' : lastMessage,
                    style:
                        const TextStyle(fontSize: 16.0, color: Colors.black45),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                //Last-Message-Time-Text
                : Text(
                    lastMessage.isEmpty ? '' : lastMessage,
                    style:
                        const TextStyle(fontSize: 14.0, color: Colors.black54),
                  );
          }

          return const Text('Click to Chat');
        });
  }
}
