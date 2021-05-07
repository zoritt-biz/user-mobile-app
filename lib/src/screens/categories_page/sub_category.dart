import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/business_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/navigation_bloc.dart';

class Subcategory extends StatelessWidget {
  static const String pathName = "/subcategories";
  final List<dynamic> subCategories;

  const Subcategory(this.subCategories);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategory",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.read<BusinessBloc>().searchForBusinesses(
                    subCategories[index]["name"].toString().toLowerCase(),
                    0,
                    50,
                  );
              context.read<NavigationBloc>().navigateToSearch();
            },
            title: Text(
              subCategories[index]["name"],
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
