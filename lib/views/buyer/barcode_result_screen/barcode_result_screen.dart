import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarcodeResult extends StatefulWidget {
  final String opText;
  BarcodeResult(this.opText);
  @override
  _BarcodeResultState createState() => _BarcodeResultState();
}

class _BarcodeResultState extends State<BarcodeResult> {
  List products = [];
  int totalCost = 0;
  @override
  void initState() {
    super.initState();
  }

  TextEditingController quantityController = TextEditingController();
  final quantityKey = GlobalKey<FormFieldState>();
  Future<String> qrScan() async {
    var scanResult = await BarcodeScanner.scan();
    return scanResult.rawContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 7.0),
              child: FlatButton(
                color: Colors.green,
                child: Text(
                  "Buy Now",
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    // fontSize:
                  ),
                ),
                onPressed: (){},
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: Icon(Icons.add_shopping_cart), 
              onPressed: () async {
                  String opString = await qrScan();
                  print(opString);
                  if (opString.length > 0) {
                    List qrOutputList = opString.split(" ");
                    String productName = qrOutputList
                        .sublist(0, qrOutputList.length - 1)
                        .join(" ");
                    int productMRP =
                        int.parse(qrOutputList[qrOutputList.length - 1]);
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          scrollable: true,
                          // contentPadding: EdgeInsets.all(2.0),

                          title: Text(
                            "Product Details",
                            style: GoogleFonts.quicksand(
                                fontSize: 25.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text(
                                  "Name of the Item:",
                                  style: GoogleFonts.quicksand(),
                                ),
                                subtitle: Text(
                                  "$productName",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  "$productMRP Rs.",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20.0, color: Colors.brown),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.numberWithOptions(),
                                controller: quantityController,
                                key: quantityKey,
                                validator: (value) => value.isEmpty
                                    ? "Quantity is Required"
                                    : RegExp(r"[!#$%^&*()]").hasMatch(value)
                                        ? "Enter Valid Quantity"
                                        : null,
                                decoration: InputDecoration(
                                    hintText: "Enter the Quantity of Item"),
                              )
                            ],
                          ),
                          actions: [
                            FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    quantityController.text = "";
                                  });
                                },
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                )),
                            FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                onPressed: () {
                                  if (quantityKey.currentState.validate()) {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      products.add({
                                        "productName": productName,
                                        "productQuantity": quantityController
                                            .text
                                            .toString()
                                            .trim(),
                                        "totalProductCost": (productMRP *
                                            int.parse(quantityController.text
                                                .toString()
                                                .trim()))
                                      });
                                      totalCost += (productMRP *
                                          int.parse(quantityController.text
                                              .toString()
                                              .trim()));
                                      quantityController.text = "";
                                    });
                                  }
                                },
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ));
                  }
                },
            ),
            SizedBox(
              width: 20.0,
            )
          ],
        ),
        body: products.length == 0
            ? InkWell(
                onTap: () async {
                  String opString = await qrScan();
                  print(opString);
                  if (opString.length > 0) {
                    List qrOutputList = opString.split(" ");
                    String productName = qrOutputList
                        .sublist(0, qrOutputList.length - 1)
                        .join(" ");
                    int productMRP =
                        int.parse(qrOutputList[qrOutputList.length - 1]);
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          scrollable: true,
                          // contentPadding: EdgeInsets.all(2.0),

                          title: Text(
                            "Product Details",
                            style: GoogleFonts.quicksand(
                                fontSize: 25.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text(
                                  "Name of the Item:",
                                  style: GoogleFonts.quicksand(),
                                ),
                                subtitle: Text(
                                  "$productName",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  "$productMRP Rs.",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20.0, color: Colors.brown),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.numberWithOptions(),
                                controller: quantityController,
                                key: quantityKey,
                                validator: (value) => value.isEmpty
                                    ? "Quantity is Required"
                                    : RegExp(r"[!#$%^&*()]").hasMatch(value)
                                        ? "Enter Valid Quantity"
                                        : null,
                                decoration: InputDecoration(
                                    hintText: "Enter the Quantity of Item"),
                              )
                            ],
                          ),
                          actions: [
                            FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    quantityController.text = "";
                                  });
                                },
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                )),
                            FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                onPressed: () {
                                  if (quantityKey.currentState.validate()) {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      products.add({
                                        "productName": productName,
                                        "productQuantity": quantityController
                                            .text
                                            .toString()
                                            .trim(),
                                        "totalProductCost": (productMRP *
                                            int.parse(quantityController.text
                                                .toString()
                                                .trim()))
                                      });
                                      totalCost += (productMRP *
                                          int.parse(quantityController.text
                                              .toString()
                                              .trim()));
                                      quantityController.text = "";
                                    });
                                  }
                                },
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ));
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You Have No Item Added to the Cart",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.withOpacity(0.75)),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Icon(
                            Icons.hourglass_empty,
                            size: 100.0,
                            color: Colors.grey.withOpacity(0.75),
                          ),
                          SizedBox(
                            height: 30.0,
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
              )
            : Container(
                padding: EdgeInsets.only(top: 10.0, left: 12.5, right: 12.5),
                child: ListView.builder(
                    itemCount: products.length + 1,
                    itemBuilder: (context, index) =>
                        index == products.length
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: 10.0, bottom: 20.0, right: 15.0),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Total Cost: $totalCost",
                                      style: GoogleFonts.quicksand(
                                          fontSize: 25.0,
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w600),
                                    ))
                                : Dismissible(
                                    key: ValueKey(products[index]),
                                    direction: DismissDirection.horizontal,
                                    background: Container(
                                      color: Colors.red,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      setState(() {
                                        totalCost -=
                                            products[index]["totalProductCost"];
                                        products.remove(products[index]);
                                      });
                                    },
                                    child: Card(
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: ListTile(
                                        leading: Text(
                                          "Qty.\n${products[index]["productQuantity"]}",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 20.0,
                                              color: Colors.brown,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        title: Text(
                                          "Name of the Item:",
                                          style: GoogleFonts.quicksand(),
                                        ),
                                        subtitle: Text(
                                          products[index]["productName"],
                                          style: GoogleFonts.quicksand(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: Text(
                                          "${products[index]["totalProductCost"]} Rs.",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 20.0,
                                              color: Colors.brown),
                                        ),
                                      ),
                                    ),
                                  )),
              ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: products.length > 0
        //     ? FloatingActionButton.extended(
        //         onPressed: () async {
        //           String opString = await qrScan();
        //           print(opString);
        //           if (opString.length > 0) {
        //             List qrOutputList = opString.split(" ");
        //             String productName = qrOutputList
        //                 .sublist(0, qrOutputList.length - 1)
        //                 .join(" ");
        //             int productMRP =
        //                 int.parse(qrOutputList[qrOutputList.length - 1]);
        //             showDialog(
        //                 context: context,
        //                 child: AlertDialog(
        //                   scrollable: true,
        //                   // contentPadding: EdgeInsets.all(2.0),

        //                   title: Text(
        //                     "Product Details",
        //                     style: GoogleFonts.quicksand(
        //                         fontSize: 25.0,
        //                         color: Colors.red,
        //                         fontWeight: FontWeight.w600),
        //                   ),
        //                   content: Column(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       ListTile(
        //                         title: Text(
        //                           "Name of the Item:",
        //                           style: GoogleFonts.quicksand(),
        //                         ),
        //                         subtitle: Text(
        //                           "$productName",
        //                           style: GoogleFonts.quicksand(
        //                               fontSize: 25.0,
        //                               fontWeight: FontWeight.w600),
        //                         ),
        //                         trailing: Text(
        //                           "$productMRP Rs.",
        //                           style: GoogleFonts.quicksand(
        //                               fontSize: 20.0, color: Colors.brown),
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         height: 30.0,
        //                       ),
        //                       TextFormField(
        //                         keyboardType: TextInputType.numberWithOptions(),
        //                         controller: quantityController,
        //                         key: quantityKey,
        //                         validator: (value) => value.isEmpty
        //                             ? "Quantity is Required"
        //                             : RegExp(r"[!#$%^&*()]").hasMatch(value)
        //                                 ? "Enter Valid Quantity"
        //                                 : null,
        //                         decoration: InputDecoration(
        //                             hintText: "Enter the Quantity of Item"),
        //                       )
        //                     ],
        //                   ),
        //                   actions: [
        //                     FlatButton(
        //                         color: Colors.blue,
        //                         shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(20.0)),
        //                         onPressed: () {
        //                           Navigator.of(context).pop();
        //                           setState(() {
        //                             quantityController.text = "";
        //                           });
        //                         },
        //                         child: Text(
        //                           "Cancel",
        //                           style: GoogleFonts.roboto(
        //                             color: Colors.white,
        //                           ),
        //                         )),
        //                     FlatButton(
        //                         color: Colors.blue,
        //                         shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(20.0)),
        //                         onPressed: () {
        //                           if (quantityKey.currentState.validate()) {
        //                             Navigator.of(context).pop();
        //                             setState(() {
        //                               products.add({
        //                                 "productName": productName,
        //                                 "productQuantity": quantityController
        //                                     .text
        //                                     .toString()
        //                                     .trim(),
        //                                 "totalProductCost": (productMRP *
        //                                     int.parse(quantityController.text
        //                                         .toString()
        //                                         .trim()))
        //                               });
        //                               totalCost += (productMRP *
        //                                   int.parse(quantityController.text
        //                                       .toString()
        //                                       .trim()));
        //                               quantityController.text = "";
        //                             });
        //                           }
        //                         },
        //                         child: Text(
        //                           "Add",
        //                           style: GoogleFonts.roboto(
        //                             color: Colors.white,
        //                           ),
        //                         ))
        //                   ],
        //                 ));
        //           }
        //         },
        //         icon: Icon(Icons.camera),
        //         label: Text("Scan QRCode"))
            );
  }
}
