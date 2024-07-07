import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/database/models/user_model.dart';
import 'package:flutter_chat/firebase/firestore/firestore_collections.dart';


//FirebaseAuthFunctions class -> authentication functions for authenticating users 
class FirebaseAuthFunctions {
  //Singleton
  FirebaseAuthFunctions._internal();
  static FirebaseAuthFunctions instance = FirebaseAuthFunctions._internal();
  factory FirebaseAuthFunctions() => instance;

  //Registering new user and save details to firestore.
  Future<dynamic> regitserUserUsingEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      //Authenticating new user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? currentUser = userCredential.user;

      if (currentUser != null) {
        await FirebaseAuth.instance.currentUser!
            .updateProfile(displayName: name);
        await currentUser.reload();
        //Creating-User-Model
        UserModel userModel =
            UserModel(userId: currentUser.uid, name: name, email: email);

        //Save-data-to-firebase
        await FirebaseFirestore.instance
            .collection(userCollections)
            .doc(userModel.userId)
            .set(userModel.toMap());
        return userModel;
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
        //Creating-User-Model
        UserModel userModel = UserModel(
            userId: currentUser.uid,
            name: currentUser.displayName!,
            email: email);
        return userModel;
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

  //Sign-Out-User from firebase
  Future<dynamic> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseException catch (e) {
      return e;
    }
  }
}
