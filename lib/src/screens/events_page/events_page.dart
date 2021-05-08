import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events_like_bloc/events_like_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events_like_bloc/events_like_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';

class EventsPage extends StatelessWidget {
  final BuildContext globalNavigator;
  final String userId;

  const EventsPage({Key key, this.globalNavigator, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocConsumer<EventsBloc, EventsState>(
        builder: (eventCtx, state) {
          if (state is EventsLoadSuccessful) {
            if (state.events.isNotEmpty) {
              return body(state.events, globalNavigator);
            } else {
              return Center(
                child: Text("No Events"),
              );
            }
          }
          if (state is EventsLoadFailure) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Something went wrong"),
                  TextButton(
                    onPressed: () {
                      context
                          .read<EventsBloc>()
                          .getEvents(10, "CREATEDAT_DESC");
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget body(List<Events> events, BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child: Text(
            'All Events',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          itemCount: events.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) => BlocProvider<EventsLikeBloc>(
            create: (context) => EventsLikeBloc(
              eventRepository: context.read<EventsRepository>(),
            ),
            child: EventCard(
                events: events[index], context: context, userId: userId),
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatefulWidget {
  final Events events;
  final BuildContext context;
  final String userId;

  EventCard({@required this.events, this.context, this.userId});

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
            child: Image.network(
              item,
              fit: BoxFit.fill,
              width: double.infinity,
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
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlay: false,
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
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                widget.events.logoPics != null &&
                                        widget.events.logoPics != ""
                                    ? widget.events.logoPics
                                    : "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                                scale: 1,
                              )),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.events.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 2),
                              Text(widget.events.location)
                            ],
                          )
                        ],
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
                                  if(eventState is !EventsLiking && eventState is !EventsUnliking){
                                    if (localChange) {
                                      if (value) {
                                        context
                                            .read<EventsLikeBloc>()
                                            .unlikeEvent(widget.userId,
                                                widget.events.id);
                                      } else {
                                        context
                                            .read<EventsLikeBloc>()
                                            .likeEvent(widget.userId,
                                                widget.events.id);
                                      }
                                    } else {
                                      if (widget.events.isInterested) {
                                        context
                                            .read<EventsLikeBloc>()
                                            .unlikeEvent(widget.userId,
                                                widget.events.id);
                                      } else {
                                        context
                                            .read<EventsLikeBloc>()
                                            .likeEvent(widget.userId,
                                                widget.events.id);
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
                                )
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
                                "Feb 02, 2021",
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
                                "Feb 05, 2021",
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
