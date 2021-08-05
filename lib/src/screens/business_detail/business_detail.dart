import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_detail/business_detail_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_detail/business_detail_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_like_bloc/business_like_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_like_bloc/business_like_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/related_businesses/related_businesses_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/user/user_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

import 'business_address.dart';
import 'business_events.dart';
import 'business_info.dart';
import 'business_location.dart';
import 'business_media.dart';
import 'business_posts.dart';
import 'related_businesses.dart';

class BusinessDetail extends StatefulWidget {
  static const String pathName = "/business_detail";
  final String id;

  const BusinessDetail({Key key, this.id}) : super(key: key);

  @override
  _BusinessDetailState createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  ScrollController _scrollController;
  bool lastStatus = true;
  bool localChange = false;
  bool value = false;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (220 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    if (context.read<AuthenticationBloc>().state.status ==
        AuthenticationStatus.authenticated) {
      context.read<BusinessDetailBloc>().getBusinessesLoggedIn(
          widget.id, (context.read<UserBloc>().state.props.first as User).id);
    } else {
      context.read<BusinessDetailBloc>().getBusinessDetail(widget.id);
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessDetailBloc, BusinessDetailState>(
      builder: (bizCtx, bizState) {
        if (bizState is BusinessDetailLoadSuccess) {
          return body(context, bizState.business);
        } else if (bizState is BusinessDetailLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Connection error. Please"),
                  TextButton(
                    onPressed: () {
                      if (context.read<AuthenticationBloc>().state.status ==
                          AuthenticationStatus.authenticated) {
                        context
                            .read<BusinessDetailBloc>()
                            .getBusinessesLoggedIn(
                                widget.id,
                                (context.read<UserBloc>().state.props.first
                                        as User)
                                    .id);
                      } else {
                        context
                            .read<BusinessDetailBloc>()
                            .getBusinessDetail(widget.id);
                      }
                    },
                    child: Text("Retry!"),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget body(BuildContext context, Business business) {
    return BlocConsumer<BusinessLikeBloc, BusinessLikeState>(
      listener: (bizBloc, bizState) {
        if (bizState is BusinessLikingSuccessful) {
          setState(() {
            localChange = true;
            value = true;
          });
        } else if (bizState is BusinessUnlikingSuccessful) {
          setState(() {
            localChange = true;
            value = false;
          });
        }
      },
      builder: (bizBloc, bizState) => Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              foregroundColor: Colors.grey,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: isShrink ? Colors.black : Colors.white,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            localChange
                                ? value
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined
                                : business.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            if (context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .status ==
                                AuthenticationStatus.authenticated) {
                              var userId = (context
                                      .read<UserBloc>()
                                      .state
                                      .props
                                      .first as User)
                                  .id;

                              if (bizState is! BusinessLiking &&
                                  bizState is! BusinessUnliking) {
                                if (localChange) {
                                  if (value) {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .unlikeBusiness(userId, widget.id);
                                  } else {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .likeBusiness(userId, widget.id);
                                  }
                                } else {
                                  if (business.isLiked) {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .unlikeBusiness(userId, widget.id);
                                  } else {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .likeBusiness(userId, widget.id);
                                  }
                                }
                              }
                            } else {
                              Navigator.pushNamed(context, "/sign_in");
                            }
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      // Icon(
                      //   Icons.share_outlined,
                      //   color: isShrink
                      //       ? Colors.black
                      //       : Colors.white,
                      // ),
                    ],
                  ),
                ),
              ],
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      child: Center(
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: business.pictures[0],
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                            BackdropFilter(
                              child: Container(
                                color: Colors.white10,
                              ),
                              filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                            ),
                            CachedNetworkImage(
                              imageUrl: business.pictures[0],
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.1),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                title: Padding(
                  padding: isShrink
                      ? EdgeInsets.only(bottom: 0)
                      : EdgeInsets.only(bottom: 10),
                  child: Text(
                    business.businessName,
                    style: TextStyle(
                      color: isShrink ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            BusinessAddress(
              slogan: business.slogan,
              time: business.openHours,
              phoneNumber: business.phoneNumber[0],
              website: business.website,
              location: business.location,
              latLng: LatLng(business.lat, business.lng),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            BusinessLocation(
              latLng: LatLng(business.lat, business.lng),
              locationDescription: business.location,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            BusinessInfo(business: business),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            BusinessEvent(events: business.events),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            BusinessPost(posts: business.posts, globalNavigator: context),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            BusinessMedia(pictures: business.pictures),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            BlocProvider<RelatedBusinessesBloc>(
              create: (ctx) => RelatedBusinessesBloc(
                businessRepository: context.read<BusinessRepository>(),
              )..getRelatedBusinesses(
                  category: [business.categories[0].name], skipId: business.id),
              child: RelatedBusiness(),
            )
          ],
        ),
      ),
    );
  }
}
