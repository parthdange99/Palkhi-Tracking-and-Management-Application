import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pragatiproject/Provider/Userdata_provider.dart';
import 'package:pragatiproject/Provider/location_provider.dart';
import 'package:pragatiproject/Provider/volunteer_provider.dart';
import 'package:provider/provider.dart';
import 'Provider/login_provider.dart';
import 'Provider/signup_provider.dart';
import 'DashBoardPage.dart';
import 'package:pragatiproject/LoginScreen.dart';
import 'package:pragatiproject/Signup.dart';
import 'package:pragatiproject/ForgetPassword.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:geolocator/geolocator.dart';

Future<void> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle the case when permission is denied
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle the case when permission is permanently denied
  }
}
// Background handler must be top-level or static
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
  print(message.notification!.body.toString());
  print(message.data.toString());
  print('Handling background message: ${  message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => UserdataProvider()),
        ChangeNotifierProvider(create: (_) => VolunteeringProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/DashBoardPage',
      routes: {

        '/splash': (context) => SplashScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/DashBoardPage': (context) => DashboardPage(),
        '/dashboard': (context) => DashboardPage(), // Added alias for dashboard
        '/signup': (context) => SignupScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
      },
      onUnknownRoute: (settings) {
        // Fallback for unknown routes
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login page after a delay
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/loginScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'पंढरीची वाट चालताना, नामाचा गजर करूया, विठुरायाच्या चरणी, आपले जीवन समर्पण करूया!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
