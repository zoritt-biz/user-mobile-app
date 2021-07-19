import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  static const String pathName = "/location_page";
  final LatLng latLng;

  LocationPage(this.latLng);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
        compassEnabled: true,
        rotateGesturesEnabled: true,
        markers: {
          _origin,
        },
      ),
    );
  }
}
