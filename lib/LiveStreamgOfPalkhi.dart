import 'package:flutter/material.dart';
import 'Pages/map_screen.dart';
void main() {
  runApp(PalkhiApp());
}
class PalkhiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PalkhiListScreen(),
    );
  }
}

class PalkhiListScreen extends StatelessWidget {
  final List<Map<String, String>> palkhiList = [
    {
      "name": "Sant Dnyaneshwar Palkhi",
      "location": "Alandi, Maharashtra",
    },
    {
      "name": "Sant Tukaram Palkhi",
      "location": "Dehu, Maharashtra",
    },
    {
      "name": "Sant Muktabai Palkhi",
      "location": "Muktainagar, Maharashtra",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Palkhi List"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: palkhiList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                palkhiList[index]["name"]!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                palkhiList[index]["location"]!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward,
                color: Colors.orangeAccent,
              ),

              // Navigator.pop(context);
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => VolunteeringRegistrationPage()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PalkhiDetailsScreen extends StatelessWidget {
  final String palkhiName;
  final String palkhiLocation;
  PalkhiDetailsScreen({required this.palkhiName, required this.palkhiLocation});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(palkhiName),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 100,
                color: Colors.orangeAccent,
              ),
              SizedBox(height: 20),
              Text(
                palkhiName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                palkhiLocation,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
