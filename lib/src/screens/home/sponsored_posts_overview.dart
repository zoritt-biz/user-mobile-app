import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/sponsored_business/sponsored_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class SponsoredPostsOverview extends StatelessWidget {
  final BuildContext globalNavigator;

  const SponsoredPostsOverview({Key key, this.globalNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SponsoredBloc, SponsoredState>(
      builder: (sponsoredCtx, sponsoredState) {
        if (sponsoredState is SponsoredLoadSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SponsorItem(
                  business: sponsoredState.sponsored[index],
                  globalNavigator: globalNavigator,
                );
              },
              childCount: sponsoredState.sponsored.length,
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: ShimmerItem(),
                );
              },
              childCount: 2,
            ),
          );
        }
      },
    );
  }
}

class ShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey,
                  ),
                  height: 40,
                  width: 150,
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SponsorItem extends StatefulWidget {
  final Business business;
  final BuildContext globalNavigator;

  SponsorItem({
    this.business,
    this.globalNavigator,
  });

  @override
  _SponsorItemState createState() => _SponsorItemState();
}

class _SponsorItemState extends State<SponsorItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(widget.globalNavigator, "/business_detail",
            arguments: [widget.business.id]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Card(
          elevation: 3,
          shadowColor: Colors.white24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Image.network(widget.business.pictures[0]),
              ),
              Padding(
                padding:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? EdgeInsets.only(left: 15, right: 15, bottom: 15)
                        : EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.business.businessName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Icon(Icons.favorite_border_outlined)
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.business.location,
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.business.phoneNumber[0],
                              style: TextStyle(color: Colors.grey[600]),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.language_outlined,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.business.website,
                              style: TextStyle(color: Colors.grey[600]),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
