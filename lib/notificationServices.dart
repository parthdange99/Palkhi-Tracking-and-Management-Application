import 'dart:math';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pragatiproject/DrawerPages/NotificationsPage.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User  granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User  granted provisional permission');
    } else {
      print("User  denied permission");
    }
  }

  Future<void> initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (payload) {
        // Handle the notification response
        // You may want to handle navigation here
      },
    );
    // Create notification channel only once
    await _createNotificationChannel();
  }
  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Use a constant channel ID
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(message.notification?.title);
        print(message.notification?.body);
        print(message.data);
        print(message.data['type']);
        print(message.data['id']);
      }
      if(Platform.isAndroid){
        initLocalNotifications(context, message);
      }else{
        showNotification(message);
      }

      showNotification(message);
      // Handle message if needed
      if (message.data['type'] == 'msj') {
        handleMessage(context, message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'high_importance_channel', // Use the same channel ID
      'High Importance Notifications',
      channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      notificationDetails,
    );
  }
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token ?? 'default_token'; // Return a default token if null
  }
  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((String token) {
      print('New token: $token'); // Use token directly
    });
  }
  Future<void> setupInteractMessage(BuildContext context) async{
    //when app is terminated
    RemoteMessage?  initialMessage= await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage!=null){
      handleMessage(context, initialMessage);
    }
    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event){
handleMessage(context, event);
    });
  }
  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msj') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(
        id: message.data['id'],
      )));
    }
  }
}