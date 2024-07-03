import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController showFirebaseErrorSnackBar(
    FirebaseException e, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      dismissDirection: DismissDirection.down,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          e.code,
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      )));
}
