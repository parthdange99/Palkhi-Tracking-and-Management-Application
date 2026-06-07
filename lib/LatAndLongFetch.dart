// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;
//
// class LocationServices extends StatefulWidget {
//   const LocationServices({super.key});
//   @override
//   State<LocationServices> createState() => _LocationServicesState();
// }
//
// class _LocationServicesState extends State<LocationServices> {
//   String? _address;
//   String? _coordinates;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     // Start the periodic task
//     startPeriodicLocationUpdate();
//   }
//
//   @override
//   void dispose() {
//     // Cancel the timer when the widget is disposed
//     _timer?.cancel();
//     super.dispose();
//   }
//   void startPeriodicLocationUpdate() {
//     _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
//       getCurrentLocationAndSend();
//     });
//   }
//   Future<void> getCurrentLocationAndSend() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       log("Location permission denied");
//       // Request location permission
//       permission = await Geolocator.requestPermission();
//
//       if (permission == LocationPermission.denied ||
//           permission == LocationPermission.deniedForever) {
//         log("Permission denied after request");
//
//         return; // Exit if permission is still denied
//       }
//     }
//     try {
//       // Fetch the current position
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.bestForNavigation,
//       );
//
//       // Save latitude and longitude to a variable
//       _coordinates = "Lat: ${position.latitude}, Long: ${position.longitude}";
//       log("Coordinates: $_coordinates");
//
//       // Fetch the address from the coordinates
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;
//         _address =
//         "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//         log("Address: $_address");
//       }
//       // Send coordinates and address to server
//       await sendCoordinatesToServer(
//         position.latitude,
//         position.longitude,
//         _address ?? "Address not available",
//       );
//     } catch (e) {
//       log("Error while fetching location or address: $e");
//     }
//   }
//   Future<void> sendCoordinatesToServer(
//       double latitude, double longitude, String address) async {
//     try {
//       // Replace with your server URL
//       const String serverUrl = "http://192.168.1.45:3307/api/location";
//
//       final response = await http.post(
//         Uri.parse(serverUrl),
//         body: {
//           "latitude": latitude.toString(),
//           "longitude": longitude.toString(),
//           "address": address,
//         },
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         log("Coordinates and address sent to server successfully");
//       } else {
//         log("Failed to send data to server: ${response.statusCode}");
//       }
//     } catch (e) {
//       log("Error while sending data to server: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Location Services'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: getCurrentLocationAndSend, // Call the location fetch method
//               child: const Text('Grab Location Now'),
//             ),
//             const SizedBox(height: 20),
//             if (_coordinates != null) ...[
//               //i love you meghna
//               Text(
//                 'Coordinates:',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(_coordinates!),
//               const SizedBox(height: 10),
//
//             ],
//             if (_address != null) ...[
//               Text(
//                 'Address:',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(_address!),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class LocationServices extends StatefulWidget {

  const LocationServices({super.key});
  @override
  State<LocationServices> createState() => _LocationServicesState();
}

class _LocationServicesState extends State<LocationServices> {
  String? _address;
  String? _coordinates;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    startPeriodicLocationUpdate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startPeriodicLocationUpdate() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      getCurrentLocationAndSend();
    });
  }

  Future<void> getCurrentLocationAndSend() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location permission denied");

      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        log("Permission denied after request");
        return;
      }
    }

    try {
      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      // Save latitude and longitude to a variable
      _coordinates = "Lat: ${position.latitude}, Long: ${position.longitude}";
      log("Coordinates: $_coordinates");

      // Fetch the address from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Construct a detailed address
        _address = [
          place.street,               // Street name and house number
          place.subLocality,          // Sub-locality
          place.locality,             // City or town
          place.administrativeArea,   // State or province
          place.postalCode,           // Postal code
          place.country               // Country
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        log("Address: $_address");
      }

      // Send coordinates and address to server
      await sendCoordinatesToServer(
        position.latitude,
        position.longitude,
        _address ?? "Address not available",
      );
    } catch (e) {
      log("Error while fetching location or address: $e");
    }
  }

  Future<void> sendCoordinatesToServer(
      double latitude, double longitude, String address) async {
    try {
      // Replace with your server URL
      const String serverUrl = "http://192.168.1.61:3307/api/location";

      final response = await http.post(
        Uri.parse(serverUrl),
        body: {
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
          "address": address,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Coordinates and address sent to server successfully");
      } else {
        log("Failed to send data to server: ${response.statusCode}");
      }
    } catch (e) {
      log("Error while sending data to server: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Services'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getCurrentLocationAndSend, // Call the location fetch method
              child: const Text('Grab Location Now'),
            ),
            const SizedBox(height: 20),
            if (_coordinates != null) ...[
              Text(
                'Coordinates:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_coordinates!),
              const SizedBox(height: 10),
            ],
            if (_address != null) ...[
              Text(
                'Address:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_address!),
            ],
          ],
        ),
      ),
    );
  }
}
