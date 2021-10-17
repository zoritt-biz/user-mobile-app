import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/sponsored_business/sponsored_bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/sponsor-item/sponsor-item.dart';

class SponsoredPostsOverview extends StatelessWidget {
  final BuildContext globalNavigator;

  const SponsoredPostsOverview({Key key, this.globalNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SponsoredBloc, SponsoredState>(
      builder: (sponsoredCtx, sponsoredState) {
        if (sponsoredState is SponsoredLoadSuccess) {
          if (sponsoredState.sponsored.isEmpty) {
            return SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text("No sponsored posts!"),
                    ),
                  ),
                ),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SponsorItem(
                    business: sponsoredState.sponsored[index],
                    globalNavigator: globalNavigator,
                  ),
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
