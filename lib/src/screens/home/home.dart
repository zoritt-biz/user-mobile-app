import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/home/home_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/home/home_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/navigation_bloc.dart';

import 'category_section.dart';
import 'events_section.dart';
import 'posts_section.dart';
import 'sponsored_posts_overview.dart';

class Home extends StatefulWidget {
  static const String pathName = "/home";
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
    context.read<EventsBloc>().getEvents(10, "CREATEDAT_DESC",
        "${dateTime.year}-${dateTime.month}-${dateTime.day}");
    context.read<PostBloc>().getPosts(10, "CREATEDAT_DESC",
        "${dateTime.year}-${dateTime.month}-${dateTime.day}", 0);
    context.read<SponsoredBloc>().getSponsored(5);
    context.read<HomeBloc>().getImages();
  }

  Future<void> _onRefresh() async {
    load();
    await Future.delayed(Duration(milliseconds: 3000), () {});
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headline3 = Theme.of(context).textTheme.headline3;
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
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 70.0,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CarouselSlider(
                          items: homeState.images
                              .map((item) => ClipRRect(
                                  child: Image.network(item, fit: BoxFit.fill)))
                              .toList(),
                          options: CarouselOptions(
                              autoPlayInterval: Duration(seconds: 10),
                              autoPlay:
                                  homeState.images.length > 0 ? true : false,
                              viewportFraction: 1,
                              height: double.infinity),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        //   child: Container(
                        //     padding: EdgeInsets.only(
                        //         left: 20, right: 20, bottom: 80),
                        //     child: Text(
                        //       "You can find anything on Zoritt",
                        //       style: GoogleFonts.montserrat(
                        //         textStyle: headline3,
                        //         color: Colors.grey[200],
                        //         fontWeight: FontWeight.w900,
                        //         fontSize: 40,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    titlePadding: EdgeInsets.all(15),
                    title: Container(
                      height: isShrink ? 40 : 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: TextField(
                        cursorRadius: Radius.circular(20),
                        autofocus: false,
                        readOnly: true,
                        onTap: () {
                          widget.globalNavigator
                              .read<NavigationBloc>()
                              .navigateToSearchDelegate();
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(
                            Icons.search,
                            size: isShrink ? 25.0 : 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CategorySection(),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                EventsSection(globalNavigator: widget.globalNavigator),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                PostsSection(globalNavigator: widget.globalNavigator),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/sponsored_posts");
                      },
                      style: ButtonStyle(alignment: Alignment.centerLeft),
                      child: Row(
                        children: [
                          Text(
                            "Sponsored Posts",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          IconButton(
                            icon:
                                Icon(Icons.chevron_right, color: Colors.black),
                            onPressed: () {
                              Navigator.pushNamed(context, "/sponsored_posts");
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SponsoredPostsOverview(globalNavigator: widget.globalNavigator),
                // BlocBuilder<SponsoredBloc, SponsoredState>(
                //   builder: (sponsoredCtx, sponsoredState) {
                //     if (sponsoredState is SponsoredLoadSuccess) {
                //       if (sponsoredState.sponsored.isNotEmpty) {
                //         return SliverToBoxAdapter(
                //           child: Padding(
                //             padding: const EdgeInsets.symmetric(vertical: 20),
                //             child: Center(
                //               child: TextButton(
                //                 style: ButtonStyle(
                //                   padding: MaterialStateProperty.all<
                //                       EdgeInsetsGeometry>(
                //                     EdgeInsets.all(10),
                //                   ),
                //                 ),
                //                 onPressed: () {
                //                   Navigator.pushNamed(
                //                       context, "/sponsored_posts");
                //                 },
                //                 child: Text(
                //                   "See More",
                //                   style: TextStyle(fontSize: 16),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         );
                //       } else {
                //         return SliverToBoxAdapter(child: Container());
                //       }
                //     } else {
                //       return SliverToBoxAdapter(child: Container());
                //     }
                //   },
                // ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(15),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).accentColor),
                          ),
                          onPressed: () async {
                            await launch(
                                "https://business.zoritt.com");
                          },
                          child: Text(
                            "Add your business",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (homeState is HomeLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Connection error. Please"),
                    TextButton(
                      child: Text("Retry!"),
                      onPressed: () {
                        load();
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
