// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class Customlist extends StatefulWidget {
  String _productName;
  String _productUrl;
  String _productImageUrl;
  String _productRating;
  String _productDescription;

  Customlist(this._productName, this._productUrl, this._productImageUrl,
      this._productRating, this._productDescription);

  @override
  State<Customlist> createState() => _CustomlistState();
}

class _CustomlistState extends State<Customlist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              // launchUrl(Uri.parse(widget._productUrl));
              _openPopup(context);
            },
            child: ListTile(
              leading: Container(
                width: 50,
                alignment: Alignment.center,
                child: Image.network(
                  widget._productImageUrl,
                  errorBuilder: (context, exception, stackTrace) {
                    print(widget._productName);
                    return Image.asset(
                      "resources/error.png",
                      // fit: BoxFit.fill,
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              title: Text(
                widget._productName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  widget._productRating == "No rating available"
                      ? Text("NA")
                      : Text(widget._productRating)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: widget._productName,
        content: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.topRight,
                children: [
                  InteractiveViewer(
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        widget._productImageUrl,
                        errorBuilder: (context, exception, stackTrace) {
                          print(widget._productName);
                          return Image.asset(
                            "resources/error.png",
                            // fit: BoxFit.fill,
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      widget._productRating == "No rating available"
                          ? Text(
                              "NA",
                              textScaleFactor: 0.5,
                            )
                          : Text(widget._productRating)
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Title(
                  color: Colors.grey,
                  child: Text(
                    widget._productDescription,
                    maxLines: 10,
                    style: TextStyle(fontSize: 13),
                  )),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              launchUrl(Uri.parse(widget._productUrl));
            },
            child: Text(
              "Buy",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
