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

class PostItems extends StatelessWidget {
  final BuildContext buildContext;
  final List<Post> posts;
  final bool isVertical;

  const PostItems({Key key, this.buildContext, this.posts, this.isVertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
      padding: EdgeInsets.only(left: 10, right: 10),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          width: 120.0,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(buildContext, "/postsPage",
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
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            posts[index]?.photos?.elementAt(0) ?? ""),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
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
}
