import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/firebase/firestore/firestore_collections.dart';

class FirestoreUserDbFunc {

  //Singleton
  FirestoreUserDbFunc._internal();
  static FirestoreUserDbFunc instance = FirestoreUserDbFunc._internal();
  factory FirestoreUserDbFunc() => instance;


  //Fetch all users from database
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
    return FirebaseFirestore.instance.collection(userCollections).snapshots();
  }

  //Fethcing users by substring -> for searching users

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUsersbySubstring(
      String str) {
    return FirebaseFirestore.instance
        .collection(userCollections)
        .where('name', isGreaterThanOrEqualTo: str)
        .where('name', isLessThanOrEqualTo: '$str\uf8ff')
        .snapshots();
  }
}
