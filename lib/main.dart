import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/config/firebase_options.dart';
import 'package:flutter_chat/screens/forgot_password_screen/reset_password_screen.dart';
import 'package:flutter_chat/screens/home_screen/screen_home.dart';
import 'package:flutter_chat/screens/login_screen/login_signup_screen.dart';
import 'package:flutter_chat/utils/utils.dart';
import 'package:flutter_chat/utils/enums.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Loading env variables & connecting to firebase.
  await dotenv.load(fileName: environmentvariables);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter-Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff402E7A)),
          useMaterial3: true,
        ),
        routes: {
          signinScreen: (ctx) =>
              ScreenSigninSignup(loginType: LoginType.signin),
          signupScreen: (ctx) =>
              ScreenSigninSignup(loginType: LoginType.singup),
          resetPasswordScreen: (ctx) => ScreenResetPassword()
        },
        home: ScreenHome(
            loggedUser: UserModel(
                userId: 'dummy-user-id',
                name: 'dummy-name',
                email: 'dummy-email')));
  }
}
