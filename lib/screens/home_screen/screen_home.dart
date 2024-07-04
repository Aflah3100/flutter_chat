import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/screens/chat_screen/user_chat_screen.dart';
import 'package:flutter_chat/screens/home_screen/widgets/appbars.dart';
import 'package:flutter_chat/utils/utils.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key, required this.loggedUser});

  ValueNotifier<bool> searchNotifier = ValueNotifier(false);
  //LoggedIn-User-Details (UserModel Object)
  UserModel loggedUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: const Color(0xff492E87),

      appBar: ChatsAppBar(
          width: width, height: height, searchNotifer: searchNotifier),
      //Base-Container
      body: Container(
          padding: EdgeInsets.all(height * 0.02),
          margin: EdgeInsets.only(top: height * 0.01),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
          child: // ListView-Seperated
              ListView.separated(
                  itemBuilder: (ctx, index) {
                    return //Person-Container
                        GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                ScreenUserChat(userName: 'User ${index + 1}')));
                      },
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
                              'User ${index + 1}',
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              'Sample message $index',
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.black45),
                            ),
                            trailing: const Text(
                              '04:30',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black45),
                            ),
                          )),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemCount: 20)),
    );
  }
}
