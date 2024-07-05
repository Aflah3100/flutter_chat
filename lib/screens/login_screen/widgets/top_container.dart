import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/enums.dart';

//Widget used for building top portion of signin signup screen.
class LinearTopContainer extends StatelessWidget {
  const LinearTopContainer({
    super.key,
    required this.height,
    required this.width,
    required this.loginNotifier,
  });

  final double height;
  final double width;
  final ValueNotifier<LoginType> loginNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: height * 0.03),
        height: height / 3,
        width: width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xff4A249D),
            Color(0xFF640D6B),
            // Color(0xff26355D),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(width, 100.0)),
        ),

        //Top-Text-Builder
        child: ValueListenableBuilder(
            valueListenable: loginNotifier,
            builder: (ctx, value, _) {
              //Top-Text-Column
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (value == LoginType.singup) ? 'Sign Up' : 'Log In',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    (value == LoginType.singup)
                        ? 'Create a new Account'
                        : 'SignIn to Your Account',
                    style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              );
            }));
  }
}
