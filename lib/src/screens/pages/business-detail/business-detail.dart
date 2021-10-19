import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-detail/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-like/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/pop-up/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/pop-up/state.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/business-detail/detail.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/error-message/error-message.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/loading/loading.dart';

import '../../../bloc/related_businesses/related_businesses_bloc.dart';
import '../../../models/filter.dart';
import '../../../repository/business/business_repository.dart';

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
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopUpBloc, PopUpState>(
      listener: (popUpCtx, popUpState) {
        if (popUpState is PopUpLoadSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              barrierColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (ctx) => Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: MaterialStateProperty.all(CircleBorder()),
                        ),
                        child: Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Card(
                      elevation: 3,
                      clipBehavior: Clip.hardEdge,
                      shadowColor: Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        height: 130,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: popUpState.popUp.image,
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
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }
      },
      child: BlocBuilder<BusinessDetailBloc, BusinessDetailState>(
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
      ),
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
                              if (bizState is! BusinessLiking &&
                                  bizState is! BusinessUnliking) {
                                if (localChange) {
                                  if (value) {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .unlikeBusiness(widget.id);
                                  } else {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .likeBusiness(widget.id);
                                  }
                                } else {
                                  if (business.isLiked) {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .unlikeBusiness(widget.id);
                                  } else {
                                    context
                                        .read<BusinessLikeBloc>()
                                        .likeBusiness(widget.id);
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
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlayInterval: Duration(seconds: 10),
                          autoPlay: business.pictures.length > 1 ? true : false,
                          viewportFraction: 1,
                          height: double.infinity,
                        ),
                        items: business.pictures
                            .map(
                              (item) => ClipRRect(
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
                                        filter: ImageFilter.blur(
                                            sigmaY: 2, sigmaX: 2),
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
                            )
                            .toList(),
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
              phoneNumber: business.phoneNumbers[0],
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
            BlocProvider<RelatedBusinessesBloc>(
              create: (ctx) => RelatedBusinessesBloc(
                businessRepository: context.read<BusinessRepository>(),
              )..getRelatedBusinesses(
                  new Filter(category: [business.categories[0].name]),
                  1,
                  15,
                  business.businessName,
                ),
              child: RelatedBusiness(business.businessName),
            )
          ],
        ),
      ),
    );
  }
}
