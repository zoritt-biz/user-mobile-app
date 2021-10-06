import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-detail/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/user/user_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/business-detail/detail.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/error-message/error-message.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/loading/loading.dart';

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

    context.read<BusinessDetailBloc>().getBusinessDetail(widget.id);

    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showModalBottomSheet(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(20),
    //         topRight: Radius.circular(20),
    //       ),
    //     ),
    //     // isDismissible: false,
    //     barrierColor: Colors.transparent,
    //     backgroundColor: Colors.transparent,
    //     context: context,
    //     builder: (ctx) => Padding(
    //       padding: EdgeInsets.all(10),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Align(
    //               alignment: Alignment.centerRight,
    //               child: ElevatedButton(
    //                 style: ButtonStyle(
    //                   backgroundColor: MaterialStateProperty.all(Colors.white),
    //                   padding: MaterialStateProperty.all(EdgeInsets.zero),
    //                   shape: MaterialStateProperty.all(CircleBorder()),
    //                 ),
    //                 child: Icon(Icons.close, color: Colors.black),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //               )),
    //           Card(
    //             elevation: 3,
    //             clipBehavior: Clip.hardEdge,
    //             shadowColor: Colors.white24,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(12),
    //             ),
    //             child: Image.asset("assets/images/images.jfif"),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // });
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
          return Loading();
        } else {
          return ErrorMessage(
            onPressed: () => {
              context.read<BusinessDetailBloc>().getBusinessDetail(widget.id)
            },
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
        backgroundColor: Colors.grey[100],
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
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.1),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BusinessAddress(
              businessName: business.businessName,
              slogan: business.slogan,
              time: business.openHours,
              phoneNumber: business.phoneNumber[0],
              website: business.website,
              location: business.location,
              latLng: LatLng(
                business.lat,
                business.lng,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            SliverToBoxAdapter(
              child: BusinessLocation(
                latLng: LatLng(business.lat, business.lng),
                locationDescription: business.location,
                branches: business.branches,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            BusinessInfo(business: business),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            BusinessEvent(events: business.events),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            BusinessPost(posts: business.posts, globalNavigator: context),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            BusinessMedia(pictures: business.pictures),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            // BlocProvider<RelatedBusinessesBloc>(
            //   create: (ctx) => RelatedBusinessesBloc(
            //     businessRepository: context.read<BusinessRepository>(),
            //   )..getRelatedBusinesses(
            //       category: [business.categories[0].name], skipId: business.id),
            //   child: RelatedBusiness(),
            // )
          ],
        ),
      ),
    );
  }
}
