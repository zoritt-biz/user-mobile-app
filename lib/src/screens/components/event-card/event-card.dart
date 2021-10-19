import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events-like/state.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';

class EventCard extends StatefulWidget {
  final Events events;
  final BuildContext context;
  final BuildContext globalNavigator;

  EventCard({
    @required this.events,
    this.context,
    this.globalNavigator,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  int _current = 0;
  bool localChange = false;
  bool value = false;

  void share(BuildContext context, Events events) {
    String subject =
        "${events.title} \n ${events.description} \n ${events.link} ";
    Share.share(subject, subject: events.description);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.events.photos
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
    return BlocConsumer<EventsLikeBloc, EventsLikeState>(
      listener: (eventBloc, eventState) {
        if (eventState is EventsLikingSuccessful) {
          setState(() {
            localChange = true;
            value = true;
          });
        } else if (eventState is EventsUnlikingSuccessful) {
          setState(() {
            localChange = true;
            value = false;
          });
        }
      },
      builder: (eventBloc, eventState) => Padding(
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
                                imageUrl: widget.events.photos[_current],
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
                    children: widget.events.photos.map(
                      (url) {
                        int index = widget.events.photos.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
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
                    left: 10, top: 15, bottom: 10, right: 10),
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
                            arguments: [widget.events.owner],
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  widget.events.businessLogo != null &&
                                          widget.events.businessLogo != ""
                                      ? widget.events.businessLogo
                                      : "https://firebasestorage.googleapis.com/v0/b/zoritt-app.appspot.com/o/ic_launcher.jpg?alt=media&token=37ef2fe4-bf31-43e4-87ca-9bab1b724483",
                                  scale: 1,
                                )),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.events.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 2),
                                  Text(widget.events.location)
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
                                        ? Icons.bookmark_rounded
                                        : Icons.bookmark_border_rounded
                                    : widget.events.isInterested
                                        ? Icons.bookmark_rounded
                                        : Icons.bookmark_border_rounded,
                                color: Colors.orange,
                                size: 30,
                              ),
                              onPressed: () {
                                if (context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .status ==
                                    AuthenticationStatus.authenticated) {
                                  if (eventState is! EventsLiking &&
                                      eventState is! EventsUnliking) {
                                    if (localChange) {
                                      if (value) {
                                        context
                                            .read<EventsLikeBloc>()
                                            .unlikeEvent(widget.events.id);
                                      } else {
                                        context
                                            .read<EventsLikeBloc>()
                                            .likeEvent(widget.events.id);
                                      }
                                    } else {
                                      if (widget.events.isInterested) {
                                        context
                                            .read<EventsLikeBloc>()
                                            .unlikeEvent(widget.events.id);
                                      } else {
                                        context
                                            .read<EventsLikeBloc>()
                                            .likeEvent(widget.events.id);
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
                              onTap: () => share(context, widget.events),
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
                          child: RichText(
                            text: TextSpan(
                              text: widget.events.description,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(text: "  "),
                                TextSpan(
                                    text: widget.events.link,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launch(widget.events.link);
                                      }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                widget.events.startDate.split("T")[0],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                widget.events.endDate.split("T")[0],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            widget.events.businessName,
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
