import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationProvider with ChangeNotifier {
  String? latitude;
  String? longitude;
  String? place;
  String? message;

  // Base API URL
  final String apiUrl = 'http://192.168.1.30:3306/auth/location';

  // Fetch location data from the backend
  Future<void> fetchLocation() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        latitude = data['data']['latitude'];
        longitude = data['data']['longitude'];
        place = data['data']['place'];
        notifyListeners();
      } else {
        message = 'Failed to fetch location data.';
        notifyListeners();
      }
    } catch (e) {
      message = 'An error occurred: $e';
      notifyListeners();
    }
  }

  // Update location data in the backend
  Future<void> updateLocation(String lat, String long, String location) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/update'),
        body: {
          'latitude': lat,
          'longitude': long,
          'place': location,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        message = data['message'];
        notifyListeners();
      } else {
        message = 'Failed to update location.';
        notifyListeners();
      }
    } catch (e) {
      message = 'An error occurred: $e';
      notifyListeners();
    }
  }
}
