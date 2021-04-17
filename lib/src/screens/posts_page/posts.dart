import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/stories/stories_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/stories/stories_state.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/pages.dart'
    as pages;
import 'package:zoritt_mobile_app_user/src/screens/posts_page/pages.dart';

class Post extends StatefulWidget {
  final List<pages.Story> posts;
  final int index;

  Post({@required this.posts, this.index = 0});

  @override
  PostState createState() => PostState();
}

class PostState extends State<Post> {
  PageController _pageController;
  double currentIndex;
  List<pages.Story> posts;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index.toDouble();
    posts = widget.posts;

    _pageController = PageController(initialPage: widget.index);
    if (widget.index > 5) {
      context.read<StoryBloc>().getStories(posts.length, 10, "CREATEDAT_DESC");
    }
    // _pageController.
    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page;
      });
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(() {});
    _pageController.dispose();
    super.dispose();
  }

  void goToNext() {
    if (currentIndex.toInt() < posts.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryBloc, StoryState>(listener: (context, state) {
      if (state is StoryFinished) {
        goToNext();
        context.read<StoryBloc>().emitUnknown();
      }
    }, builder: (context, state) {
      if (state is StoryLoadSuccessful) {
        if (state.posts.isNotEmpty) {
          posts += state.posts
              .map(
                (e) => Story(post: e),
              )
              .toList();
        }
      }
      return PageView.builder(
        itemBuilder: (context, index) {
          double value;
          if (_pageController.position.haveDimensions == false) {
            value = index.toDouble();
          } else {
            value = _pageController.page;
          }
          return _SwipeWidget(
            index: index,
            pageNotifier: value,
            child: posts[index],
          );
        },
        controller: _pageController,
        itemCount: posts.length,
        onPageChanged: (page) {
          if ((posts.length - 5) == page) {
            if (!(state is StoryLoading)) {
              if (state is StoryLoadSuccessful) {
                if (state.posts.isNotEmpty) {
                  context
                      .read<StoryBloc>()
                      .getStories(posts.length, 10, "CREATEDAT_DESC");
                }
                return;
              }

              context
                  .read<StoryBloc>()
                  .getStories(posts.length, 10, "CREATEDAT_DESC");
            }
          }
        },
      );
    });
  }
}

num degToRad(num deg) => deg * (pi / 180.0);

class _SwipeWidget extends StatelessWidget {
  final int index;

  final double pageNotifier;

  final Widget child;

  const _SwipeWidget({
    Key key,
    @required this.index,
    @required this.pageNotifier,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLeaving = (index - pageNotifier) <= 0;
    final t = (index - pageNotifier);
    final rotationY = lerpDouble(0, 90, t);
    final opacity = lerpDouble(0, 1, t.abs()).clamp(0.0, 1.0);

    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);
    transform.rotateY(-degToRad(rotationY));

    return Transform(
      alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
      transform: transform,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Opacity(
              opacity: opacity,
              child: SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
