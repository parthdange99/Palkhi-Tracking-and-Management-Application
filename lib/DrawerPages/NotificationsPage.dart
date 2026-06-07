import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final String id;
  const NotificationScreen({key, required this.id}) :super (key :key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Screen'+widget.id),
      ),
    );
  }
}

class NotificationHelper {
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Failed to subscribe to topic: $topic. Error: $e');
    }
  }
}
