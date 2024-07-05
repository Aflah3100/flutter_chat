import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/chat_message_model.dart';

//Send Message container widget
class SentMessageBox extends StatelessWidget {
  const SentMessageBox(
      {super.key,
      required this.height,
      required this.width,
      required this.messageModel});

  final double height;
  final double width;
  final ChatMessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: height * 0.02, right: height * 0.02, top: height * 0.02),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.only(left: width * 0.10),
          padding: EdgeInsets.all(height * 0.01),
          decoration: const BoxDecoration(
            color: Color(0xff7FC7D9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          child: Wrap(
            children: [
              Text(
                //Display-chat-message
                messageModel.message,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Recieved Message Container Widget
class RecievedMessageBox extends StatelessWidget {
  const RecievedMessageBox(
      {super.key,
      required this.height,
      required this.width,
      required this.messageModel});

  final double height;
  final double width;
  final ChatMessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: height * 0.01, right: height * 0.01, top: height * 0.01),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.only(right: width * 0.25),
          padding: EdgeInsets.all(height * 0.01),
          decoration: const BoxDecoration(
            color: Color(0xff67C6E3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Wrap(
            children: [
              Text(
                //Display-chat-message
                messageModel.message,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
