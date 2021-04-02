import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class EventsPage extends StatelessWidget {
  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
        body: BlocConsumer<EventsBloc, EventsState>(
          builder: (context, state) {
            if (state is EventsLoadSuccessful) {
              if (state.events.isNotEmpty) {
                return body(state.events, context);
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
              ));
            }
            return Center(child: CircularProgressIndicator());
          },
          listener: (context, state) {},
        ));
  }

  Widget body(List<Events> events, BuildContext context) {
    return ListView(children: [
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
          itemBuilder: (context, index) => EventCard(events: events[index])),
    ]);
  }
}

class EventCard extends StatefulWidget {
  final Events events;

  EventCard({@required this.events});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  // final List<String> imgList = [
  //   "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  // ];
  int _current = 0;

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Stack(alignment: Alignment.bottomCenter, children: [
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlay: true,
                  viewportFraction: 1,
                  // enlargeCenterPage: true,
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
                children: widget.events.photos.map((url) {
                  int index = widget.events.photos.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Colors.amber : Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ]),
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
                            backgroundImage: NetworkImage(widget.events.logoPics??
                                "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80")),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.events.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(widget.events.location)
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.orange,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.share, size: 25)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 15, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: widget.events.description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' See More',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 15),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('See More clicked');
                                  // navigate to desired screen
                                })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
