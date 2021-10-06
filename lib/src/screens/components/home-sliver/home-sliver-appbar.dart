import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';

class HomeSliverAppBar extends StatelessWidget {
  final List<String> images;
  final BuildContext globalNavigator;
  final bool isShrink;

  const HomeSliverAppBar(
      {Key key, this.images, this.globalNavigator, this.isShrink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 70.0,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CarouselSlider(
              items: images
                  .map((item) =>
                      ClipRRect(child: Image.network(item, fit: BoxFit.fill)))
                  .toList(),
              options: CarouselOptions(
                  autoPlayInterval: Duration(seconds: 10),
                  autoPlay: images.length > 0 ? true : false,
                  viewportFraction: 1,
                  height: double.infinity),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
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
              globalNavigator.read<NavigationBloc>().navigateToSearchDelegate();
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
    );
  }
}
