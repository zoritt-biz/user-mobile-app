import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';
import 'package:zoritt_mobile_app_user/src/screens/home/events_section.dart';

class BusinessEvent extends StatelessWidget {
  final List<Events> events;

  const BusinessEvent({Key key, this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'Events',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              events.length > 0
                  ? Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return EventItem(
                            buildContext: null,
                            event: events[index],
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Icon(FontAwesomeIcons.tasks),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sorry, There is no events in this business',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
