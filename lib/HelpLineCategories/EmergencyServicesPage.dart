import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Helpline data class
class Helpline {
  final String category;
  final String name;
  final String number;
  Helpline({required this.category, required this.name, required this.number});
}
// Sample data for Emergency Services helplines
List<Helpline> helplineList = [
  Helpline(category: "Emergency Services", name: "Ambulance", number: "108"),
  Helpline(category: "Emergency Services", name: "Police", number: "100"),
  Helpline(category: "Emergency Services", name: "Fire Department", number: "101"),
  Helpline(category: "Emergency Services", name: "Disaster Management", number: "102"),
];
// Emergency Services Page UI
class EmergencyServicesPage extends StatefulWidget {
  @override
  _EmergencyServicesPageState createState() => _EmergencyServicesPageState();
}

class _EmergencyServicesPageState extends State<EmergencyServicesPage> {
  List<Helpline> displayedList = helplineList; // Initial list displayed
  TextEditingController searchController = TextEditingController();

  // Search helplines based on query
  void searchHelplines(String query) {
    final filteredList = helplineList
        .where((helpline) => helpline.name.toLowerCase().contains(query.toLowerCase()) ||
        helpline.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      displayedList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Services Helpline Numbers"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: searchHelplines,
              decoration: InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedList.length,
              itemBuilder: (context, index) {
                final helpline = displayedList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: ListTile(
                    title: Text(helpline.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(helpline.category),
                    trailing: IconButton(
                      icon: Icon(Icons.call, color: Colors.green),
                      onPressed: () async {
                        final url = 'tel:${helpline.number}';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Cannot make the call.")),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
