import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_detail/business_detail_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_detail/business_detail_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/related_businesses/related_businesses_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

import 'business_adress.dart';
import 'business_events.dart';
import 'business_info.dart';
import 'business_location.dart';
import 'business_media.dart';
import 'business_posts.dart';
import 'related_businesses.dart';

class BusinessDetail extends StatefulWidget {
  static const String pathName = "/business_detail";

  @override
  _BusinessDetailState createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  ScrollController _scrollController;
  bool lastStatus = true;

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
          return body(bizState.business);
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget body(Business business) {
    return Scaffold(
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
                    Icon(
                      Icons.favorite_border_outlined,
                      color: isShrink ? Colors.black : Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.share_outlined,
                      color: isShrink ? Colors.black : Colors.white,
                    ),
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(business.pictures[0]),
                        fit: BoxFit.cover,
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
            name: business.slogan != null ? business.slogan : "",
            time: '9:00 AM - 6:00 PM',
            localTime: true,
            phoneNumber: business.phoneNumber[0],
            website: business.website,
            location: business.location,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          BusinessLocation(
            imageLink:
                "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
            address1: business.location,
            address2: 'Ethiopia',
            address3: 'አዲስ አበባ',
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
            )..getRelatedBusinesses(category: business.categories[0].parent, skipId: business.id),
            child: RelatedBusiness(),
          )
        ],
      ),
    );
  }
}
