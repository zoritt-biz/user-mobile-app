import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/post_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class PostsSection extends StatelessWidget {
  final BuildContext globalNavigator;

  const PostsSection({Key key, this.globalNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "What's new?",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 150,
            child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is PostLoadSuccessful) {
                print(state.posts);
                if (state.posts.isNotEmpty) {
                  return body(context, state.posts);
                } else {
                  return Container(
                    child: Center(child: Text("No recent Posts")),
                  );
                }
              } else {
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
            }),
          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context, List<Post> posts) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 10, right: 10),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          width: 120.0,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(globalNavigator, "/postsPage",
                  arguments: [posts, index]);
            },
            child: Card(
              elevation: 3,
              shadowColor: Colors.white24,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(posts[index]?.photos[0]
                          // "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        posts[index] != null ? posts[index].businessName : "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
