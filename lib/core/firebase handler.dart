import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
class FirebaseHandler{
  Future<bool> isUserExistsInFirestore() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final doc = await FirebaseFirestore.instance
        .collection('users').doc(user.uid).get();

    return doc.exists;
  }

  static String hash(String password) {
  final bytes = utf8.encode(password + "_demo_salt");
  return sha256.convert(bytes).toString();
  }
}