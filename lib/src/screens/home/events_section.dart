import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class EventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/events");
              },
              child: Text(
                "Events",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 160,
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
      padding: EdgeInsets.only(left: 10, right: 10),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventItem(buildContext: context, event: events[index]);
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
  final Events event;

  const EventItem({Key key, this.buildContext, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      child: GestureDetector(
        onTap: () {
          if (buildContext != null)
            Navigator.pushNamed(buildContext, "/events");
        },
        child: Card(
          elevation: 3,
          shadowColor: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(event?.photos?.elementAt(0) ?? ""),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
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
}
