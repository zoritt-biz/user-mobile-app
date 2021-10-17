import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:zoritt_mobile_app_user/src/models/filter.dart';

class SearchFilterDialog extends StatefulWidget {
  final Function setFilter;
  final String query;
  final LocationData locationData;

  const SearchFilterDialog({
    Key key,
    this.setFilter,
    this.query,
    this.locationData,
  }) : super(key: key);

  @override
  _SearchFilterDialogState createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  bool openNow = false;
  double distance = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filter"),
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.only(top: 20),
      actionsPadding: EdgeInsets.symmetric(horizontal: 0),
      titlePadding: EdgeInsets.all(20),
      semanticLabel: "Filter",
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.setFilter(
              new Filter(
                query: widget.query,
                openNow: openNow,
                distance: distance * 1000 + 999,
                lat: widget.locationData.latitude,
                lng: widget.locationData.longitude,
              ),
            );
            Navigator.pop(context);
          },
          child: Text("Search"),
        ),
      ],
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text("Distance $distance KM"),
          ),
          Slider(
            value: distance,
            onChanged: (newKm) {
              setState(() {
                distance = newKm;
              });
            },
            min: 0,
            max: 20,
            divisions: 5,
            label: "$distance",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Open Now"),
                Switch(
                  value: openNow,
                  onChanged: (value) {
                    setState(() {
                      openNow = value;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
