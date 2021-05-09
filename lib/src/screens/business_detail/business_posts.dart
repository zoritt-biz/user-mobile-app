import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';
import 'package:zoritt_mobile_app_user/src/screens/home/posts_section.dart';

class BusinessPost extends StatelessWidget {
  final List<Post> posts;
  final BuildContext globalNavigator;

  const BusinessPost({Key key, this.posts, this.globalNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'Posts',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              posts.length > 0
                  ? Container(
                      height: 160,
                      child: PostItems(
                        buildContext: context,
                        posts: posts,
                        isVertical: false,
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Icon(FontAwesomeIcons.tasks),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sorry, There is no posts in this business',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
