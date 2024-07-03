import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/utils/firestore_collections.dart';

class FirebaseAuthFunctions {
  //Singleton
  FirebaseAuthFunctions._internal();
  static FirebaseAuthFunctions instance = FirebaseAuthFunctions._internal();
  factory FirebaseAuthFunctions() => instance;

  //Registering new user and save details to firestore.
  Future<dynamic> regitserUserUsingEmail({required UserModel user}) async {
    try {
      //Authenticating new user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      User? currentUser = userCredential.user;

      if (currentUser != null) {
        await FirebaseAuth.instance.currentUser!
            .updateProfile(displayName: user.name);
        await currentUser.reload();

        user.userId = currentUser.uid;

        //Save-data-to-firebase
        await FirebaseFirestore.instance
            .collection(userCollections)
            .doc(user.userId)
            .set(user.toMap());
        return currentUser;
      } else {
        return FirebaseAuthException(code: "Error Registering New User!");
      }
    } on FirebaseException catch (e) {
      return e;
    }
  }

  //Signin user using email
  Future<dynamic> authenticateUserUsingEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? currentUser = userCredential.user;

      if (currentUser != null) {
        return currentUser;
      } else {
        return FirebaseAuthException(code: "Error Signing In!");
      }
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  //Reset-Password-By-Registered-Email-Address
  Future<dynamic> resetPasswordUsingEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }
}
