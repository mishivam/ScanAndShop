// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/services/authenticate/authentication.dart';
import 'package:shopping_app_background/services/database/database_services.dart';
import 'package:shopping_app_background/views/buyer/home/detailed_screen/shop_details.dart';
import 'package:shopping_app_background/views/login/login_home.dart';

class NearbyShopsScreen extends StatefulWidget {
  final String uid;
  NearbyShopsScreen(this.uid);
  @override
  _NearbyShopsScreenState createState() => _NearbyShopsScreenState();
}

class _NearbyShopsScreenState extends State<NearbyShopsScreen> {
  Stream shopsDataStream;
  DatabaseServices databaseServices = DatabaseServices();
  getAllData() async {
    await databaseServices.getAllShopData().then((value) {
      setState(() {
        shopsDataStream = value;
      });
    });
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Shops"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await authServices.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginHome()));
            },
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
      body: StreamBuilder(
          stream: shopsDataStream,
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Map<String, String> dataToBeForwarded = {
                              "ownerName": snapshot.data.documents[index].data["ownerName"],
                              "ownerEmailId": snapshot.data.documents[index].data["ownerEmailId"],
                              "ownerContactNo": snapshot.data.documents[index].data["ownerContactNo"],
                              "mallName": snapshot.data.documents[index].data["mallName"],
                              "mallContactNo": snapshot.data.documents[index].data["mallContactNo"],
                              "mallEmailId": snapshot.data.documents[index].data["mallEmailId"],
                              "mallArea": snapshot.data.documents[index].data["mallArea"],
                              "mallCity": snapshot.data.documents[index].data["mallCity"],
                              "mallState": snapshot.data.documents[index].data["mallState"],
                              "mallAddress": snapshot.data.documents[index].data["mallAddress"],
                            };
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ShopDetails(
                                  dataToBeForwarded
                                )));
                          },
                          child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.5),
                                      offset: Offset(4, 4),
                                      blurRadius: 22.0)
                                ]),
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      "${snapshot.data.documents[index].data["mallName"]}\n",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                  children: [
                                    TextSpan(
                                      text:
                                          "\nCity: ${snapshot.data.documents[index].data["mallCity"]}",
                                      style: GoogleFonts.quicksand(
                                          fontSize: 20.0,
                                          // fontWeight: FontWeight.w600,
                                          color: Colors.deepPurple),
                                    ),
                                    TextSpan(
                                      text:
                                          "\nState: ${snapshot.data.documents[index].data["mallState"]}",
                                      style: GoogleFonts.quicksand(
                                          fontSize: 20.0,
                                          // fontWeight: FontWeight.w600,
                                          color: Colors.deepPurple),
                                    ),
                                  ]),
                            ),
                            margin: EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              top: 10,
                            ),
                          ),
                        ));
          }),
    );
  }
}
