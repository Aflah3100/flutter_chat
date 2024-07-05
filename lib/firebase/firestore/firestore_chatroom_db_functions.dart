import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_chat/database/models/chatroom_model.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_collections.dart';

class ChatRoomDbFunc {
  //Singleton
  ChatRoomDbFunc._internal();
  static ChatRoomDbFunc instance = ChatRoomDbFunc._internal();
  factory ChatRoomDbFunc() => instance;

  //Create chat room id for 2 users
  String _createChatRoomId(
      {required UserModel user1, required UserModel user2}) {
    List<String> users = [
      "${user1.name}${user1.userId}",
      "${user2.name}${user2.userId}"
    ];

    users.sort();

    String concatenatedUserId = users.join("_");

    //Generating SH6 HASH
    var bytes = utf8.encode(concatenatedUserId);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }

  //Create chat room for 2 users

  Future<dynamic> createChatRoom(
      {required UserModel user1, required UserModel user2}) async {
    try {
      String chatRoomId = _createChatRoomId(user1: user1, user2: user2);

      final chatRoomSnapshot = await FirebaseFirestore.instance
          .collection(chatRoomsCollection)
          .doc(chatRoomId)
          .get();

      if (chatRoomSnapshot.exists) {
        return chatRoomId;
      } else {
        ChatRoomModel chatRoomModel = ChatRoomModel(
            chatRoomid: chatRoomId,
            chatUser1: user1.name,
            chatUser2: user2.name);
        await FirebaseFirestore.instance
            .collection(chatRoomsCollection)
            .doc(chatRoomId)
            .set(chatRoomModel.toMap());

        return chatRoomId;
      }
    } on FirebaseException catch (e) {
      return e;
    }
  }
}
