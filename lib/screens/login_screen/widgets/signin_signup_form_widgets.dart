// ignore_for_file: must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/firebase_authentication/firebase_auth_functions.dart';
import 'package:flutter_chat/screens/home_screen/screen_home.dart';
import 'package:flutter_chat/services/shared_preferences/shared_prefs.dart';
import 'package:flutter_chat/utils/enums.dart';
import 'package:flutter_chat/utils/utils.dart';
import 'package:flutter_chat/utils/widget_functions.dart';

//Text widget for displaying text
class SignInSignUpText extends StatelessWidget {
  SignInSignUpText({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }
}

//Text form field widget for collecting user info
class SignInSignUpTextFormField extends StatelessWidget {
  const SignInSignUpTextFormField(
      {super.key,
      required this.controller,
      required this.formIcon,
      required this.obscureText});

  final TextEditingController controller;
  final IconData formIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(formIcon),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 207, 197, 197))),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}

//Text button for routing to forgot password screen
class ForgotPasswordTextButton extends StatelessWidget {
  const ForgotPasswordTextButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.43),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(resetPasswordScreen);
        },
        child: const Text(
          'Forgot Password ?',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

//Text for routing b/w signin and signup
class SignSignUpTextRow extends StatelessWidget {
  const SignSignUpTextRow({
    super.key,
    required this.loginNotifier,
  });

  final ValueNotifier<LoginType> loginNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        (loginNotifier.value == LoginType.singup)
            ? 'Already have an account?  '
            : 'Dont have an account?   ',
        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
      ),
      GestureDetector(
        onTap: () {
          if (loginNotifier.value == LoginType.signin) {
            loginNotifier.value = LoginType.singup;
          } else {
            loginNotifier.value = LoginType.signin;
          }
        },
        child: Text(
          (loginNotifier.value == LoginType.singup)
              ? 'Sign In Now! '
              : 'Sign Up Now! ',
          style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff4B70F5)),
        ),
      )
    ]);
  }
}

//Signin existing user button widget
class SignInButton extends StatelessWidget {
  SignInButton(
      {super.key,
      required this.width,
      required this.height,
      required this.validateUserDetails,
      required this.emailController,
      required this.passwordController,
      required this.errorTextNotifier,
      required this.scaffoldKey});

  final double width;
  final double height;
  Function validateUserDetails;
  TextEditingController emailController;
  TextEditingController passwordController;
  ValueNotifier<String> errorTextNotifier;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        dynamic result = validateUserDetails(
            email: emailController.text, password: passwordController.text);
        if (result is String) {
          errorTextNotifier.value = result;
        } else {
          errorTextNotifier.value = "";
          //Client-Side-User-Validation-Success
          dynamic authResult = await FirebaseAuthFunctions.instance
              .authenticateUserUsingEmail(
                  email: emailController.text,
                  password: passwordController.text);

          if (authResult is UserModel) {
            //User-Authentication-Success

            //Creating Shared Preferences
            SharedPrefs.instance.saveUserModel(user: authResult);

            Navigator.of(scaffoldKey.currentContext!).pushReplacement(
                MaterialPageRoute(
                    builder: (ctx) => ScreenHome(loggedUser: authResult)));
          } else {
            showFirebaseErrorSnackBar(authResult, scaffoldKey.currentContext!);
          }
        }
      },
      child: Container(
        width: width * 0.40,
        height: height * 0.06,
        decoration: BoxDecoration(
          color: const Color(0xff4B70F5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

//Signup new user button widget
class SignUpButton extends StatelessWidget {
  SignUpButton(
      {super.key,
      required this.width,
      required this.height,
      required this.validateUserDetails,
      required this.nameController,
      required this.confirmPasswordController,
      required this.emailController,
      required this.passwordController,
      required this.errorTextNotifier,
      required this.scaffoldKey});

  final double width;
  final double height;
  Function validateUserDetails;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  ValueNotifier<String> errorTextNotifier;

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        dynamic result = validateUserDetails(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          confPassword: confirmPasswordController.text,
        );
        if (result is String) {
          errorTextNotifier.value = result;
        } else {
          errorTextNotifier.value = "";
          //Client-Side-User-Validation-Success

          dynamic authResult = await FirebaseAuthFunctions.instance
              .regitserUserUsingEmail(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text);

          if (authResult is UserModel) {
            //Registration Success

            //Creating Shared Preferences
            SharedPrefs.instance.saveUserModel(user: authResult);

            Navigator.of(scaffoldKey.currentContext!).pushReplacement(
                MaterialPageRoute(
                    builder: (ctx) => ScreenHome(loggedUser: authResult)));
          } else {
            //Registration-Failed
            showFirebaseErrorSnackBar(authResult, scaffoldKey.currentContext!);
          }
        }
      },
      child: Container(
        width: width,
        height: height * 0.07,
        decoration: BoxDecoration(
          color: const Color(0xff4B70F5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Center(
          child: Text(
            'SIGN UP',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
