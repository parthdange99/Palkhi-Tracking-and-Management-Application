import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Services"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildServiceCard(

              title: "Emergency Contacts",
              icon: Icons.local_hospital,
              description: "Find nearby hospitals, clinics, and ambulances.",
              color: Colors.redAccent,
            ),
            _buildServiceCard(
              title: "First Aid Info",
              icon: Icons.healing,
              description: "Quick tips on dehydration, exhaustion, and injuries.",
              color: Colors.green,
            ),
            _buildServiceCard(
              title: "Live Medical Assistance",
              icon: Icons.support_agent,
              description: "Chat with medical volunteers and get real-time help.",
              color: Colors.blueAccent,
            ),

            _buildServiceCard(
              title: "Nearby Medical Facilities",
              icon: Icons.map,
              description: "Locate hospitals, pharmacies, and medical camps on the map.",
              color: Colors.orange,
            ),
            _buildServiceCard(
              title: "Medicine Availability",
              icon: Icons.medical_services,
              description: "Check available medicines and first aid kits.",
              color: Colors.purpleAccent,
            ),
            _buildServiceCard(
              title: "Health Tips",
              icon: Icons.health_and_safety,
              description: "Guidance on hydration, diet, and managing fatigue.",
              color: Colors.teal,
            ),
            _buildServiceCard(
              title: "SOS Emergency",
              icon: Icons.warning,
              description: "Send an emergency alert with your live location.",
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required IconData icon,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: color.withOpacity(0.4),
      child: ListTile(
        leading: Icon(icon, size: 32, color: color),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: color),
        onTap: () {
          // Add Navigation or Functionality Here
        },
      ),
    );
  }
}
