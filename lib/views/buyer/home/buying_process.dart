import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/services/authenticate/authentication.dart';
import 'package:shopping_app_background/views/buyer/barcode_result_screen/barcode_result_screen.dart';
import 'package:shopping_app_background/views/login/login_home.dart';

class BuyingScreen extends StatefulWidget {
  final String uid;
  BuyingScreen(this.uid);
  @override
  _BuyingScreenState createState() => _BuyingScreenState();
}

class _BuyingScreenState extends State<BuyingScreen> {
  String opString = "";
  AuthServices authServices = AuthServices();
  Future<String> qrScan() async {
    var value = await BarcodeScanner.scan();
    return value.rawContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanning"),
        // centerTitle: true,
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
      body: InkWell(
        onTap: () async {
          opString = await qrScan();
          if (opString.length > 0) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BarcodeResult(opString)));
          }
        },
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/qr_code_scanner-24px.svg",
                  height: 120.0,
                  width: 120.0,
                  color: Colors.grey.withOpacity(0.75),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Tap On the Screen\nto Initiate the Shopping Process",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.withOpacity(0.75)),
                ),
              ],
            ),
          ),
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //     icon: Icon(Icons.camera),
      //     onPressed: () async {
      //       opString = await qrScan();
      //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => BarcodeResult(opString)));
      //     },
      //     label: Text("Scan QR")),
    );
  }
}
