import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class SearchPage extends StatelessWidget {
  final BuildContext globalNavigator;

  const SearchPage({Key key, this.globalNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: BusinessSearch());
            },
            iconSize: 30,
            icon: Icon(Icons.search,color: Colors.black,),
          )
        ],
      ),
      body: ListView(
        children: [
          SearchFilter(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Result',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("here");
              Navigator.pushNamed(globalNavigator, "/business_detail");
            },
            child: SearchResult(
              title: 'Wow Burger',
              address: 'Arat kilo, Addis Ababa',
              phoneNumber: '+251912365478',
              name: 'Burger, Shawarma',
              price: 3,
              imageLink:
                  "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
            ),
          ),
          SearchResult(
            title: 'Wow Burger',
            address: 'Arat kilo, Addis Ababa',
            phoneNumber: '+251912365478',
            name: 'Burger, Shawarma',
            price: 2,
            imageLink:
                "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
          )
        ],
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final String title;
  final String address;
  final String phoneNumber;
  final double price;
  final String name;
  final String imageLink;
  final bool relatedBusiness;

  SearchResult({
    this.title,
    this.address,
    this.phoneNumber,
    this.price,
    this.name,
    this.relatedBusiness,
    this.imageLink,
  });

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  widget.imageLink,
                  fit: BoxFit.fill,
                  height: 100,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.orange,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.address,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.phoneNumber,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (widget.relatedBusiness != true)
                        Row(
                          children: [
                            Text(
                              '\$${widget.price.toString()}',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.name,
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
class BusinessSearch extends SearchDelegate<Business>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Icon(Icons.clear),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon:Icon(Icons.arrow_back),
      onPressed:(){
        close(context, Business());
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
     return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
