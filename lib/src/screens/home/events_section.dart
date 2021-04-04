import 'package:flutter/cupertino.dart';
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
                )),
          ),
          Container(
            height: 160,
// <<<<<<< posts
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
                  }
                  if (state is EventsLoadFailure) {
                    print("loadfail");
                  //   return Padding(padding:EdgeInsets.only(left: 20,right:20),
                  // child: Shimmer.fromColors(child: Row(
                  //   children: [
                  //     eventItem(context, new Events()),
                  //     eventItem(context, new Events()),
                  //     eventItem(context, new Events()),
                  //     eventItem(context, new Events()),
                  //   ],
                  // ), baseColor:Colors.grey[300],
                  //     highlightColor: Colors.grey[100],
                  // )
                  // );
                }
                  return Padding(padding:EdgeInsets.only(left: 20,right:20),
                      child:Row(
                        children: [
                          Expanded(child:shimmerItem()),
                          SizedBox(width: 5,),
                          Expanded(child:shimmerItem()),
                          SizedBox(width: 5,),
                          Expanded(child:shimmerItem()),

                        ],
                      ),

                  );

                }
                ),

          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context, List<Events>events) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,

      padding: EdgeInsets.only(left: 20, right: 20),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return eventItem(context, events[index]);
      },
    );
  }

  Widget eventItem(BuildContext context, Events event) {
    return Container(
      width: 140.0,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/events");
        },
        child: Card(
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
                    image: NetworkImage(
                        event?.photos?.elementAt(0)??""
                      // "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                    ),
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
                child: Text(event.title),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: 10,
                      color: Colors.grey[400],),
                    Text(event.location,
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget shimmerItem() {
    return Container(
      width: 140.0,
      child: Shimmer.fromColors(

        baseColor:Colors.grey[300],
        highlightColor: Colors.white,

        child: Container(


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  height: 15 ,
                  width: 80,
                  color: Colors.grey,
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
