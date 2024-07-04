import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/utils/firestore_collections.dart';

class FireStoreFunctions {
//Singleton
  FireStoreFunctions._internal();
  static FireStoreFunctions instance = FireStoreFunctions._internal();
  factory FireStoreFunctions() => instance;

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
