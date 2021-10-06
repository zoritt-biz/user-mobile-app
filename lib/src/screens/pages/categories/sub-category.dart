import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';

class Subcategory extends StatelessWidget {
  static const String pathName = "/subcategories";
  final List<String> subCategories;

  const Subcategory(this.subCategories);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subcategory")),
      body: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.read<BusinessBloc>().searchBusinessesByCategory(
                    subCategories[index],
                    0,
                    50,
                  );
              context.read<NavigationBloc>().navigateToSearch();
            },
            title: Text(
              subCategories[index],
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
