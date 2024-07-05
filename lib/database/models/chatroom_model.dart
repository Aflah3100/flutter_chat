class ChatRoomModel {
  String chatRoomid;
  String chatUser1;
  String chatUser2;

  ChatRoomModel(
      {required this.chatRoomid,
      required this.chatUser1,
      required this.chatUser2});

  Map<String, dynamic> toMap() => {
        "chatroomid": chatRoomid,
        "chatuser1": chatUser1,
        "chatuser2": chatUser2
      };

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) => ChatRoomModel(
      chatRoomid: map["chatroomid"],
      chatUser1: map["chatuser1"],
      chatUser2: map["chatuser2"]);
}
