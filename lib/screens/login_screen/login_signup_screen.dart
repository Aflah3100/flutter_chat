import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/firebase_authentication/firebase_auth_functions.dart';
import 'package:flutter_chat/screens/home_screen/screen_home.dart';
import 'package:flutter_chat/utils/enums.dart';
import 'package:flutter_chat/utils/utils.dart';
import 'package:flutter_chat/utils/widget_functions.dart';

// ignore: must_be_immutable
class ScreenSigninSignup extends StatelessWidget {
  ScreenSigninSignup({super.key, required LoginType loginType})
      : loginNotifier = ValueNotifier(loginType);
  ValueNotifier<LoginType> loginNotifier;

  ValueNotifier<String> errorTextNotifier = ValueNotifier("");

  //Text-Field-Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Validate-UserDetails-Function
  dynamic validateUserDetails(
      {String? name,
      required String email,
      required String password,
      String? confPassword}) {
    if (name != null && name.isEmpty) {
      return "Enter name";
    } else if (email.isEmpty) {
      return "Enter email id";
    } else if (password.isEmpty) {
      return "Enter password";
    } else if (confPassword != null && confPassword.isEmpty) {
      return "Confirm entered password";
    } else if (name != null && (password.length < 8 || password.length > 15)) {
      return "Password must be of length 8-15";
    } else if (name != null && (password != confPassword)) {
      return "Passwords doesn't match";
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //Base-Stack-Widget
        child: Stack(
          children: [
            //Top-Container
            Container(
                padding: EdgeInsets.only(top: height * 0.03),
                height: height / 3.5,
                width: width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xff402E7A),
                    Color(0xff5356FF),
                    // Color(0xff378CE7),
                    // Color(0xff4B70F5),
                    // Color(0xff67C6E3),
                  ], begin: Alignment.centerLeft, end: Alignment.topRight),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(width, 100.0)),
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
                    })),

            //SignIn-SignUp-Base-Container
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: height * 0.22, horizontal: height * 0.03),
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),

                //Signin-Signup-Builder
                child: ValueListenableBuilder(
                    valueListenable: loginNotifier,
                    builder: (ctx, value, _) {
                      return //Sign-SignUp-Container
                          Container(
                        padding: EdgeInsets.all(height * 0.02),
                        width: width,
                        height: height * 0.53,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        //User-Details-Form
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Name-Text
                              (value == LoginType.singup)
                                  ? const Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Name-Text-Field
                              (value == LoginType.singup)
                                  ? Card(
                                      color: Colors.white,
                                      elevation: 4.0,
                                      child: TextFormField(
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
                                        validator: (name) =>
                                            (name == null || name.isEmpty)
                                                ? 'Enter User Name'
                                                : null,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                Icons.person_2_outlined),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 207, 197, 197))),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(height: height * 0.01),

                              //Email-Text
                              const Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Email-Text-Field
                              Card(
                                color: Colors.white,
                                elevation: 4.0,
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
                              SizedBox(
                                height: height * 0.01,
                              ),

                              //Password-Text
                              const Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Password-Text-Field
                              Card(
                                color: Colors.white,
                                elevation: 4.0,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (password) =>
                                      (password == null || password.isEmpty)
                                          ? 'Enter password'
                                          : null,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Icons.password_outlined),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 207, 197, 197))),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0))),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),

                              //Forgot-Password-Text
                              (value == LoginType.signin)
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.43),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  resetPasswordScreen);
                                        },
                                        child: const Text(
                                          'Forgot Password ?',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),

                              //Confirm-Password-Text
                              (value == LoginType.singup)
                                  ? const Text(
                                      'Confirm Password',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Confirm-Password-Text-Field
                              (value == LoginType.singup)
                                  ? Card(
                                      color: Colors.white,
                                      elevation: 4.0,
                                      child: TextFormField(
                                        controller: confirmPasswordController,
                                        obscureText: true,
                                        validator: (pass) =>
                                            (pass == null || pass.isEmpty)
                                                ? 'Confirm entered Password'
                                                : null,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                Icons.password_outlined),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 207, 197, 197))),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: height * 0.03,
                              ),

                              //Login-Button
                              (value == LoginType.signin)
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          dynamic result = validateUserDetails(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                          if (result is String) {
                                            errorTextNotifier.value = result;
                                          } else {
                                            errorTextNotifier.value = "";
                                            //Client-Side-User-Validation-Success
                                            dynamic authResult =
                                                await FirebaseAuthFunctions
                                                    .instance
                                                    .authenticateUserUsingEmail(
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text);
                                            if (authResult is User) {
                                              //User-Authentication-Success
                                              Navigator.of(scaffoldKey
                                                      .currentContext!)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              ScreenHome(
                                                                  loggedUser:
                                                                      authResult)));
                                            } else {
                                              showFirebaseErrorSnackBar(
                                                  authResult,
                                                  scaffoldKey.currentContext!);
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: width * 0.40,
                                          height: height * 0.06,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff4B70F5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: ((value == LoginType.signin))
                                    ? height * 0.03
                                    : null,
                              ),

                              //Login-SignUp-Text-Row
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (value == LoginType.singup)
                                          ? 'Already have an account?  '
                                          : 'Dont have an account?   ',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (loginNotifier.value ==
                                            LoginType.signin) {
                                          loginNotifier.value =
                                              LoginType.singup;
                                        } else {
                                          loginNotifier.value =
                                              LoginType.signin;
                                        }
                                      },
                                      child: Text(
                                        (value == LoginType.singup)
                                            ? 'Sign In Now! '
                                            : 'Sign Up Now! ',
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff4B70F5)),
                                      ),
                                    )
                                  ])
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),

            //Sign-Up-Button-Builder
            ValueListenableBuilder(
                valueListenable: loginNotifier,
                builder: (ctx, value, _) {
                  return //Sign-Up-Button
                      (value == LoginType.singup)
                          ? Positioned(
                              top: height * 0.80,
                              right: height * 0.03,
                              left: height * 0.04,
                              child: GestureDetector(
                                onTap: () async {
                                  dynamic result = validateUserDetails(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confPassword:
                                          confirmPasswordController.text);
                                  if (result is String) {
                                    errorTextNotifier.value = result;
                                  } else {
                                    errorTextNotifier.value = "";
                                    //Client-Side-User-Validation-Success
                                    UserModel user = UserModel(
                                        userId: null,
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                    dynamic authResult =
                                        await FirebaseAuthFunctions.instance
                                            .regitserUserUsingEmail(user: user);

                                    if (authResult is User) {
                                      //Registration Success
                                      Navigator.of(scaffoldKey.currentContext!)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (ctx) => ScreenHome(
                                                  loggedUser: authResult)));
                                    } else {
                                      //Registration-Failed
                                      showFirebaseErrorSnackBar(authResult,
                                          scaffoldKey.currentContext!);
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
                              ),
                            )
                          : const SizedBox();
                }),
            //Error-Text-Notifier
            ValueListenableBuilder(
                valueListenable: errorTextNotifier,
                builder: (ctx, errorText, _) {
                  return //Error-Text
                      Positioned(
                    top: height * 0.88,
                    child: Container(
                      width: width,
                      height: height * 0.05,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          errorText,
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
