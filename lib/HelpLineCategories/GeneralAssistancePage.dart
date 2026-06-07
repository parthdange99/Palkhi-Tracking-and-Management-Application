import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For calling functionality

// Helpline data class
class Helpline {
  final String category;
  final String name;
  final String number;
  Helpline({required this.category, required this.name, required this.number});
}

// Sample data for General Assistance helplines
List<Helpline> helplineList = [
  Helpline(category: "General Assistance", name: "Disaster Management", number: "101"),
  Helpline(category: "General Assistance", name: "Police Assistance", number: "102"),
  Helpline(category: "General Assistance", name: "Local Help Desk", number: "9876543210"),
  Helpline(category: "General Assistance", name: "Lost & Found", number: "1122334455"),
  // Add more entries as needed
];

// General Assistance Page UI
class GeneralAssistancePage extends StatefulWidget {
  @override
  _GeneralAssistancePageState createState() => _GeneralAssistancePageState();
}

class _GeneralAssistancePageState extends State<GeneralAssistancePage> {
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
        title: Text("General Assistance Helpline Numbers"),
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
