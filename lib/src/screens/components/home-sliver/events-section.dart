import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/event-item/event-item.dart';

class EventsSection extends StatelessWidget {
  final BuildContext globalNavigator;

  const EventsSection({Key key, @required this.globalNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
      ),
    );
  }

  Widget body(BuildContext context, List<Events> events) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
