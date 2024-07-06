import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_chat/database/models/chat_message_model.dart';
import 'package:flutter_chat/database/models/chatroom_model.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_collections.dart';

class FireStoreChatRoomDbFunc {
  //Singleton
  FireStoreChatRoomDbFunc._internal();
  static FireStoreChatRoomDbFunc instance = FireStoreChatRoomDbFunc._internal();
  factory FireStoreChatRoomDbFunc() => instance;

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

  //Save message/chat to firestore
  Future<dynamic> saveMessagetoChatRoom(
      {required ChatMessageModel messageModel,
      required String chatRoomId}) async {
    try {
      await FirebaseFirestore.instance
          .collection(chatRoomsCollection)
          .doc(chatRoomId)
          .collection(chatsCollection)
          .doc(messageModel.messgId)
          .set(messageModel.toMap());
      //Update last message
      await _updateLastMessage(
          chatRoomId: chatRoomId,
          lastMessage: messageModel.message,
          lastMessgeTime: messageModel.timeStamp);

      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Fetch all messages from chatRoom
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchChatRoomChats(
      {required chatRoomId}) {
    return FirebaseFirestore.instance
        .collection(chatRoomsCollection)
        .doc(chatRoomId)
        .collection(chatsCollection)
        .orderBy('servertimestamp', descending: false)
        .snapshots();
  }

  //Update last message details in ChatRoom
  Future<dynamic> _updateLastMessage({
    required String chatRoomId,
    required String lastMessage,
    required String lastMessgeTime,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(chatRoomsCollection)
          .doc(chatRoomId)
          .update(
              {"lastmessage": lastMessage, "lastmessagetime": lastMessgeTime});

      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Retieve last message if chat room exists
  Future<String> retrieveLastMessageIfExists(
      {required UserModel user1, required UserModel user2}) async {
    final chatRoomId = _createChatRoomId(user1: user1, user2: user2);
    final chatRoomSnapshot = await FirebaseFirestore.instance
        .collection(chatRoomsCollection)
        .doc(chatRoomId)
        .get();
    if (chatRoomSnapshot.exists) {
      return chatRoomSnapshot.data()?['lastmessage'];
    } else {
      return '';
    }
  }

  //Retieve last message time if chat room exists
  Future<String> retrieveLastMessageTimeIfExists(
      {required UserModel user1, required UserModel user2}) async {
    final chatRoomId = _createChatRoomId(user1: user1, user2: user2);
    final chatRoomSnapshot = await FirebaseFirestore.instance
        .collection(chatRoomsCollection)
        .doc(chatRoomId)
        .get();
    if (chatRoomSnapshot.exists) {
      return chatRoomSnapshot.data()?['lastmessagetime'];
    } else {
      return '';
    }
  }

  //Delete a message from the chatroom
  Future<dynamic> deleteMessage(
      {required String chatRoomId, required String messgId}) async {
    try {
      await FirebaseFirestore.instance
          .collection(chatRoomsCollection)
          .doc(chatRoomId)
          .collection(chatsCollection)
          .doc(messgId)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }
}
