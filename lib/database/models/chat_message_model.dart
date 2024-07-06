import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  String messgId;
  String message;
  String sendBy;
  String timeStamp;
  Timestamp serverTimeStamp;

  ChatMessageModel(
      {required this.messgId,
      required this.message,
      required this.sendBy,
      required this.timeStamp,
      required this.serverTimeStamp});

  Map<String, dynamic> toMap() => {
        "messageid": messgId,
        "message": message,
        "sendby": sendBy,
        "timestamp": timeStamp,
        "servertimestamp": serverTimeStamp
      };
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) =>
      ChatMessageModel(
          messgId: map['messageid'],
          message: map['message'],
          sendBy: map['sendby'],
          timeStamp: map['timestamp'],
          serverTimeStamp: map['servertimestamp']);
}
