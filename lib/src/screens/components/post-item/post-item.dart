import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';

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
