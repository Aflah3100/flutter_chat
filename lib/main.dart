import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/login_screen/login_signup_screen.dart';
import 'package:flutter_chat/utils/enums.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff5356FF)),
        useMaterial3: true,
      ),
      home: ScreenSigninSignup(
        loginType: LoginType.signin,
      ),
    );
  }
}
