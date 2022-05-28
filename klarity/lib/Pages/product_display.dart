import 'package:flutter/material.dart';
import 'package:klarity/widget/custom_listview.dart';

class Product extends StatefulWidget {
  List _productName = [];
  List _productUrl = [];
  List _productImageUrl = [];
  List _productRating = [];
  List _productDescription = [];

  // Product({Key? key}) : super(key: key);
  Product(this._productName, this._productUrl, this._productImageUrl,
      this._productRating, this._productDescription);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    // print(widget._productDescription);
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
      ),
      body: ListView.builder(
        itemCount: widget._productDescription.length,
        itemBuilder: (BuildContext context, int index) {
          return Customlist(
              widget._productName[index],
              widget._productUrl[index],
              widget._productImageUrl[index],
              widget._productRating[index],
              widget._productDescription[index]);
        },
      ),
    );
  }
}
