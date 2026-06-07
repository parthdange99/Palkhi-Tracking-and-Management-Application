import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'dart:io'; // For SocketException
import 'dart:async'; // For TimeoutException
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palkhi Yatra Tracker',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PalkhiStepperScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PalkhiStepperScreen extends StatefulWidget {
  const PalkhiStepperScreen({super.key});

  @override
  State<PalkhiStepperScreen> createState() => _PalkhiStepperScreenState();
}

class _PalkhiStepperScreenState extends State<PalkhiStepperScreen> {
  final ScrollController _scrollController = ScrollController();
  List<PalkhiStop> _stops = [];
  bool _isLoading = true;
  String _errorMessage = '';
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _fetchStops();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchStops() async {
    try {
      setState(() => _isRefreshing = true);

      final response = await http.get(
        Uri.parse('http://192.168.240.94:3306/yatra/stops'),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['data'] != null) {
          final data = body['data'] as List;
          setState(() {
            _stops = data.map((stop) => PalkhiStop.fromJson(stop)).toList();
            _errorMessage = '';
          });
        } else {
          throw const FormatException('Invalid data format');
        }
      } else {
        throw HttpException('Server error: ${response.statusCode}');
      }
    } on SocketException {
      setState(() => _errorMessage = 'No internet connection');
    } on HttpException catch (e) {
      setState(() => _errorMessage = e.message);
    } on FormatException {
      setState(() => _errorMessage = 'Invalid data received from server');
    } on TimeoutException {
      setState(() => _errorMessage = 'Request timed out');
    } catch (e) {
      setState(() => _errorMessage = 'Unexpected error: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palkhi Yatra 2025'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchStops,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && !_isRefreshing) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _fetchStops,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (_errorMessage.isNotEmpty) _buildErrorSliver(),
          if (_stops.isNotEmpty) _buildTimelineSliver(),
          if (_isRefreshing)
            const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  SliverList _buildTimelineSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => _buildTimelineTile(_stops[index]),
        childCount: _stops.length,
      ),
    );
  }

  SliverToBoxAdapter _buildErrorSliver() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _errorMessage,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineTile(PalkhiStop stop) {
    final now = DateTime.now();
    final isPassed = stop.date.isBefore(DateTime(now.year, now.month, now.day));
    final isCurrent = stop.date.isToday();
    final dateFormat = DateFormat('dd MMM yyyy');

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      isFirst: _stops.first == stop,
      isLast: _stops.last == stop,
      beforeLineStyle: LineStyle(
        color: isPassed ? Colors.green : Colors.grey,
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        width: 30,
        height: 30,
        indicator: _buildIndicator(isPassed, isCurrent),
        color: isPassed ? Colors.green : isCurrent ? Colors.orange : Colors.grey,
      ),
      startChild: Container(
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            dateFormat.format(stop.date),
            style: TextStyle(
              color: isCurrent ? Colors.orange : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
      endChild: _buildStopCard(stop, isCurrent, isPassed),
    );
  }

  Widget _buildIndicator(bool isPassed, bool isCurrent) {
    if (isPassed) {
      return const Icon(Icons.check_circle, color: Colors.black, size: 20);
    }
    if (isCurrent) {
      return const Icon(Icons.location_on, color: Colors.black, size: 20);
    }
    return const Icon(Icons.radio_button_unchecked, color: Colors.black, size: 20);
  }

  Widget _buildStopCard(PalkhiStop stop, bool isCurrent, bool isPassed) {
    return Card(
      elevation: 4,
      color: isCurrent ? Colors.orange.shade50 : Colors.white,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stop.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isCurrent ? Colors.orange : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  stop.status == 'stay' ? Icons.hotel : Icons.directions_walk,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  stop.status.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  stop.eta,
                  style: TextStyle(
                    color: isCurrent ? Colors.orange : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (stop.status == 'moving') _buildRouteStops(stop),
            if (isCurrent) _buildCurrentStatus(stop),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteStops(PalkhiStop stop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 24),
        const Text(
          'Route Stops:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...stop.routeStops.map((route) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                route.passed ? Icons.check_circle : Icons.radio_button_unchecked,
                color: route.passed ? Colors.green : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'ETA: ${route.eta}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${route.coordinates.latitude.toStringAsFixed(4)}, ${route.coordinates.longitude.toStringAsFixed(4)}',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCurrentStatus(PalkhiStop stop) {
    return Column(
      children: [
        const Divider(height: 24),
        Text(
          'Current Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        if (stop.coordinates != null)
          Row(
            children: [
              const Icon(Icons.location_pin, size: 16, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                '${stop.coordinates!.latitude.toStringAsFixed(4)}, '
                    '${stop.coordinates!.longitude.toStringAsFixed(4)}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
      ],
    );
  }
}

class PalkhiStop {
  final DateTime date;
  final String name;
  final String status;
  final String eta;
  final Coordinates? coordinates;
  final List<RouteStop> routeStops;

  PalkhiStop({
    required this.date,
    required this.name,
    required this.status,
    required this.eta,
    this.coordinates,
    required this.routeStops,
  });

  factory PalkhiStop.fromJson(Map<String, dynamic> json) {
    return PalkhiStop(
      date: DateTime.parse(json['date']),
      name: json['name'],
      status: json['status'],
      eta: json['eta'],
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      routeStops: (json['route_stops'] as List)
          .map((rs) => RouteStop.fromJson(rs))
          .toList(),
    );
  }
}

class RouteStop {
  final String name;
  final String eta;
  final Coordinates coordinates;
  final bool passed;

  RouteStop({
    required this.name,
    required this.eta,
    required this.coordinates,
    required this.passed,
  });

  factory RouteStop.fromJson(Map<String, dynamic> json) {
    return RouteStop(
      name: json['name'],
      eta: json['eta'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      passed: json['passed'],
    );
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }
}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}