import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  late Future<List<Placemark>> _currentPlacemark;

  @override
  void initState() {
    super.initState();
    _currentPlacemark = _getCurrentPlacemark();
  }

  Future<List<Placemark>> _getCurrentPlacemark() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request location permission
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // You can set an appropriate error state or message here
          return [];
        }
      }

      // Get current position
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      // Get placemark from coordinates
      return placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Placemark>>(
      future: _currentPlacemark,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading...',
            style: TextStyle(color: Color(0xffE1E8ED)),
          );
        } else if (snapshot.hasError) {
          return const Text(
            'Error getting current position',
            style: TextStyle(color: Colors.red),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text(
            'Position not available',
            style: TextStyle(color: Color(0xffE1E8ED)),
          );
        } else {
          Placemark firstPlacemark = snapshot.data![0];
          String locationDetails =
              "${firstPlacemark.street}, ${firstPlacemark.country}";

          return Text(
            locationDetails,
            style: const TextStyle(color: Colors.black),
          );
        }
      },
    );
  }
}
