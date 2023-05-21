import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/state.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';
import 'package:zoritt_mobile_app_user/src/repository/post/posts_repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/post-item/post-card.dart';

class WhatIsNewPage extends StatefulWidget {
  static const String pathName = "/what_is_new_page";
  final BuildContext globalNavigator;
  final String userId;

  const WhatIsNewPage({Key key, @required this.globalNavigator, this.userId})
      : super(key: key);

  @override
  _WhatIsNewPageState createState() => _WhatIsNewPageState();
}

class _WhatIsNewPageState extends State<WhatIsNewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("What's new?")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (postCtx, postState) {
          if (postState is PostLoadSuccessful) {
            if (postState.posts.isNotEmpty) {
              return body(postState.posts, widget.globalNavigator);
            } else if (postState is PostLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Text("No recent updates."),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget body(List<Post> posts, BuildContext context) {
    return ListView(
      children: [
        ListView.builder(
          itemCount: posts.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) => BlocProvider<PostLikeBloc>(
            create: (context) => PostLikeBloc(
              postRepository: context.read<PostRepository>(),
            ),
            child: PostCard(
              post: posts[index],
              globalNavigator: widget.globalNavigator,
              context: context,
              userId: widget.userId,
            ),
          ),
        ),
      ],
    );
  }
}
