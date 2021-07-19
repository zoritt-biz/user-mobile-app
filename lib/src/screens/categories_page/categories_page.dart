import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';

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
                  return GridItem(
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

class GridItem extends StatelessWidget {
  final String title;
  final String image;
  final List<String> subCategories;

  GridItem(this.title, this.image, this.subCategories);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey[300],
          onTap: () {
            print(subCategories);
            Navigator.pushNamed(context, "/subcategories",
                arguments: [subCategories]);
          },
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(icon, size: 50),
              Container(
                height: 60.0,
                width: 60.0,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fitHeight,
                  ),
                  // shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
