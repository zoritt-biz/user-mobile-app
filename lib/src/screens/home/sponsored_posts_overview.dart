import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SponsoredPostsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 450.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return SponsorItem(
            name: 'Business name ${index + 1}',
            address: 'Address ${index + 1}',
            phoneNumber: 'phone number',
            website: 'some website',
            imageLink:
                'https://images.unsplash.com/photo-1617103901487-3f2714ec9692?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDEwfDZzTVZqVExTa2VRfHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
          );
        },
        childCount: 10,
      ),
    );
  }
}

class SponsorItem extends StatefulWidget {
  final String name;
  final String address;
  final String phoneNumber;
  final String website;
  final String imageLink;

  SponsorItem(
      {this.name,
      this.address,
      this.phoneNumber,
      this.website,
      this.imageLink});

  @override
  _SponsorItemState createState() => _SponsorItemState();
}

class _SponsorItemState extends State<SponsorItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.network(widget.imageLink),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Icon(Icons.favorite_border_outlined)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.address,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
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
                            widget.phoneNumber,
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
                            widget.website,
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
    );
  }
}
