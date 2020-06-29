import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/views/shopKeeper/registration/part1.dart';

class ShopkeeperLogin extends StatefulWidget {
  @override
  _ShopkeeperLoginState createState() => _ShopkeeperLoginState();
}

class _ShopkeeperLoginState extends State<ShopkeeperLogin> {
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();

  bool showPassword = false;

  final formKey = GlobalKey<FormState>();
  final emailIdKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  FocusNode emailIdNode;
  FocusNode passwordNode;
  FocusNode submitButNode;

  @override
  void initState() {
    emailIdNode = FocusNode();
    passwordNode = FocusNode();
    submitButNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailIdNode.dispose();
    passwordNode.dispose();
    submitButNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150.0,
                  width: 150.0,
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(75.0),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(6, 6),
                            blurRadius: 20.0,
                            color: Colors.blueAccent.withOpacity(0.2)),
                        BoxShadow(
                            offset: Offset(6, 6),
                            blurRadius: 20.0,
                            color: Colors.blueAccent.withOpacity(0.3))
                      ]),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 100.0,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  "Welcome back!",
                  style: GoogleFonts.quicksand(
                      fontSize: 25.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: emailId,
                  focusNode: emailIdNode,
                  key: emailIdKey,
                  onFieldSubmitted: (_) {
                    if (emailIdKey.currentState.validate()) {
                      FocusScope.of(context).requestFocus(passwordNode);
                    }
                  },
                  validator: (value) => value.isEmpty
                      ? "Email Id is Reqiured"
                      : !(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value))
                          ? "Enter Valid Email Id"
                          : null,
                  decoration: InputDecoration(
                      labelText: "Email Id", prefixIcon: Icon(Icons.mail)),
                ),
                TextFormField(
                  key: passwordKey,
                  focusNode: passwordNode,
                  onFieldSubmitted: (_) {
                    if (passwordKey.currentState.validate()) {
                      FocusScope.of(context).requestFocus(submitButNode);
                    }
                  },
                  obscureText: !showPassword,
                  controller: password,
                  validator: (value) =>
                      value.isEmpty ? "Password is Required" : null,
                  decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0)),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        print("done");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      child: Text(
                        "Login",
                        style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account? ",
                      style: GoogleFonts.quicksand(fontSize: 18.0),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Part1()));
                      },
                      child: Container(
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.quicksand(
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
