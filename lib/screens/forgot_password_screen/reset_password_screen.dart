import 'package:flutter/material.dart';
import 'package:flutter_chat/firebase/firebase_authentication/firebase_auth_functions.dart';
import 'package:flutter_chat/utils/utils.dart';
import 'package:flutter_chat/utils/widget_functions.dart';


//ScreenResetPassword -> For resetting password using reset link
// ignore: must_be_immutable
class ScreenResetPassword extends StatelessWidget {
  ScreenResetPassword({super.key});

  //Notifier
  ValueNotifier<bool> resetNotifier = ValueNotifier(false);
  ValueNotifier<bool> emailNotifier = ValueNotifier(false);

  //Controllers
  final emailController = TextEditingController();

  //Keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      //Base-Stack
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //Top-Container
            Container(
              width: width,
              height: height * 0.50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff402E7A),
                        Color(0xff5356FF),
                        // Color(0xff378CE7),
                        // Color(0xff4B70F5),
                        // Color(0xff67C6E3),
                      ]),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(width, 150))),
              //Top-Text-Column
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reset Your Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Enter Your Registered email id',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),

            //Form-Container
            Container(
              margin: EdgeInsets.only(
                  top: height * 0.37, left: width * 0.05, right: width * 0.05),
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.all(height * 0.02),
                  width: width,
                  height: height * 0.40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Email-Text
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      //Email-Text-Field-Builder
                      ValueListenableBuilder(
                          valueListenable: emailNotifier,
                          builder: (ctx, val, _) {
                            return Card(
                              color: Colors.white,
                              elevation: 4.0,
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) =>
                                      (email == null || email.isEmpty)
                                          ? 'Enter email address'
                                          : null,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 207, 197, 197))),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: height * 0.05,
                      ),

                      //Reset-Password-Button
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            dynamic result = await FirebaseAuthFunctions
                                .instance
                                .resetPasswordUsingEmail(
                                    email: emailController.text);
                            if (result is bool) {
                              //Reset-Link-Sent
                              resetNotifier.value = true;
                              emailController.text = "";
                              emailNotifier.value = !emailNotifier.value;
                            } else {
                              //Error
                              showFirebaseErrorSnackBar(
                                  result, scaffoldKey.currentContext!);
                            }
                          }
                        },
                        child: Center(
                          child: Container(
                            width: width * 0.40,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              color: const Color(0xff4B70F5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Text(
                                'Send Reset Link',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),

                      //Signin-Page-Text-Row
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?  ',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .popAndPushNamed(signinScreen);
                              },
                              child: const Text(
                                'Sign In Now! ',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff378CE7)),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: height * 0.05,
                      ),

                      //Reset-Notification-Text-Builder
                      ValueListenableBuilder(
                          valueListenable: resetNotifier,
                          builder: (ctx, val, _) {
                            return Center(
                              child: Text(
                                (val)
                                    ? 'Reset link sent to email if Registered'
                                    : "",
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff26355D)),
                              ),
                            );
                          })
                    ],
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
