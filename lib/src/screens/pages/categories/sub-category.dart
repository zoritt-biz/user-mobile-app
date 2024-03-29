import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/filter.dart';

class Subcategory extends StatelessWidget {
  static const String pathName = "/subcategories";
  final List<String> subCategories;
  final BuildContext localNavigator;

  const Subcategory(this.subCategories, this.localNavigator);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subcategory")),
      body: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            onTap: () {
              context.read<BusinessBloc>().filterBusinesses(
                    new Filter(category: [subCategories[index]]),
                    1,
                    100,
                  );
              context
                  .read<NavigationBloc>()
                  .navigateToSearch(subCategories[index]);
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
