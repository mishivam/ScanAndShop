import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shopping_app_background/views/buyer/home/buying_process.dart';
import 'package:shopping_app_background/views/buyer/home/main_home_page.dart';
import 'package:shopping_app_background/views/login/login_home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  decideNextScreen() async {
    await auth.currentUser().then((value) {
      if (value != null) {
        Future.delayed(
            Duration(milliseconds: 225),
            () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainHome(value.uid))));
      } else {
        Future.delayed(
            Duration(
              milliseconds: 225,
            ),
            () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginHome())));
      }
    });
  }

  @override
  void initState() {
    decideNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue[200]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100.0,
                child: Icon(
                  Icons.shopping_cart,
                  size: 100.0,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "ShopApp",
                style: GoogleFonts.quicksand(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
