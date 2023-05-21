import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/event-card/event-card.dart';

class EventsPage extends StatelessWidget {
  final BuildContext globalNavigator;

  const EventsPage({Key key, @required this.globalNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Events")),
      body: BlocConsumer<EventsBloc, EventsState>(
        builder: (eventCtx, state) {
          if (state is EventsLoadSuccessful) {
            if (state.events.isNotEmpty) {
              return body(state.events, globalNavigator);
            } else if (state is EventsLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Text("No Events"),
              );
            }
          }

          // if (state is EventsLoadFailure) {
          //   return Center(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text("Something went wrong"),
          //         TextButton(
          //           onPressed: () {
          //             context
          //                 .read<EventsBloc>()
          //                 .getEvents(10, "CREATEDAT_DESC");
          //           },
          //           child: Text("Retry"),
          //         ),
          //       ],
          //     ),
          //   );
          // }
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
              events: events[index],
              context: context,
              globalNavigator: globalNavigator,
            ),
          ),
        ),
      ],
    );
  }
}
