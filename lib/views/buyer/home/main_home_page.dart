import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/views/buyer/home/buying_process.dart';

import 'package:shopping_app_background/views/buyer/home/nearby_shops.dart';

class MainHome extends StatefulWidget {
  final String uid;
  MainHome(this.uid);
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    print(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: tabController,
          children: [
            NearbyShopsScreen(widget.uid), 
            BuyingScreen(widget.uid)]),
      bottomNavigationBar: TabBar(
          controller: tabController,
          
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          labelStyle: GoogleFonts.quicksand(
            fontSize: 15.0,
          ),
          tabs: [
            Tab(
              icon: Icon(Icons.shopping_basket),
              text: "Nearby Shops",
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
              text: "Start Buying",
            )
          ]),
    );
  }
}
