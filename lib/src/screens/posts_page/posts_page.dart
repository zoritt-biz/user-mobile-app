import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart' as model;
import 'package:zoritt_mobile_app_user/src/screens/posts_page/pages.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/posts.dart';

class PostsPage extends StatefulWidget {
  static const pathName = "/postsPage";
  final List<model.Post> posts;
  final int selectedPost;

  PostsPage({this.posts, this.selectedPost = 0});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostsPageState();
  }
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Post(
            posts: widget.posts
                .map(
                  (post) => Story(
                    post: post,
                  ),
                )
                .toList(),
            index: widget.selectedPost,
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
