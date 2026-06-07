import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pragatiproject/Provider/location_provider.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  Future<void> fetchAndUpdateLocation(BuildContext context) async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    try {
      // Check the current permission status
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Request permission if denied
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {

          throw Exception("Location permission denied.");

        } else if (permission == LocationPermission.deniedForever) {
          throw Exception(
              "Location permission permanently denied. Please enable it in settings.");
        }
      }

      // Request the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update location on the server
      await locationProvider.updateLocation(
        position.latitude.toString(),
        position.longitude.toString(),
        'Current Place',
      );

      // Fetch updated location data
      await locationProvider.fetchLocation();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Services'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => fetchAndUpdateLocation(context),
              child: const Text('Fetch & Update Location'),
            ),
            const SizedBox(height: 20),
            if (locationProvider.latitude != null &&
                locationProvider.longitude != null) ...[
              Text(
                'Latitude: ${locationProvider.latitude}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Longitude: ${locationProvider.longitude}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Place: ${locationProvider.place ?? "Unknown"}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
            if (locationProvider.message != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  locationProvider.message!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
