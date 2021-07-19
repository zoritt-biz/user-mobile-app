import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessLocation extends StatefulWidget {
  final String locationDescription;
  final LatLng latLng;

  BusinessLocation({
    this.locationDescription,
    this.latLng,
  });

  @override
  _BusinessLocationState createState() => _BusinessLocationState();
}

class _BusinessLocationState extends State<BusinessLocation> {
  CameraPosition _initialCameraPosition;
  GoogleMapController _googleMapController;
  Marker _origin;

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void initState() {
    super.initState();
    _origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: widget.latLng,
      draggable: false,
    );
    _initialCameraPosition = CameraPosition(
      target: widget.latLng,
      zoom: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                markers: {
                  _origin,
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get Directions',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.location_pin),
                    onPressed: () {
                      Navigator.pushNamed(context, "/location_page",
                          arguments: [widget.latLng]);
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 30, top: 10),
              child: Text(
                widget.locationDescription,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
