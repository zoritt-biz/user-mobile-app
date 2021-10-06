import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/category-page-item/category-page-item.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (catCtx, catState) {
          if (catState is CategoriesLoadSuccess) {
            return GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 3,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 25.0,
              children: List.generate(
                catState.categories.length,
                (index) {
                  return CategoryPageItem(
                    catState.categories[index].name,
                    catState.categories[index].image,
                    catState.categories[index].subCategories,
                  );
                },
              ),
            );
          } else if (catState is CategoryOperationFailure) {
            return Center(
              child: TextButton(
                child: Text("Retry!"),
                onPressed: () {
                  context.read<CategoryBloc>().getCategories();
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
