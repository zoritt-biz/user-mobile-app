import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

import './location.dart';

class BusinessBranch extends StatelessWidget {
  static const String pathName = "/business_detail/branches";
  final List<Branch> branches;

  const BusinessBranch(this.branches);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Branches"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ...branches.map((branch) => BusinessLocation(
                latLng: LatLng(branch.lat, branch.lng),
                locationDescription: branch.location,
                branches: [],
              )),
        ],
      ),
    );
  }
}
