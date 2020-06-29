import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/services/authenticate/authentication.dart';
import 'package:shopping_app_background/views/buyer/home/main_home_page.dart';
import 'package:shopping_app_background/views/buyer/registration/buyer_signup.dart';

class BuyerLogin extends StatefulWidget {
  @override
  _BuyerLoginState createState() => _BuyerLoginState();
}

class _BuyerLoginState extends State<BuyerLogin> {
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();

  bool showPassword = false, isLoading = false;

  final formKey = GlobalKey<FormState>();
  final emailIdKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  FocusNode emailIdNode;
  FocusNode passwordNode;
  FocusNode submitButNode;
  AuthServices authServices = AuthServices();

  userLogin() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authServices
          .singInWithEmailAndPassword(
              emailId.text.toString().trim(), password.text.toString().trim())
          .then((value) {
            setState(() {
            isLoading = false;
          });
        if (value != null) {
          
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainHome(value)));
        }
      });
    }
  }

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
      body: isLoading
          ? SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
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
                          Icons.person,
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
                            labelText: "Email Id",
                            prefixIcon: Icon(Icons.mail)),
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
                          onPressed: userLogin,
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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => BuyerSignUp()));
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
