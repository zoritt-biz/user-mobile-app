import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class BusinessMoreInfo extends StatelessWidget {
  static const String pathName = "/more_business_info";

  final Business business;

  BusinessMoreInfo({this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Info',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          SingleInfo(title: "Description", description: business.description),
          if (business.specialization != null && business.specialization != "")
            SingleInfo(
                title: "Specialization", description: business.specialization),
          if (business.establishedIn != null && business.establishedIn != "")
            SingleInfo(
                title: "Established In", description: business.establishedIn),
          if (business.history != null && business.history != "")
            SingleInfo(title: "History", description: business.history),
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
