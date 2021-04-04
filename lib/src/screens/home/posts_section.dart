import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsSection extends StatelessWidget {
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
                Navigator.pushNamed(context, "/posts");
              },
              child: Text(
                "Posts",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 8, right: 8),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  width: 120.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/posts");
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Here",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
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
