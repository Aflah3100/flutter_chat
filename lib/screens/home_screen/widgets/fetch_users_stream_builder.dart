import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/screens/chat_screen/user_chat_screen.dart';
import 'package:flutter_chat/utils/utils.dart';

class FetchUsersStreamBuilder extends StatelessWidget {
  const FetchUsersStreamBuilder(
      {super.key,
      required this.loggedUser,
      required this.width,
      required this.height,
      required this.stream});

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final UserModel loggedUser;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (ctx, userSnapshots) {
          //Connection-State-Waiting
          if (userSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //Snapshots has data
          else if (userSnapshots.hasData) {
            final snapshotLists = userSnapshots.data!.docs;
            if (snapshotLists.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    UserModel currentUser =
                        UserModel.fromMap(snapshotLists[index].data());
                    if (currentUser.userId != loggedUser.userId) {
                      return //User-Widget
                          GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  ScreenUserChat(userName: currentUser.name)));
                        },
                        //User-Box
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
                                currentUser.name,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
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
                    } else {
                      return const SizedBox();
                    }
                  },
                  separatorBuilder: (ctx, index) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemCount: snapshotLists.length);
            }
          }
          //No-Users
          return const Center(
            child: Text(
              'Ouch! No Users Found!',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xff492E87),
                  fontWeight: FontWeight.w600),
            ),
          );
        });
  }
}
