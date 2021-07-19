import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class BusinessAddress extends StatelessWidget {
  final String slogan;
  final List<OpenHours> time;
  final String phoneNumber;
  final String website;
  final String location;
  final LatLng latLng;

  BusinessAddress({
    this.slogan,
    this.time,
    this.phoneNumber,
    this.website,
    this.location,
    this.latLng,
  });

  int today = new DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (slogan != "" && slogan != null)
                Text(
                  slogan,
                  style: TextStyle(fontSize: 15),
                ),
              if (time.length > 0)
                Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      time[today - 1].isOpen ? "Open" : "Closed",
                      style: TextStyle(color: Colors.orange, fontSize: 15),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    if (time[today - 1].isOpen)
                      Text(
                        time[today - 1].opens.split("T")[0],
                        style: TextStyle(fontSize: 15),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("-"),
                    ),
                    if (time[today - 1].isOpen)
                      Text(
                        time[today - 1].closes.split("T")[0],
                        style: TextStyle(fontSize: 15),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
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
                        await launch("tel:$phoneNumber");
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: IconButton(
                      icon: Icon(Icons.language_outlined),
                      disabledColor: Colors.grey[400],
                      onPressed: (website != null && website != "")
                          ? () async {
                              if (website != null && website != "") {
                                await launch(website);
                              } else {
                                return null;
                              }
                            }
                          : null,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: IconButton(
                      icon: Icon(Icons.push_pin_outlined),
                      onPressed: () {
                        Navigator.pushNamed(context, "/location_page",
                            arguments: [latLng]);
                      },
                    ),
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
