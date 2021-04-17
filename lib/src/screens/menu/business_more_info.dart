import 'package:flutter/material.dart';

class BusinessMoreInfo extends StatelessWidget {
  static const String pathName = "/more_business_info";

  final String title;
  final String description;

  BusinessMoreInfo({
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Info'),
      ),
      body: ListView(
        children: [
          SingleInfo(title: "asgs", description: "askdjfhkad"),
          SingleInfo(title: "asgs", description: "askdjfhkad"),
          SingleInfo(title: "asgs", description: "askdjfhkad"),
        ],
      ),
    );
  }
}

class SingleInfo extends StatelessWidget {
  final String title;
  final String description;

  SingleInfo({
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Text(
              description,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
