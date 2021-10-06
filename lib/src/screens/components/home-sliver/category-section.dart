import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/categories/category-list.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3 / 2,
          padding: EdgeInsets.only(top: 15),
          crossAxisCount: 4,
          shrinkWrap: true,
          children: List.generate(
            8,
            (index) {
              return ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(0),
                  ),
                ),
                onPressed: () {
                  if (index == 7) {
                    Navigator.pushNamed(context, "/categories");
                  } else {
                    context.read<BusinessBloc>().searchBusinessesByCategory(
                          HOME_CATEGORY_LIST[index]["name"].toString(),
                          0,
                          50,
                        );
                    context.read<NavigationBloc>().navigateToSearch();
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    index == 7
                        ? Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                            size: 35,
                          )
                        : Icon(
                            HOME_CATEGORY_LIST[index]["icon"],
                            color: Colors.black,
                            size: 35,
                          ),
                    SizedBox(height: 6),
                    Text(
                      index == 7 ? "More" : HOME_CATEGORY_LIST[index]["name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
