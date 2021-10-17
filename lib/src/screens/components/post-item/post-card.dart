import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post-like/state.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final BuildContext context;
  final BuildContext globalNavigator;
  final String userId;

  PostCard({
    @required this.post,
    this.context,
    this.userId,
    this.globalNavigator,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _current = 0;
  bool localChange = false;
  bool value = false;

  void share(BuildContext context, Post post) {
    String subject = "${post.description} ";
    Share.share(subject, subject: post.description);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.post.photos
        .map(
          (item) => ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            child: Center(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: item,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    child: Container(
                      color: Colors.white10,
                    ),
                    filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                  ),
                  CachedNetworkImage(
                    imageUrl: item,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return BlocConsumer<PostLikeBloc, PostLikeState>(
      listener: (postBloc, postState) {
        if (postState is PostLikingSuccessful) {
          setState(() {
            localChange = true;
            value = true;
          });
        } else if (postState is PostUnlikingSuccessful) {
          setState(() {
            localChange = true;
            value = false;
          });
        }
      },
      builder: (postBloc, postState) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Card(
          elevation: 1,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.8),
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.post.photos[_current],
                                placeholder: (context, url) {
                                  return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                                imageBuilder: (context, imageProvider) {
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
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CarouselSlider(
                      items: imageSliders,
                      options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        disableCenter: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(
                            () {
                              _current = index;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: widget.post.photos.map(
                      (url) {
                        int index = widget.post.photos.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 2.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _current == index ? Colors.amber : Colors.white,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 15,
                  bottom: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            widget.globalNavigator,
                            "/business_detail",
                            arguments: [widget.post.owner],
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                widget.post.businessLogo != null &&
                                        widget.post.businessLogo != ""
                                    ? widget.post.businessLogo
                                    : "https://firebasestorage.googleapis.com/v0/b/zoritt-app.appspot.com/o/ic_launcher.jpg?alt=media&token=37ef2fe4-bf31-43e4-87ca-9bab1b724483",
                                scale: 1,
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.post.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 2),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: Icon(
                                localChange
                                    ? value
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded
                                    : widget.post.isLiked
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                color: Colors.orange,
                                size: 30,
                              ),
                              onPressed: () {
                                if (context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .status ==
                                    AuthenticationStatus.authenticated) {
                                  if (postState is! PostLiking &&
                                      postState is! PostUnliking) {
                                    if (localChange) {
                                      if (value) {
                                        context.read<PostLikeBloc>().unlikePost(
                                            widget.userId, widget.post.id);
                                      } else {
                                        context.read<PostLikeBloc>().likePost(
                                            widget.userId, widget.post.id);
                                      }
                                    } else {
                                      if (widget.post.isLiked) {
                                        context.read<PostLikeBloc>().unlikePost(
                                            widget.userId, widget.post.id);
                                      } else {
                                        context.read<PostLikeBloc>().likePost(
                                            widget.userId, widget.post.id);
                                      }
                                    }
                                  }
                                } else {
                                  Navigator.pushNamed(
                                      widget.context, "/sign_in");
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              child: Icon(Icons.share, size: 25),
                              onTap: () => share(context, widget.post),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 15, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.post.description,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 15)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            widget.post.businessName,
                            style: TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
