import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  final Function setFilterState;
  final bool openNow;

  const SearchFilter(
      {Key key, @required this.setFilterState, @required this.openNow})
      : super(key: key);

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
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[600],
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                widget.setFilterState();
              },
              child: Text(
                'Open Now',
                style: TextStyle(
                  color: widget.openNow ? Colors.blue : Colors.grey[600],
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: widget.openNow ? Colors.blue : Colors.grey[600],
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     border: Border.all(
          //       color: widget.price == "" ? Colors.grey[600] : Colors.blue,
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       TextButton(
          //         onPressed: () {
          //           widget.filter(widget.openNow, "price");
          //           widget.setFilterState(widget.openNow, "price");
          //         },
          //         child: Text(
          //           'Price',
          //           style: TextStyle(
          //             color:
          //                 widget.price == "" ? Colors.grey[600] : Colors.blue,
          //           ),
          //         ),
          //       ),
          //       Icon(
          //         Icons.keyboard_arrow_down_outlined,
          //         color: Colors.grey,
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.all(8),
          //   child: Text(
          //     'All Filters',
          //   ),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(50),
          //       border: Border.all(color: Colors.grey)),
          // ),
        ],
      ),
    );
  }
}
