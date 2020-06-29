import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future addUserToDatabase(String userId, Map userData) async {
    await Firestore.instance
        .collection("Buyers")
        .document(userId)
        .setData(userData);
  }
}
