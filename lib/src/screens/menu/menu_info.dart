import 'package:flutter/material.dart';

class MenuDisplay extends StatelessWidget {
  final List<String> names;
  final List<double> prices;

  MenuDisplay({this.names, this.prices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView.builder(
        // shrinkWrap: true,
          itemCount: names.length,
          itemBuilder: (context, index) =>
              MenuItem(
                name: names[index],
                price: prices[index],
              )
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final double price;

  MenuItem({this.price, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Card(
        color: Colors.grey[100],
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${price.toString()} birr',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
