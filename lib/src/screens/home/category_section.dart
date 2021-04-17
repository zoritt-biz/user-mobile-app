import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Column(
          children: List.generate(
            2,
            (i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[100]),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(10),
                      ),
                    ),
                    onPressed: () {
                      if (index == 3 && i == 1) {
                        Navigator.pushNamed(context, "/categories");
                      } else {}
                    },
                    child: Column(
                      children: [
                        index == 3 && i == 1
                            ? Icon(Icons.more_horiz, color: Colors.black)
                            : Icon(Icons.category, color: Colors.black),
                        Text(
                          index == 3 && i == 1 ? "More" : "Category",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
