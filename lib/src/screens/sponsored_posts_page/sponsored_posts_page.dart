import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/screens/home/sponsored_posts_overview.dart';

class SponsoredPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsored Posts"),
      ),
      body: SponsorItem(
        name: 'Business name',
        address: 'Address',
        phoneNumber: 'phone number',
        website: 'some website',
        imageLink:
            'https://images.unsplash.com/photo-1617103901487-3f2714ec9692?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDEwfDZzTVZqVExTa2VRfHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      ),
    );
  }
}
