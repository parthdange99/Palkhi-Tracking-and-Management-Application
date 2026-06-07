import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Helpline data class
class Helpline {
  final String category;
  final String name;
  final String number;

  Helpline({required this.category, required this.name, required this.number});
}

// Sample data for Transport and Travel helplines
List<Helpline> helplineList = [
  Helpline(category: "Transport and Travel", name: "श्री. दिवेकर", number: "996046858"),
  Helpline(category: "Transport and Travel", name: "श्री. दाऊद", number: "7666757583"),
  Helpline(category: "Transport and Travel", name: "शिवणकर जी. ए.", number: "02166223185"),
  Helpline(category: "Transport and Travel", name: "रोडे व्हि. एम.", number: "9823705640"),
  Helpline(category: "Transport and Travel", name: "श्रीम. सुरेखा माने", number: "7775905315, 02026061013"),
  Helpline(category: "Transport and Travel", name: "श्रीमती मनिषा पाटील - जवंजाळ", number: "9405556424, 02162235220"),
  Helpline(category: "Transport and Travel", name: "व्हि. आर. सोनावणे", number: "8888994683, 02162235220"),
];

// Transport and Travel Page UI
class TransportAndTravelPage extends StatefulWidget {
  @override
  _TransportAndTravelPageState createState() => _TransportAndTravelPageState();
}

class _TransportAndTravelPageState extends State<TransportAndTravelPage> {
  List<Helpline> displayedList = helplineList; // Initial list displayed
  TextEditingController searchController = TextEditingController();

  // Search helplines based on query
  void searchHelplines(String query) {
    final filteredList = helplineList
        .where((helpline) =>
    helpline.name.toLowerCase().contains(query.toLowerCase()) ||
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
        title: Text("Transport and Travel Helplines"),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar UI
            TextField(
              controller: searchController,
              onChanged: searchHelplines,
              decoration: InputDecoration(
                labelText: "Search by name or category",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            // Display list of helplines
            Expanded(
              child: ListView.builder(
                itemCount: displayedList.length,
                itemBuilder: (context, index) {
                  final helpline = displayedList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        helpline.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        helpline.category,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: helpline.number.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.call, color: Colors.green),
                        onPressed: () async {
                          final url = 'tel:${helpline.number.split(',')[0]}';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Cannot make the call.")),
                            );
                          }
                        },
                      )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
