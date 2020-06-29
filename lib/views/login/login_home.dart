import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/views/login/buyer.dart';
import 'package:shopping_app_background/views/login/shopkeeper.dart';

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          BuyerLogin(),
          ShopkeeperLogin()
        ]),
      bottomNavigationBar: TabBar(
        controller: tabController,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.blueAccent,
        labelStyle: GoogleFonts.quicksand(
          fontSize: 15.0,
        
        ),
        tabs: [
          Tab(
            icon: Icon(Icons.person),
            text: "Buyer",
          ),
          Tab(
            icon: Icon(Icons.shopping_cart),
            text: "ShopKeeper",
          )
        ]),
    );
  }
}
