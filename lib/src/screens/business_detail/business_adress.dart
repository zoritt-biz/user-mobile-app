import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessAddress extends StatelessWidget {
  final String name;
  final String time;
  final bool localTime;
  final String phoneNumber;
  final String website;
  final String location;

  BusinessAddress({
    this.name,
    this.time,
    this.localTime,
    this.phoneNumber,
    this.website,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Open',
                    style: TextStyle(color: Colors.orange, fontSize: 15),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    localTime == true ? 'ET' : '',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: IconButton(
                      icon: Icon(Icons.phone_outlined),
                      onPressed: () async {
                        await canLaunch("tel:$phoneNumber")
                            ? await launch("tel:$phoneNumber")
                            : throw 'Could not launch $phoneNumber';
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: IconButton(
                      icon: Icon(Icons.language_outlined),
                      onPressed: () async {
                        await canLaunch(website)
                            ? await launch(website)
                            : throw 'Could not launch $website';
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: Icon(Icons.push_pin_outlined),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
