import 'package:flutter/material.dart';
import 'package:shopping_app_background/services/authenticate/authentication.dart';
import 'package:shopping_app_background/views/login/login_home.dart';

class NearbyShopsScreen extends StatefulWidget {
  final String uid;
  NearbyShopsScreen(this.uid);
  @override
  _NearbyShopsScreenState createState() => _NearbyShopsScreenState();
}

class _NearbyShopsScreenState extends State<NearbyShopsScreen> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Shops"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await authServices.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginHome()));
            },
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
    );
  }
}
