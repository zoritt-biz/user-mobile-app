import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/post_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

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
                // Navigator.pushNamed(context, "/posts");
              },
              child: Text(
                "Posts",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 150,
// <<<<<<< posts
            child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoadSuccessful) {
                    if (state.posts.isNotEmpty) {
                      return body(context, state.posts);
                    } else {
                      return Container(
                        child: Center(child: Text("No recent Posts")),
                      );
                    }
                  }
                  if (state is PostLoadFailure) {
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
  Widget body(BuildContext context,List<Post>posts){
    return  ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 20, right: 20),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          width: 120.0,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/posts",arguments: [posts,index]);
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
                          posts[index]?.photos[0]
                          // "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
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
                        posts[index]?.businessName,
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
    );
  }
  Widget shimmerItem() {
    return Container(
      width: 120.0,
      child: Shimmer.fromColors(
        baseColor:Colors.grey[300],
        highlightColor: Colors.white,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
