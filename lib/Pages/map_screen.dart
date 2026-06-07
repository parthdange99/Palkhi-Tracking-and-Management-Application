import 'dart:convert';
import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(PalkhiTrackerApp());
}
class PalkhiTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(),
    );
  }
}
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;

  // 📍 Dummy destination (Wagholi, Maharashtra)
  LatLng _palkhiLocation = LatLng(18.58334, 73.983326);

  String distance = "Calculating...";
  String estimatedTime = "Calculating..."; // Added for estimated time
  List<LatLng> polylineCoordinates = [];

  final String apiKey = "AIzaSyAxbDv5xrsBhy8fGwiDPIUo0ksKu-mwsYI"; // Replace with your actual API key

  Timer? _timer; // Timer for periodic location updates

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _getCurrentLocation(); // Update the user's location every 5 seconds
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });

    await _getDistance(); // Ensure to await the distance calculation
    await _getRoute(); // Ensure to await the route calculation
  }

  Future<void> _getDistance() async {
    if (_currentPosition == null) return;

    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric"
        "&origins=${_currentPosition!.latitude},${_currentPosition!.longitude}"
        "&destinations=${_palkhiLocation.latitude},${_palkhiLocation.longitude}"
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["rows"].isNotEmpty && data["rows"][0]["elements"].isNotEmpty) {
        setState(() {
          distance = data["rows"][0]["elements"][0]["distance"]["text"];
          estimatedTime = data["rows"][0]["elements"][0]["duration"]["text"]; // Get estimated time
        });
      } else {
        setState(() {
          distance = "Distance not available";
          estimatedTime = "Time not available"; // Handle case where time is not available
        });
      }
    } else {
      setState(() {
        distance = "Error fetching distance";
        estimatedTime = "Error fetching time"; // Handle error case
      });
    }
  }
  Future<void> _getRoute() async {
    if (_currentPosition == null) return;

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}"
        "&destination=${_palkhiLocation.latitude},${_palkhiLocation.longitude}"
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["routes"].isNotEmpty) {
        var points = data["routes"][0]["overview_polyline"]["points"];
        List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);

        setState(() {
          polylineCoordinates = decodedPoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
        });
      } else {
        print("No routes found");
      }
    } else {
      print("Error fetching route");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Palkhi Tracker")),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 14,
            ),
            markers: {
              Marker(
                markerId: MarkerId("user"),
                position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                infoWindow: InfoWindow(title: "Your Location"),
              ),
              Marker(
                markerId: MarkerId("palkhi"),
                position: _palkhiLocation,
                infoWindow: InfoWindow(title: "Palkhi Location "),
              ),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId("route"),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            },
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            bottom: 620,
            left: 20,
            right: 20,
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Distance to Palkhi: $distance\nEstimated Time: $estimatedTime", // Updated to show estimated time
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Ensure it's in a stackable position
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100, left: 300, right: 20), // Moves it 100 pixels up
        child: FloatingActionButton(
          onPressed: _getCurrentLocation,
          child: Icon(Icons.location_searching),
        ),
      ),

    );
  }
}
