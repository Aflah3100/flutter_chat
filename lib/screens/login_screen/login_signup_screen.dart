import 'package:flutter/material.dart';

class ScreenSigninSignup extends StatelessWidget {
  const ScreenSigninSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
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
                  Color(0xff5356FF),
                  Color(0xff378CE7),
                  // Color(0xff4B70F5),
                  // Color(0xff67C6E3),
                ], begin: Alignment.centerLeft, end: Alignment.topRight),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(width, 100.0)),
              ),
              //Top-Text-Column
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Create a new Account',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),

            //SignIn-SignUp-Base-Container
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: height * 0.22, horizontal: height * 0.03),
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),

                //Sign-SignUp-Container
                child: Container(
                  padding: EdgeInsets.all(height * 0.02),
                  width: width,
                  height: height * 0.53,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Name-Text
                      const Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      //Name-Text-Field
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person_2_outlined),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 207, 197, 197))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      SizedBox(height: height * 0.01),

                      //Email-Text
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      //Email-Text-Field
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 207, 197, 197))),
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
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      //Password-Text-Field
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password_outlined),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 207, 197, 197))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      //Confirm-Password-Text
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      //Confirm-Password-Text-Field
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password_outlined),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 207, 197, 197))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),

                      //Login-SignUp-Text-Row
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
                              onTap: () {},
                              child: const Text(
                                'Sign In Now! ',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4B70F5)),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),

            //Sign-Up-Button
            Positioned(
              top: height * 0.80,
              right: height * 0.03,
              left: height * 0.04,
              child: GestureDetector(
                onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
