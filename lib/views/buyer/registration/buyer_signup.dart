import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/services/authenticate/authentication.dart';
import 'package:shopping_app_background/services/database/database_services.dart';
import 'package:shopping_app_background/views/buyer/home/main_home_page.dart';
import 'package:shopping_app_background/views/login/buyer.dart';
import 'package:shopping_app_background/views/login/login_home.dart';

class BuyerSignUp extends StatefulWidget {
  @override
  _BuyerSignUpState createState() => _BuyerSignUpState();
}

class _BuyerSignUpState extends State<BuyerSignUp> {
  bool showPassword = false, isLoading = false;

  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthServices authServices = AuthServices();
  DatabaseServices databaseServices = DatabaseServices();
  addUserData() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authServices
          .signUpWithEmailAndPassword(
              emailId.text.toString().trim(), password.text.toString().trim())
          .then((value) async {
        if (value != null) {
          String uid = value;
          Map<String, String> userData = {
            "userName": name.text.toString().trim(),
            "contactNo": contactNo.text.toString().trim(),
            "emailId": emailId.text.toString().trim(),
            "uid": uid
          };
         await  databaseServices.addUserToDatabase(uid, userData).then((value) {
            
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainHome(uid)));
            
          });
        }
      });
    }
  }

  FocusNode nameNode;
  FocusNode contactNoNode;
  FocusNode passwordNode;
  FocusNode emailIdNode;
  FocusNode submitButNode;
  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormFieldState>();
  final emailIdKey = GlobalKey<FormFieldState>();
  final contactNoKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    nameNode = FocusNode();
    contactNoNode = FocusNode();
    emailIdNode = FocusNode();
    passwordNode = FocusNode();
    submitButNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameNode.dispose();
    contactNoNode.dispose();
    emailIdNode.dispose();
    passwordNode.dispose();
    submitButNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                child: Card(
                  elevation: 5.0,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 50.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            focusNode: nameNode,
                            key: nameKey,
                            onFieldSubmitted: (_) {
                              if (nameKey.currentState.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(contactNoNode);
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Name",
                                prefixIcon: Icon(Icons.person)),
                            controller: name,
                            validator: (value) =>
                                value.isEmpty ? "Name is Required" : null,
                          ),
                          TextFormField(
                            maxLength: 10,
                            key: contactNoKey,
                            focusNode: contactNoNode,
                            onFieldSubmitted: (_) {
                              if (contactNoKey.currentState.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(emailIdNode);
                              }
                            },
                            maxLengthEnforced: true,
                            controller: contactNo,
                            validator: (value) => value.isEmpty
                                ? "Phone No. is Required"
                                : value.toString().trim().length < 10
                                    ? "Enter Valid Contact No."
                                    : null,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                                labelText: "Contact No.",
                                prefixIcon: Icon(Icons.phone)),
                          ),
                          TextFormField(
                            controller: emailId,
                            focusNode: emailIdNode,
                            key: emailIdKey,
                            onFieldSubmitted: (_) {
                              if (emailIdKey.currentState.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
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
                                FocusScope.of(context)
                                    .requestFocus(submitButNode);
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
                              onPressed: addUserData,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                child: Text(
                                  "SignUp",
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
                                "Already have an Account? ",
                                style: GoogleFonts.quicksand(fontSize: 18.0),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => LoginHome()));
                                },
                                child: Container(
                                  child: Text(
                                    "Login",
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
              ),
            ),
    );
  }
}
