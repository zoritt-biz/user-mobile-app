import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events_like_bloc/events_like_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/profile_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/profile_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/user_events_bloc/user_events_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/user_events_bloc/user_events_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/user_posts_bloc/user_posts_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/user_posts_bloc/user_posts_state.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/events_page/events_page.dart';
import 'package:zoritt_mobile_app_user/src/screens/home/posts_section.dart';

class ProfilePage extends StatefulWidget {
  final String firebaseId;
  final String userId;
  final BuildContext globalNavigator;

  const ProfilePage(
      {Key key, this.firebaseId, this.userId, this.globalNavigator})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
              child: Text("Logout"))
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (profileCtx, profileState) {
          if (profileState is ProfileLoadSuccessful) {
            return ListView(
              primary: false,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/user_image.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    profileState.user.fullName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Text(
                    profileState.user.email,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.grey[600],
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (await canLaunch("https://zoritt-app.web.app/"))
                          await launch("https://zoritt-app.web.app/");
                      },
                      child: Text(
                        "Add your business",
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.grey[400],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocProvider(
                        create: (context) => UserPostsBloc(
                          context.read<UserRepository>(),
                        )..getUserPosts(widget.firebaseId),
                        child: BlocBuilder<UserPostsBloc, UserPostsState>(
                            builder: (postsCtx, postsState) {
                          if (postsState is UserPostsSuccessful) {
                            return PostItems(
                              buildContext: widget.globalNavigator,
                              posts: postsState.posts,
                              isVertical: true,
                            );
                          } else if (postsState is UserPostsLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(child: Text('Likes'));
                          }
                        }),
                      ),
                      BlocProvider(
                        create: (context) => UserEventsBloc(
                          context.read<UserRepository>(),
                        )..getUserEvents(widget.firebaseId),
                        child: BlocBuilder<UserEventsBloc, UserEventsState>(
                            builder: (eventsCtx, eventsState) {
                          if (eventsState is UserEventsSuccessful) {
                            return ListView(
                              primary: true,
                              children: [
                                ListView.builder(
                                  itemCount: eventsState.events.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx, index) =>
                                      BlocProvider<EventsLikeBloc>(
                                    create: (context) => EventsLikeBloc(
                                      eventRepository:
                                          context.read<EventsRepository>(),
                                    ),
                                    child: EventCard(
                                      events: eventsState.events[index],
                                      context: context,
                                      userId: widget.userId,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (eventsState is UserEventsLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(child: Text('BookMarks'));
                          }
                        }),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
