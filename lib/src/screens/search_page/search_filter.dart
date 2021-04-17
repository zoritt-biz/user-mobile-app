import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.sort_outlined,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Open Now',
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey)),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                Text(
                  'Price',
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'All Filters',
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}