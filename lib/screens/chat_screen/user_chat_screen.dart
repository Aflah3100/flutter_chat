import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/chat_screen/widgets/message_widget.dart';

// ignore: must_be_immutable
class ScreenUserChat extends StatelessWidget {
  ScreenUserChat(
      {super.key, required this.chatuserName, required this.loggedUserName});
  String chatuserName, loggedUserName;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
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
            //User-Sent-Chat-Container
            SentMessageBox(height: height, width: width),

            //User-Received Chat Container
            RecievedMessageBox(height: height, width: width),
            const Spacer(),

            //Chat-Text-Field
            Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.03,
                      top: width * 0.02,
                      bottom: width * 0.01),
                  child: TextField(
                    maxLines: null,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter a Message',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () {},
                          //Send-Message-Icon
                          child: Container(
                            margin: EdgeInsets.only(right: width * 0.005),
                            padding: EdgeInsets.only(left: width * 0.006),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.black12),
                            child: const Icon(
                              Icons.send_rounded,
                              color: Color(0xff492E87),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
