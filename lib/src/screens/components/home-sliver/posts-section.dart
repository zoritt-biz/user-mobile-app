import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/state.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/post-item/post-item.dart';

class PostsSection extends StatelessWidget {
  final BuildContext globalNavigator;

  const PostsSection({Key key, this.globalNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/what_is_new_page");
                },
                child: Row(
                  children: [
                    Text(
                      "What's new?",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, color: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(context, "/what_is_new_page");
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 160,
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoadSuccessful) {
                    if (state.posts.isNotEmpty) {
                      return PostItems(
                        buildContext: globalNavigator,
                        posts: state.posts,
                        isVertical: false,
                      );
                    } else {
                      return Container(
                        child: Center(child: Text("No recent Posts")),
                      );
                    }
                  } else {
                    print(state);
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(child: shimmerItem()),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: shimmerItem()),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: shimmerItem()),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerItem() {
    return Container(
      width: 120.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
