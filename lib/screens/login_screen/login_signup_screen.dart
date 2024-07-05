import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/login_screen/widgets/signin_signup_form_widgets.dart';
import 'package:flutter_chat/screens/login_screen/widgets/top_container.dart';
import 'package:flutter_chat/utils/enums.dart';

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
  dynamic validateUserDetails({
    String? name,
    required String email,
    required String password,
    String? confPassword,
  }) {
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
            LinearTopContainer(
                height: height, width: width, loginNotifier: loginNotifier),

            //SignIn-SignUp-Base-Container
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: height * 0.26, horizontal: height * 0.03),
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
                        height: height * 0.58,
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
                                  ? SignInSignUpText(
                                      text: 'Name',
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Name-Text-Field
                              (value == LoginType.singup)
                                  ? SignInSignUpTextFormField(
                                      controller: nameController,
                                      formIcon: Icons.person_2_outlined,
                                      obscureText: false,
                                    )
                                  : const SizedBox(),
                              SizedBox(height: height * 0.01),

                              //Email-Text
                              SignInSignUpText(text: 'Email'),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Email-Text-Field
                              SignInSignUpTextFormField(
                                controller: emailController,
                                formIcon: Icons.email_outlined,
                                obscureText: false,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),

                              //Password-Text
                              SignInSignUpText(text: 'Password'),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Password-Text-Field
                              SignInSignUpTextFormField(
                                controller: passwordController,
                                formIcon: Icons.password_outlined,
                                obscureText: true,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),

                              //Forgot-Password-Text
                              (value == LoginType.signin)
                                  ? ForgotPasswordTextButton(width: width)
                                  : const SizedBox(),

                              //Confirm-Password-Text
                              (value == LoginType.singup)
                                  ? SignInSignUpText(text: 'Confirm Password')
                                  : const SizedBox(),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              //Confirm-Password-Text-Field
                              (value == LoginType.singup)
                                  ? SignInSignUpTextFormField(
                                      controller: confirmPasswordController,
                                      formIcon: Icons.password_outlined,
                                      obscureText: true,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: height * 0.03,
                              ),

                              //Login-Button
                              (value == LoginType.signin)
                                  ? Center(
                                      child: SignInButton(
                                        width: width,
                                        height: height,
                                        validateUserDetails:
                                            validateUserDetails,
                                        emailController: emailController,
                                        passwordController: passwordController,
                                        errorTextNotifier: errorTextNotifier,
                                        scaffoldKey: scaffoldKey,
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: ((value == LoginType.signin))
                                    ? height * 0.03
                                    : null,
                              ),

                              //Login-SignUp-Text-Row
                              SignSignUpTextRow(loginNotifier: loginNotifier)
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
                              top: height * 0.86,
                              right: height * 0.03,
                              left: height * 0.04,
                              child: SignUpButton(
                                  width: width,
                                  height: height,
                                  validateUserDetails: validateUserDetails,
                                  nameController: nameController,
                                  confirmPasswordController:
                                      confirmPasswordController,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                  errorTextNotifier: errorTextNotifier,
                                  scaffoldKey: scaffoldKey))
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
