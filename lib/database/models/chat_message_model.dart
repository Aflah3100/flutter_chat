class ChatMessageModel {
  String message;
  String sendBy;
  String timeStamp;
  String serverTimeStamp;

  ChatMessageModel(
      {required this.message,
      required this.sendBy,
      required this.timeStamp,
      required this.serverTimeStamp});

  Map<String, dynamic> toMap() => {
        "message": message,
        "sendby": sendBy,
        "timestamp": timeStamp,
        "servertimestamp": serverTimeStamp
      };
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) =>
      ChatMessageModel(
          message: map['message'],
          sendBy: map['sendby'],
          timeStamp: map['timestamp'],
          serverTimeStamp: map['servertimestamp']);
}
