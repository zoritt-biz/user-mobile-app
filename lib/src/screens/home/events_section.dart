import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class EventsSection extends StatelessWidget {
  final BuildContext globalNavigator;

  const EventsSection({Key key, @required this.globalNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/events");
              },
              child: Row(
                children: [
                  Text(
                    "Events",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, color: Colors.black),
                    onPressed: () {
                      Navigator.pushNamed(context, "/events");
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 180,
            child: BlocBuilder<EventsBloc, EventsState>(
              builder: (context, state) {
                if (state is EventsLoadSuccessful) {
                  if (state.events.isNotEmpty) {
                    return body(context, state.events);
                  } else {
                    return Container(
                      child: Center(child: Text("No recent Events")),
                    );
                  }
                } else {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(child: shimmerItem()),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(child: shimmerItem()),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(child: shimmerItem()),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context, List<Events> events) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventItem(
            buildContext: context,
            event: events[index],
            globalNavigator: globalNavigator);
      },
    );
  }

  Widget shimmerItem() {
    return Container(
      width: 140.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey,
                  ),
                  height: 15,
                  width: 80,
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final BuildContext buildContext;
  final BuildContext globalNavigator;
  final Events event;

  const EventItem(
      {Key key, this.buildContext, this.event, this.globalNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      child: GestureDetector(
        onTap: () {
          showEventDialog(context);
        },
        child: Card(
          elevation: 3,
          clipBehavior: Clip.hardEdge,
          shadowColor: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                child: ClipRect(
                  child: Center(
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: event.photos[0],
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
                          imageUrl:event.photos[0],
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
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 6),
                child: Text(
                  event.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 10,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Text(
                        event.location,
                        style: TextStyle(color: Colors.grey[400], fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showEventDialog(BuildContext context){
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      barrierDismissible: true,
      barrierLabel: event.title,
      builder: (BuildContext context) {
        return Stack(
          children: [
            CachedNetworkImage(
              imageUrl: event.photos[0],
              placeholder: (context, url) {
                return Container(
                  color: Colors.black,
                  child: Center(child: CircularProgressIndicator()),
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 30, horizontal: 15),
              child: Text(
                event.title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    if (event.link != "")
                      TextButton(
                        onPressed: () async {
                          await launch(event.link);
                        },
                        child: Text(
                          event.link,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    if (event.link != "") const SizedBox(height: 10.0),
                    Text(
                      event.location,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          globalNavigator,
                          "/business_detail",
                          arguments: [event.owner],
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: NetworkImage(
                              event.businessLogo != null &&
                                  event.businessLogo != ""
                                  ? event.businessLogo
                                  : "https://firebasestorage.googleapis.com/v0/b/zoritt-app.appspot.com/o/ic_launcher.jpg?alt=media&token=37ef2fe4-bf31-43e4-87ca-9bab1b724483",
                              scale: 1,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.businessName ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  event.description ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
