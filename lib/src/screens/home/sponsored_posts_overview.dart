import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SponsoredPostsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 400.0,
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Container(
            height: 140.0,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Card(
              child: Text('data $index'),
            ),
          );
        },
        childCount: 10,
      ),
    );
  }
}
