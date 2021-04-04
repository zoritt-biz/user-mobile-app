import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 8, right: 8),
              itemCount: 4,
              itemBuilder: (context, index) {
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
                                  "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
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
                            child: Text("Event title"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_rounded, size: 10, color: Colors.grey[400],),
                                Text("Event location", style: TextStyle(color: Colors.grey[400], fontSize: 13),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
