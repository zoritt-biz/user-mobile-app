import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/user-events/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/user-events/state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/user-posts/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/user-posts/state.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/event-card/event-card.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/post-item/post-item.dart';

class ProfilePage extends StatefulWidget {
  final BuildContext globalNavigator;

  const ProfilePage({Key key, this.globalNavigator}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _tabController;

  File _image;
  final picker = ImagePicker();

  Future compressAndGetFile(String file) async {
    int i = file.lastIndexOf('.');
    String filePath = file.substring(0, i);
    var result = await FlutterImageCompress.compressAndGetFile(
      file,
      filePath + '_compressed.jpg',
      quality: 60,
    );
    File(file).delete();
    setState(() {
      if (result != null) {
        _image = File(result.path);
      }
    });
  }

  Future<String> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return pickedFile.path;
  }

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          TextButton(
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (profileCtx, profileState) {
          if (profileState is ProfileLoadSuccessful) {
            return ListView(
              primary: false,
              padding: EdgeInsets.symmetric(vertical: 15),
              children: [
                GestureDetector(
                  child: _image == null
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: profileState.user.image != null &&
                                      profileState.user.image != ""
                                  ? NetworkImage(profileState.user.image)
                                  : AssetImage("assets/images/user_image.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.add_a_photo_outlined),
                              onPressed: () async =>
                                  compressAndGetFile(await getImage()),
                            ),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(_image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async =>
                                        compressAndGetFile(await getImage()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    profileState.user.firstName +
                        " " +
                        profileState.user.lastName,
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
                if (_image != null) SizedBox(height: 10),
                if (_image != null)
                  Center(
                    child: Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor)),
                        onPressed: () {
                          final profileBloc =
                              BlocProvider.of<ProfileBloc>(context).state;
                          final biz = profileBloc.props.first as User;

                          if (_image != null) {
                            context
                                .read<ProfileBloc>()
                                .addProfileImage(_image, biz);
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).accentColor)),
                      onPressed: () async {
                        await launch("https://business.zoritt.com");
                      },
                      child: Text(
                        "Add your business",
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
                        )..getUserPosts(),
                        child: BlocBuilder<UserPostsBloc, UserPostsState>(
                            builder: (postsCtx, postsState) {
                          if (postsState is UserPostsSuccessful) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              child: PostItems(
                                buildContext: widget.globalNavigator,
                                posts: postsState.posts,
                                isVertical: true,
                              ),
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
                        )..getUserEvents(),
                        child: BlocBuilder<UserEventsBloc, UserEventsState>(
                          builder: (eventsCtx, eventsState) {
                            if (eventsState is UserEventsSuccessful) {
                              return ListView(
                                primary: true,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 5),
                                children: [
                                  ListView.builder(
                                    itemCount: eventsState.events.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, index) {
                                      return BlocProvider<EventsLikeBloc>(
                                        create: (context) => EventsLikeBloc(
                                          eventRepository:
                                              context.read<EventsRepository>(),
                                        ),
                                        child: EventCard(
                                          events: eventsState.events[index],
                                          context: context,
                                          globalNavigator:
                                              widget.globalNavigator,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else if (eventsState is UserEventsLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Center(child: Text('BookMarks'));
                            }
                          },
                        ),
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
