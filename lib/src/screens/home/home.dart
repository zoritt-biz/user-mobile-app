import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/navigation_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
  DateTime dateTime = DateTime.now().subtract(Duration(days: 5));
  ScrollController _scrollController;
  bool lastStatus = true;
  int _current = 0;

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
    context.read<EventsBloc>().getEvents(10, "CREATEDAT_DESC");
    context.read<PostBloc>().getPosts(10, "CREATEDAT_DESC",
        "${dateTime.year}/${dateTime.month}/${dateTime.day}", 0);
    context.read<SponsoredBloc>().getSponsored(5);
  }

  Future<void> _onRefresh() async {
    load();
    await Future.delayed(Duration(milliseconds: 3000), () {});
  }

  final List<Widget> imageSliders = [
    "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"
  ]
      .map((item) => ClipRRect(child: Image.network(item, fit: BoxFit.fill)))
      .toList();

  @override
  Widget build(BuildContext context) {
    final TextStyle headline3 = Theme.of(context).textTheme.headline3;
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 50.0,
      child: CustomScrollView(
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
                    items: imageSliders,
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 7),
                      autoPlay: true,
                      viewportFraction: 1,
                      height: double.infinity,
                      onPageChanged: (index, reason) {
                        setState(
                          () {
                            _current = index;
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 80),
                      child: Text(
                        "You can find anything on Zorit",
                        style: GoogleFonts.montserrat(
                          textStyle: headline3,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
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
          EventsSection(),
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
                child: Text(
                  "Sponsored Posts",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
          ),
          SponsoredPostsOverview(globalNavigator: widget.globalNavigator),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(10),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).accentColor)),
                  onPressed: () {
                    Navigator.pushNamed(context, "/sponsored_posts");
                  },
                  child: Text(
                    "See More",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (await canLaunch("https://zoritt-app.web.app/"))
                        await launch("https://zoritt-app.web.app/");
                    },
                    child: Text(
                      "Add your business",
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
