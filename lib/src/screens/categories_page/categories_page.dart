import 'package:flutter/material.dart';

import 'category_list.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 25.0,
        // shrinkWrap: true,
        children: List.generate(
          CATEGORY_LIST.length,
          (index) {
            return GridItem(
              CATEGORY_LIST[index]["name"],
              CATEGORY_LIST[index]["icon"],
              CATEGORY_LIST[index]["sub_categories"],
            );
          },
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<dynamic> subCategories;

  GridItem(this.title, this.icon, this.subCategories);

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
            Navigator.pushNamed(context, "/subcategories",
                arguments: [subCategories]);
          },
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50),
              SizedBox(
                height: 20,
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
