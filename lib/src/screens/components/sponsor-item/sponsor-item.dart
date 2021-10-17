import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class SponsorItem extends StatefulWidget {
  final Business business;
  final BuildContext globalNavigator;

  SponsorItem({
    this.business,
    this.globalNavigator,
  });

  @override
  _SponsorItemState createState() => _SponsorItemState();
}

class _SponsorItemState extends State<SponsorItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Card(
        elevation: 3,
        shadowColor: Colors.white24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.network(
                widget.business.pictures[0],
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            Padding(
              padding:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? EdgeInsets.only(left: 15, right: 15, bottom: 15)
                      : EdgeInsets.only(left: 40, right: 40, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13, bottom: 10),
                    child: Text(
                      widget.business.businessName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.business.location,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
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
                            widget.business.phoneNumbers[0],
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      ),
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
