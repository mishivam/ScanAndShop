import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future addUserToDatabase(String userId, Map userData) async {
    await Firestore.instance
        .collection("Buyers")
        .document(userId)
        .setData(userData);
  }

  Future addMallToDatabase(String userId, Map mallData) async {
    await Firestore.instance
        .collection("Shopkeepers")
        .document(userId)
        .setData(mallData);
  }

  Future addMallToCommonDatabase(String userId, Map mallData) async {
    await Firestore.instance
        .collection("GeneralShopData")
        .document(userId)
        .setData(mallData);
  }

  getAllShopData() async {
    return (await Firestore.instance.collection("GeneralShopData").snapshots());
  }
}
