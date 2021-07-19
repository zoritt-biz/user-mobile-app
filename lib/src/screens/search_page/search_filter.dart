import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  final Function setFilterState;
  final Function openSearchDelegate;
  final bool openNow;
  final bool nearby;
  final String query;

  const SearchFilter({
    Key key,
    @required this.setFilterState,
    @required this.openSearchDelegate,
    @required this.openNow,
    @required this.query,
    @required this.nearby,
  }) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.query,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.openSearchDelegate();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    widget.nearby ? Colors.blue : Colors.grey[300])),
            child: Text(
              'Nearby',
              style: TextStyle(
                color: widget.nearby ? Colors.white : Colors.grey[600],
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              widget.setFilterState();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    widget.openNow ? Colors.blue : Colors.grey[300])),
            child: Text(
              'Open Now',
              style: TextStyle(
                color: widget.openNow ? Colors.white : Colors.grey[600],
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
