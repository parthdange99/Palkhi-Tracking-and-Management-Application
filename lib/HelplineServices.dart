import 'package:flutter/material.dart';
import 'package:pragatiproject/HelpLineCategories/medicalAssitance.dart';
import 'package:pragatiproject/HelpLineCategories/GeneralAssistancePage.dart';
import 'package:pragatiproject/HelpLineCategories/EmergencyServicesPage.dart';
import 'package:pragatiproject/HelpLineCategories/foodAndWaterSupply.dart';
import 'package:pragatiproject/HelpLineCategories/transportntravel.dart';

class HelplineCategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.local_hospital, "title": "Medical Assistance", "page": MedicalAssistancePage()},
    {"icon": Icons.security, "title": "Emergency Services", "page": EmergencyServicesPage()},
    {"icon": Icons.train, "title": "Transport and Travel", "page": TransportAndTravelPage()},
    {"icon": Icons.local_drink, "title": "Food and Water Supply", "page": FoodAndWaterSupplyPage()},
    {"icon": Icons.help, "title": "General Assistance", "page": GeneralAssistancePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helpline Categories'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                // Navigate to detailed list for this category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => category["page"],
                  ),
                );
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: ListTile(
                  leading: Icon(
                    category["icon"],
                    size: 40,
                    color: Colors.orange,
                  ),
                  title: Text(
                    category["title"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


