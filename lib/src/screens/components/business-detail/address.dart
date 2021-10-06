import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class BusinessAddress extends StatelessWidget {
  final String businessName;
  final String slogan;
  final List<OpenHours> time;
  final String phoneNumber;
  final String website;
  final String location;
  final LatLng latLng;

  BusinessAddress({
    this.businessName,
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
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                businessName,
                style: TextStyle(
                    // color: isShrink ? Colors.black : Colors.white,
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Helvetica"),
              ),
              if (slogan != "" && slogan != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    slogan,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              if (time.length > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
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
                      IconButton(
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 35,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.8),
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Container(
                                    height: 350,
                                    child: Card(
                                      elevation: 3,
                                      clipBehavior: Clip.hardEdge,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: ListView(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Text(
                                                "Open Hours",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            ...time.map((t) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 90,
                                                        child: Text("${t.day}"),
                                                      ),
                                                      SizedBox(
                                                        width: 60,
                                                        child: Text(
                                                          t.isOpen
                                                              ? "Open"
                                                              : "Closed",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      if (t.isOpen)
                                                        SizedBox(
                                                          width: 150,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                t.opens.split(
                                                                    "T")[0],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                child:
                                                                    Text("-"),
                                                              ),
                                                              Text(
                                                                t.closes.split(
                                                                    "T")[0],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (!t.isOpen)
                                                        SizedBox(
                                                          width: 150,
                                                          child: Center(
                                                              child: Text("-")),
                                                        ),
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
