import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/home/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/home/state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/error-message/error-message.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/home-sliver/category-section.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/home-sliver/events-section.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/home-sliver/home-sliver-appbar.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/home-sliver/posts-section.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/home-sliver/sponsored-posts-section.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/input/custom_button.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/loading/loading.dart';

class Home extends StatefulWidget {
  static const String pathName = "/";
  final BuildContext globalNavigator;

  const Home({Key key, this.globalNavigator}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime dateTime = DateTime.now().subtract(Duration(days: 8));
  ScrollController _scrollController;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (220 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> load() async {
    context.read<EventsBloc>().getEvents(1, 10);
    context
        .read<PostBloc>()
        .getPosts(1, 10, "${dateTime.year}-${dateTime.month}-${dateTime.day}");
    context.read<SponsoredBloc>().getSponsored(5);
    context.read<HomeBloc>().getImages();
  }

  Future<void> _onRefresh() async {
    load();
    await Future.delayed(Duration(milliseconds: 3000), () {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 50.0,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (homeCtx, homeState) {
          if (homeState is HomeLoadSuccessful) {
            return CustomScrollView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                HomeSliverAppBar(
                  images: homeState.images,
                  globalNavigator: widget.globalNavigator,
                  isShrink: isShrink,
                ),
                CategorySection(),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                EventsSection(globalNavigator: widget.globalNavigator),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                PostsSection(globalNavigator: widget.globalNavigator),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/sponsored_posts");
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Sponsored Posts",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chevron_right,
                                      color: Colors.black),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/what_is_new_page");
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SponsoredPostsOverview(globalNavigator: widget.globalNavigator),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: () async {
                            await launch("https://business.zoritt.com");
                          },
                          text: "Add your business",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (homeState is HomeLoading) {
            return Loading();
          } else if (homeState is HomeFailure) {
            return ErrorMessage();
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
