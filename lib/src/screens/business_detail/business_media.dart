import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BusinessMedia extends StatelessWidget {
  final List<String> pictures;

  const BusinessMedia({Key key, this.pictures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  'Photos & Videos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              pictures.length > 0
                  ? Container(
                      height: 160,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        itemCount: pictures.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            child: Image.network(pictures[index]),
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Icon(FontAwesomeIcons.tasks),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sorry, There is no photos of this business',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
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
