import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/business-detail/detail.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/loading/loading.dart';

class BusinessBranches extends StatelessWidget {
  static const String pathName = "/branches";

  const BusinessBranches({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Branches")),
      body: BlocBuilder<BusinessDetailBloc, BusinessDetailState>(
        builder: (branchCtx, branchState) {
          if (branchState is BusinessBranchesLoading) {
            return Loading();
          } else if (branchState is BusinessBranchesLoadSuccess) {
            return ListView.builder(
              itemCount: branchState.businesses.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) => BusinessBranchItem(
                branch: branchState.businesses[index],
              ),
            );
          } else {
            return Center(child: Text("Unable to connect"));
          }
        },
      ),
    );
  }
}

class BusinessBranchItem extends StatelessWidget {
  final Business branch;

  const BusinessBranchItem({Key key, this.branch});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          BusinessLocation(
            latLng: LatLng(branch.lat, branch.lng),
            locationDescription: branch.location,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/business_detail",
                  arguments: [branch.id, branch.categories[0].name]);
            },
            child: Text(
              "Go to Branch",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
