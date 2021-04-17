import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/related_businesses/related_businesses_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/related_businesses/related_businesses_state.dart';

class RelatedBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                'Related Businesses',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            BlocBuilder<RelatedBusinessesBloc, RelatedBusinessesState>(
              builder: (bizCtx, bizState) {
                if (bizState is RelatedBusinessesLoadSuccess) {
                  if (bizState.businesses.isNotEmpty) {
                    return Column(
                      children: List.generate(
                        3,
                        (index) => SingleBusinessItem(
                          imageLink: bizState.businesses[index].pictures[0],
                          name: bizState.businesses[index].businessName,
                          address: bizState.businesses[index].location,
                          phoneNumber:
                              bizState.businesses[index].phoneNumber[0],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 140,
                      child: Center(
                        child: Text("No related businesses"),
                      ),
                    );
                  }
                } else {
                  return Container(
                    height: 140,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
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

  SingleBusinessItem({
    this.imageLink,
    this.isFirst,
    this.name,
    this.phoneNumber,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Image.network(
              imageLink,
              fit: BoxFit.fill,
              height: 100,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text('\$\$')
                    ],
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
    );
  }
}
