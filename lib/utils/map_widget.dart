import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FacilityLocations extends StatefulWidget {
  const FacilityLocations({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.facilityName,
  });

  final double latitude;
  final double longitude;
  final String facilityName;

  @override
  State<FacilityLocations> createState() => FacilityLocationsState();
}

class FacilityLocationsState extends State<FacilityLocations> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final _markers = <Marker>{};

  @override
  void initState() {
    fetchPermission();
    _markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: InfoWindow(
          title: widget.facilityName,
          snippet: widget.facilityName,
        ),
      ),
    );
    super.initState();
  }

  fetchPermission() async {
    // if (await Permission.location.request().isGranted) {
    //   // Either the permission was already granted before or the user just granted it.
    //   // print("Granted");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _markers,
      onMapCreated: (controller) => _controller.complete(controller),
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: 14.853,
      ),
    );
  }
}
