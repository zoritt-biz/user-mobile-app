import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class BusinessInfo extends StatelessWidget {
  final Business business;

  BusinessInfo({this.business});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Business Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    business.phoneNumber[0],
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(Icons.phone_outlined)
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/menu_display");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore The Menu',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.search_outlined)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    business.website,
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(Icons.language_outlined)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 1
                          : 4,
                      child: Container(child: null),
                    ),
                    Expanded(
                        flex: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.amber),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/more_business_info',
                                arguments: [business],
                              );
                            },
                            child: Text('More Info'))),
                    Expanded(
                        flex: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 1
                            : 4,
                        child: Container(
                          child: null,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
