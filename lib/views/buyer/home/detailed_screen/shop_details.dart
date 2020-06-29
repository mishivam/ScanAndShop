import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopDetails extends StatefulWidget {
  final Map shopData;
  ShopDetails(this.shopData);
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shopData["mallName"]),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.23),
                      offset: Offset(4, 4),
                      blurRadius: 22.0
                    )
                  ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "Contact No. of Mall:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["mallContactNo"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    ListTile(
                      title: Text(
                        "EmailId of Mall:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["mallEmailId"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    ListTile(
                      title: Text(
                        "Area of Mall:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["mallArea"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    ListTile(
                      title: Text(
                        "City of Mall:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["mallCity"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    ListTile(
                      title: Text(
                        "State of Mall:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["mallState"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    ListTile(
                      title: Text(
                        "Address of Mall:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["mallAddress"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.23),
                      offset: Offset(4, 4),
                      blurRadius: 22.0
                    )
                  ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "Name of Owner:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["ownerName"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    ListTile(
                      title: Text(
                        "EmailId of Owner:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["ownerEmailId"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    ListTile(
                      title: Text(
                        "Owner Contact No.:",
                        style: GoogleFonts.quicksand(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple
                        ),
                    ),
                    subtitle: Text(
                      widget.shopData["ownerContactNo"],
                      style: GoogleFonts.quicksand(
                          fontSize: 25.0,
                          // fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                    ),
                    ),
                    
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
