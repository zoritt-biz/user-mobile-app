import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
              SizedBox(height: 20),
              Text(
                'Category',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              ...business.categories.map(
                (e) => Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.parent,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey[600],
                              size: 15,
                            ),
                            Flexible(
                              child: Text(
                                e.name,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...List.generate(
                business.phoneNumbers.length,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      business.phoneNumbers[index],
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                      onPressed: () async {
                        await launch("tel:${business.phoneNumbers[index]}");
                      },
                      icon: Icon(Icons.phone_outlined),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 30,
              ),
              if (business.website != null && business.website != "")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(business.website, style: TextStyle(fontSize: 15)),
                    IconButton(
                      onPressed: () async {
                        await launch(business.website);
                      },
                      icon: Icon(Icons.language_outlined),
                    ),
                  ],
                ),
              if (business.emails.length > 0)
                Divider(color: Colors.grey, height: 30),
              if (business.emails.length > 0)
                ...List.generate(
                  business.emails.length,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        business.emails[index],
                        style: TextStyle(fontSize: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.email_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              if (business.menus.length > 0)
                Divider(
                  color: Colors.grey,
                  height: 30,
                ),
              if (business.menus.length > 0)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/menu_display",
                        arguments: [business.id]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore Our Menu',
                        style: TextStyle(fontSize: 15),
                      ),
                      Icon(Icons.search_outlined)
                    ],
                  ),
                ),
              if (business.branches.length > 0)
                Divider(
                  color: Colors.grey,
                  height: 30,
                ),
              if (business.branches.length > 0)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/branches",
                        arguments: [business.id]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Branches',
                        style: TextStyle(fontSize: 15),
                      ),
                      Icon(Icons.account_tree_outlined)
                    ],
                  ),
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
                    if (business.description != "" &&
                        business.description != null)
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
                      child: Container(),
                    ),
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
