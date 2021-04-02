import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        crossAxisCount: 2,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 25.0,
        // shrinkWrap: true,
        children: [
          GridItem(
            'Arts, Media & Entertainment',
            Icons.ondemand_video_sharp,
          ),
          GridItem(
            'Food & Catering',
            Icons.local_cafe_outlined,
          ),
          GridItem('Hotel & Hospitality', Icons.hotel_outlined),
          GridItem('Shopping', Icons.add_shopping_cart_outlined),
          GridItem('Financial Services', Icons.loop_outlined),
          GridItem('Tour, Travel & Transport', Icons.flight_outlined),
          GridItem('Health', Icons.local_hospital_outlined),
          GridItem('Sports and Leisure', Icons.lens_outlined),
          GridItem(
            'Beauty & Spa',
            Icons.spa_outlined,
          ),
          GridItem('Event Organisers', FontAwesomeIcons.birthdayCake),
          GridItem('Education & Training', FontAwesomeIcons.bookOpen),
          GridItem('Automotive & Gas stations', FontAwesomeIcons.carSide),
          GridItem('Night Life', FontAwesomeIcons.wineGlassAlt),
          GridItem('Import/Export', FontAwesomeIcons.exchangeAlt),
          GridItem('Construction and Engineering',
              FontAwesomeIcons.exclamationTriangle),
          GridItem(
            'Local Services',
            FontAwesomeIcons.wrench,
          ),
          GridItem('Religious Organizations', FontAwesomeIcons.cross),
          GridItem('Governmental Institutions', Icons.account_balance_outlined),
          GridItem('NGOs & Humanitarian', Icons.location_city_outlined),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final IconData icon;

  GridItem(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 50),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
