import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/sponsored_business/sponsored_bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/home/sponsored_posts_overview.dart';

class SponsoredPostsPage extends StatelessWidget {
  final BuildContext globalNavigator;

  const SponsoredPostsPage({Key key, this.globalNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsored Posts"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: BlocBuilder<SponsoredBloc, SponsoredState>(
          builder: (sponsoredCtx, sponsoredState) {
            if (sponsoredState is SponsoredLoadSuccess) {
              return ListView(
                children: [
                  ...sponsoredState.sponsored.map(
                    (biz) => SponsorItem(
                      business: biz,
                      globalNavigator: globalNavigator,
                    ),
                  ),
                ],
              );
            } else {
              return ListView(
                children: [
                  ShimmerItem(),
                  ShimmerItem(),
                  ShimmerItem(),
                  ShimmerItem(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
