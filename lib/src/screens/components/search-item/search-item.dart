import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class SearchItem extends StatefulWidget {
  final Business business;
  final BuildContext globalNavigator;

  SearchItem({this.business, this.globalNavigator});

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.white10,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 150,
              child: Center(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.business.pictures[0],
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
                      imageUrl: widget.business.pictures[0],
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
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.business.businessName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      if (widget.business.distance != null &&
                          widget.business.distance != 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.business.distance.roundToDouble()}km",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.business.location,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.business.phoneNumber[0],
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
