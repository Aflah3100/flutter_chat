import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenUserChat extends StatelessWidget {
  ScreenUserChat({super.key, required this.userName});
  String userName;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: const Color(0xff492E87),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          userName,
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
            Padding(
              padding: EdgeInsets.all(height * 0.02),
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
                  child: const Wrap(
                    children: [
                      Text(
                        'Hi, How are you? How\'s the day',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //User-Received Chat Container
            Padding(
              padding: EdgeInsets.all(height * 0.01),
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
                  child: const Wrap(
                    children: [
                      Text(
                        'Iam fine. What about you',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
