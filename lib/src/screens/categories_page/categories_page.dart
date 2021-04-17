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
        crossAxisCount:
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 25.0,
        // shrinkWrap: true,
        children: [
          GridItem(
              'Arts, Media & Entertainment',
              Icons.ondemand_video_sharp,
              context
          ),
          GridItem(
              'Food & Catering',
              Icons.local_cafe_outlined,context
          ),
          GridItem('Hotel & Hospitality', Icons.hotel_outlined,context),
          GridItem('Shopping', Icons.add_shopping_cart_outlined,context),
          GridItem('Financial Services', Icons.loop_outlined,context),
          GridItem('Tour, Travel & Transport', Icons.flight_outlined,context),
          GridItem('Health', Icons.local_hospital_outlined,context),
          GridItem('Sports and Leisure', Icons.lens_outlined,context),
          GridItem(
              'Beauty & Spa',
              Icons.spa_outlined,
              context
          ),
          GridItem('Event Organisers', FontAwesomeIcons.birthdayCake,context),
          GridItem('Education & Training', FontAwesomeIcons.bookOpen,context),
          GridItem('Automotive & Gas stations', FontAwesomeIcons.carSide,context),
          GridItem('Night Life', FontAwesomeIcons.wineGlassAlt,context),
          GridItem('Import/Export', FontAwesomeIcons.exchangeAlt,context),
          GridItem('Construction and Engineering',
              FontAwesomeIcons.exclamationTriangle,context),
          GridItem(
              'Local Services',
              FontAwesomeIcons.wrench,
              context
          ),
          GridItem('Religious Organizations', FontAwesomeIcons.cross,context),
          GridItem('Governmental Institutions', Icons.account_balance_outlined,context),
          GridItem('NGOs & Humanitarian', Icons.location_city_outlined,context),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final BuildContext ctx;

  GridItem(this.title, this.icon, this.ctx);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey[300],
          onTap: () {
            Navigator.pushNamed(ctx, "/subcategories");
          },
          borderRadius: BorderRadius.circular(20),
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
        ),
      ),
    );
  }
}
