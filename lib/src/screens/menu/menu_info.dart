import 'package:flutter/material.dart';

class MenuDisplay extends StatelessWidget {
  static const String pathName = "/menu_display";

  final List<String> names;
  final List<double> prices;

  MenuDisplay({this.names, this.prices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Our Menu'),
      ),
      body:
          // MenuItem(
          //   name: "dfgjdskfg",
          //   price: 20.0,
          // )
          ListView.builder(
              // shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => MenuItem(
                    name: "dfgjdskfg",
                    price: 20.0,
                  )),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final double price;

  MenuItem({this.price, this.name});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      itemBuilder: (context, index) => index == 0
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Category",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : Card(
              color: Colors.grey[100],
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name.toUpperCase(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${price.toString()} birr',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
