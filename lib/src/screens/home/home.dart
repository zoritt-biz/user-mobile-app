import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/NavigationBloc.dart';

import 'category_section.dart';
import 'events_section.dart';
import 'posts_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<void> load() async {
    context.read<EventsBloc>().getEvents(10, "CREATEDAT_DESC");
    context.read<PostBloc>().getPosts(10, "CREATEDAT_DESC", "${dateTime.year}/${dateTime.month}/${dateTime.day}", 0);
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
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
              pinned: true,
              toolbarHeight: 70.0,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                  fit: BoxFit.cover,
                ),
                titlePadding: EdgeInsets.all(15),
                title: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextField(
                    cursorRadius: Radius.circular(20),
                    autofocus: false,
                    readOnly: true,
                    onTap: () {
                      print("tapped");
                      context.read<NavigationBloc>().navigateToSearch();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              )),
          CategorySection(),
          EventsSection(),
          PostsSection(globalNavigator: widget.globalNavigator),
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
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(15),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    Navigator.pushNamed(context, "/sponsored_posts");
                  },
                  child: Text(
                    "See More",
                    style: TextStyle(fontSize: 18),
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
