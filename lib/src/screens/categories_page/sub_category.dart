import 'package:flutter/material.dart';

class Subcategory extends StatelessWidget {
  static const String pathName = "/subcategories";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategory"),
      ),
      body: Text("subcategory"),
    );
  }
}
