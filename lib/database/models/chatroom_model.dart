
//chat room model -> creating chat rooms for 2 users
class ChatRoomModel {
  String chatRoomid;
  String chatUser1;
  String chatUser2;
  String? lastMessageId;
  String? lastMessage;
  String? lastMessageTime;

  ChatRoomModel(
      {required this.chatRoomid,
      required this.chatUser1,
      required this.chatUser2,
      this.lastMessage,
      this.lastMessageTime,
      this.lastMessageId});

  Map<String, dynamic> toMap() => {
        "chatroomid": chatRoomid,
        "chatuser1": chatUser1,
        "chatuser2": chatUser2,
        "lastmessageid": lastMessageId ?? '',
        "lastmessage": lastMessage ?? '',
        "lastmessagetime": lastMessageTime ?? ''
      };

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) => ChatRoomModel(
        chatRoomid: map["chatroomid"],
        chatUser1: map["chatuser1"],
        chatUser2: map["chatuser2"],
      );
}
