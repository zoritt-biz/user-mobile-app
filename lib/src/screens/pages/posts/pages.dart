import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post-like/state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/stories/stories_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/user/user_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/post/posts_repository.dart';

class Story extends StatefulWidget {
  final Post post;
  final BuildContext globalNavigator;

  const Story({@required this.post, @required this.globalNavigator});

  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    _loadStory(animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.post.photos.length) {
            _currentIndex += 1;
            _loadStory(image: widget.post.photos[_currentIndex]);
          } else {
            context.read<StoryBloc>().emitStoryFinished();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void goToBusinessDetail(String businessId) {
    _animController.stop();
    _animController.reset();
    context.read<StoryBloc>().emitStoryFinished();
    // _pageController.dispose();
    _animController.dispose();
    Navigator.pushNamed(
      widget.globalNavigator,
      "/business_detail",
      arguments: [widget.post.owner],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String image = widget.post.photos[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, image),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.post.photos.length,
              itemBuilder: (context, i) {
                return CachedNetworkImage(
                  imageUrl: widget.post.photos[i],
                  placeholder: (context, url) {
                    return Container(
                      color: Colors.black,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    Future.delayed(Duration(milliseconds: 600)).then(
                      (value) {
                        _animController?.forward();
                      },
                    );

                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
            Positioned(
              top: 40.0,
              left: 10.0,
              right: 10.0,
              child: Row(
                children: widget.post.photos
                    .asMap()
                    .map(
                      (i, e) {
                        return MapEntry(
                          i,
                          AnimatedBar(
                            animController: _animController,
                            position: i,
                            currentIndex: _currentIndex,
                          ),
                        );
                      },
                    )
                    .values
                    .toList(),
              ),
            ),
            SizedBox(
              height: 30,
              child: Container(decoration: BoxDecoration(color: Colors.white)),
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
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 15,
              right: 15,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 1.5,
                  vertical: 10.0,
                ),
                child: BlocProvider<PostLikeBloc>(
                  create: (context) => PostLikeBloc(
                    postRepository: context.read<PostRepository>(),
                  ),
                  child: BusinessInfo(
                    post: widget.post,
                    goToBusinessDetail: goToBusinessDetail,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, String story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory();
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.post.photos.length) {
          _currentIndex += 1;
          _loadStory(image: widget.post.photos[_currentIndex]);
        } else {
          context.read<StoryBloc>().emitStoryFinished();
        }
      });
    }
  }

  void _loadStory({String image, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    _animController.duration = Duration(seconds: 3);

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key key,
    @required this.animController,
    @required this.position,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class BusinessInfo extends StatefulWidget {
  final Post post;
  final Function goToBusinessDetail;

  const BusinessInfo({
    Key key,
    @required this.post,
    @required this.goToBusinessDetail,
  }) : super(key: key);

  @override
  _BusinessInfoState createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  bool localChange = false;
  bool value = false;

  void share(BuildContext context, Post post) {
    String subject =
        "${post.businessName} \n ${post.description} \n ${post.photos[0]} ";
    Share.share(subject, subject: post.description);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostLikeBloc, PostLikeState>(
      listener: (postBloc, postState) {
        if (postState is PostLikingSuccessful) {
          setState(() {
            localChange = true;
            value = true;
            widget.post.isLiked = true;
          });
        } else if (postState is PostUnlikingSuccessful) {
          setState(() {
            localChange = true;
            value = false;
            widget.post.isLiked = false;
          });
        }
      },
      builder: (postBloc, postState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(
                  widget.post.businessLogo != null &&
                          widget.post.businessLogo != ""
                      ? widget.post.businessLogo
                      : "https://firebasestorage.googleapis.com/v0/b/zoritt-app.appspot.com/o/ic_launcher.jpg?alt=media&token=37ef2fe4-bf31-43e4-87ca-9bab1b724483",
                  scale: 1,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.goToBusinessDetail(widget.post.owner);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.businessName ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.post.description ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 2,
              ),
              IconButton(
                icon: Icon(
                  localChange
                      ? value
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded
                      : widget.post.isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                  size: 30.0,
                  color: Color(0xffDF9C20),
                ),
                onPressed: () {
                  if (context.read<AuthenticationBloc>().state.status ==
                      AuthenticationStatus.authenticated) {
                    if (postState is! PostLiking &&
                        postState is! PostUnliking) {
                      if (localChange) {
                        if (value) {
                          context
                              .read<PostLikeBloc>()
                              .unlikePost(widget.post.id);
                        } else {
                          context
                              .read<PostLikeBloc>()
                              .likePost(widget.post.id);
                        }
                      } else {
                        if (widget.post.isLiked) {
                          context
                              .read<PostLikeBloc>()
                              .unlikePost(widget.post.id);
                        } else {
                          context
                              .read<PostLikeBloc>()
                              .likePost(widget.post.id);
                        }
                      }
                    }
                  } else {
                    Navigator.pushNamed(context, "/sign_in");
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.share,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () => share(context, widget.post),
              ),
            ],
          )
        ],
      ),
    );
  }
}
