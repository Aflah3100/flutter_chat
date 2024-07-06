import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_userdb_functions.dart';
import 'package:flutter_chat/screens/home_screen/widgets/appbars.dart';
import 'package:flutter_chat/screens/home_screen/widgets/fetch_users_stream_builder.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key, required this.loggedUser});

  //Controllers
  TextEditingController searchController = TextEditingController();

  //Search-Notifier
  ValueNotifier<bool> searchNotifier = ValueNotifier(false);

  //LoggedIn-User-Details (UserModel Object)
  UserModel loggedUser;

  //Keys
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xff492E87),
        appBar: ChatsAppBar(
          width: width,
          height: height,
          searchNotifer: searchNotifier,
          searchController: searchController,
          scaffoldKey: scaffoldKey,
        ),
        //Base-Container
        body: Container(
          padding: EdgeInsets.all(height * 0.02),
          margin: EdgeInsets.only(top: height * 0.01),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
          //User-Builder
          child: ValueListenableBuilder(
              valueListenable: searchNotifier,
              builder: (ctx, val, _) {
                if (val) {
                  return FetchUsersStreamBuilder(
                    loggedUser: loggedUser,
                    width: width,
                    height: height,
                    stream: FirestoreUserDbFunc.instance
                        .fetchUsersbySubstring(searchController.text),
                    scaffoldKey: scaffoldKey,
                  );
                } else {
                  return FetchUsersStreamBuilder(
                    loggedUser: loggedUser,
                    width: width,
                    height: height,
                    stream: FirestoreUserDbFunc.instance.fetchAllUsers(),
                    scaffoldKey: scaffoldKey,
                  );
                }
              }),
        ));
  }
}
