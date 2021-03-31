import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/pages.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/posts.dart';

class PostsPage extends StatefulWidget{
  static const pathName="/postsPage";

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
          Expanded(child: Post(posts: [
            Story(images: [
              "assets/images/image.jpg",
              "assets/images/zorit.jpg"
            ]),
            Story(images: [

              "assets/images/zorit.jpg",
              "assets/images/image.jpg"
            ],),
            Story(images: [
              "assets/images/image.jpg",
              "assets/images/zorit.jpg"
            ]),
          ]))
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


