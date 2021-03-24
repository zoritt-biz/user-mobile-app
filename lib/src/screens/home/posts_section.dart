import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Posts", style: TextStyle(fontSize: 25),),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20, right: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 140.0,
                  child: Card(
                    child: Text('data'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
