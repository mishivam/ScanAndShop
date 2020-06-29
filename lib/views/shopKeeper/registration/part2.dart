import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app_background/services/database/database_services.dart';
import 'package:shopping_app_background/views/buyer/home/main_home_page.dart';

class Part2 extends StatefulWidget {
  final String uid;
  Map<String, String> ownerData;
  Part2(this.uid, this.ownerData);
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<Part2> {
  bool showPassword = false, isLoading = false;

  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode nameNode;
  FocusNode areaNode;
  FocusNode contactNoNode;
  FocusNode passwordNode;
  FocusNode emailIdNode;
  FocusNode cityNode;
  FocusNode stateNode;
  FocusNode submitButNode;

  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormFieldState>();
  final emailIdKey = GlobalKey<FormFieldState>();
  final contactNoKey = GlobalKey<FormFieldState>();
  final areaKey = GlobalKey<FormFieldState>();
  final cityKey = GlobalKey<FormFieldState>();
  final stateKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  DatabaseServices databaseServices = DatabaseServices();
  addDataToDatabase() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> mallData = widget.ownerData;
      mallData["mallName"] = name.text.toString().trim();
      mallData["mallContactNo"] = contactNo.text.toString().trim();
      mallData["mallEmailId"] = emailId.text.toString().trim();
      mallData["mallArea"] = area.text.toString().trim();
      mallData["mallCity"] = city.text.toString().trim();
      mallData["mallState"] = state.text.toString().trim();
      mallData["mallAddress"] = password.text.toString().trim();
      await databaseServices
          .addMallToCommonDatabase(widget.uid, mallData)
          .then((value)async {
            await databaseServices
          .addMallToDatabase(widget.uid, mallData)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainHome(widget.uid)));
      });
          });
    }
  }

  @override
  void initState() {
    nameNode = FocusNode();
    contactNoNode = FocusNode();
    emailIdNode = FocusNode();
    areaNode = FocusNode();
    cityNode = FocusNode();
    stateNode = FocusNode();
    passwordNode = FocusNode();
    submitButNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameNode.dispose();
    contactNoNode.dispose();
    emailIdNode.dispose();
    areaNode.dispose();
    cityNode.dispose();
    stateNode.dispose();
    passwordNode.dispose();
    submitButNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mall Details"),
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
                      bottom: (MediaQuery.of(context).size.height * 0.2)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 25.0),
                    child: Form(
                      key: formKey,
                      child: Column(
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
                                labelText: "Name of the Shop",
                                prefixIcon: Icon(Icons.home)),
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
                                FocusScope.of(context).requestFocus(areaNode);
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
                            focusNode: areaNode,
                            key: areaKey,
                            onFieldSubmitted: (_) {
                              if (areaKey.currentState.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(cityNode);
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Name of Area of the Shop",
                                prefixIcon: Icon(Icons.home)),
                            controller: area,
                            validator: (value) => value.isEmpty
                                ? "Name of the Area is Required"
                                : null,
                          ),
                          TextFormField(
                            focusNode: cityNode,
                            key: cityKey,
                            onFieldSubmitted: (_) {
                              if (cityKey.currentState.validate()) {
                                FocusScope.of(context).requestFocus(stateNode);
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Name of City of the Shop",
                                prefixIcon: Icon(Icons.home)),
                            controller: city,
                            validator: (value) => value.isEmpty
                                ? "Name of City is Required"
                                : null,
                          ),
                          TextFormField(
                            focusNode: stateNode,
                            key: stateKey,
                            onFieldSubmitted: (_) {
                              if (stateKey.currentState.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Name of State of the Shop",
                                prefixIcon: Icon(Icons.home)),
                            controller: state,
                            validator: (value) => value.isEmpty
                                ? "Name of State is Required"
                                : null,
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
                            controller: password,
                            minLines: 1,
                            maxLines: 10,
                            validator: (value) =>
                                value.isEmpty ? "Address is Required" : null,
                            decoration: InputDecoration(
                              labelText: "Address",
                              prefixIcon: Icon(Icons.location_on),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          FlatButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0)),
                              onPressed: addDataToDatabase,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
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
