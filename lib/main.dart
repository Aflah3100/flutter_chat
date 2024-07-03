import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/firebase/firebase_options.dart';
import 'package:flutter_chat/screens/home_screen/screen_home.dart';
import 'package:flutter_chat/utils/assets.dart';
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
      home: const ScreenHome(),
    );
  }
}
