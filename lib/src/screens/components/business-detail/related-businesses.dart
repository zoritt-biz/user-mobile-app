import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/related_businesses/related_businesses_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/related_businesses/related_businesses_state.dart';

class RelatedBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<RelatedBusinessesBloc, RelatedBusinessesState>(
        builder: (bizCtx, bizState) {
          if (bizState is RelatedBusinessesLoadSuccess) {
            if (bizState.businesses.isNotEmpty) {
              return Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Text(
                        'Related Businesses',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        bizState.businesses.length,
                        (index) => SingleBusinessItem(
                          imageLink: bizState.businesses[index].pictures[0],
                          name: bizState.businesses[index].businessName,
                          address: bizState.businesses[index].location,
                          phoneNumber:
                              bizState.businesses[index].phoneNumber[0],
                          id: bizState.businesses[index].id,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

class SingleBusinessItem extends StatelessWidget {
  final String imageLink;
  final String name;
  final String address;
  final String phoneNumber;
  final bool isFirst;
  final String id;

  SingleBusinessItem({
    this.imageLink,
    this.isFirst,
    this.name,
    this.phoneNumber,
    this.address,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/business_detail",
          arguments: [id],
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.black26,
        margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 130,
                child: Center(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageLink,
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
                        imageUrl: imageLink,
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
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      address,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      phoneNumber,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
