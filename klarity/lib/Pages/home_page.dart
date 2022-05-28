import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klarity/Pages/product_display.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _productName = [];
  List _productUrl = [];
  List _productImageUrl = [];
  List _productRating = [];
  List _productDescription = [];

  @override
  Widget build(BuildContext context) {
    // print(_productName);
    // print(_productUrl);
    // print(_productRating);
    // print(_productDescription);
    // print(_productImageUrl);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.home),
              SizedBox(
                width: 10,
              ),
              Text("Home"),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  if (_productDescription.isEmpty) await jsonReader();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Product(
                          _productName,
                          _productUrl,
                          _productImageUrl,
                          _productRating,
                          _productDescription)));
                },
                icon: Icon(Icons.refresh),
                color: Colors.black,
                iconSize: 40,
              ),
              Text(
                "Tap to load store",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ));
  }

  Future<void> jsonReader() async {
    final String response =
        await rootBundle.loadString('resources/product.json');
    final data = await json.decode(response);

    final exp = List.generate(
      data.length,
      (int index) => (data[index]["product_name"]),
    );
    final exp1 = List.generate(
      data.length,
      (int index) => (data[index]["product_url"]),
    );
    final exp2 = List.generate(
      data.length,
      (int index) => (data[index]["product_rating"]),
    );
    final exp3 = List.generate(
      data.length,
      (int index) => (data[index]["description"]),
    );

    final exp4 = List.generate(
      data.length,
      (int index) => (data[index]["image"]),
    );

    final exp5 = List.generate(
      data.length,
      (int index) {
        String text = exp4[index];
        RegExp reg =
            new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
        Iterable<RegExpMatch> matches = reg.allMatches(text);

        String c = "";
        for (var match in matches) {
          c = text.substring(match.start, match.end);
        }
        // print(c);
        return c;
      },
    );

    setState(() {
      _productName = exp;
      _productUrl = exp1;
      _productRating = exp2;
      _productDescription = exp3;
      _productImageUrl = exp5;
    });
  }
}
