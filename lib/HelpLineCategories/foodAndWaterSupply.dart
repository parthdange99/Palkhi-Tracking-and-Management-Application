import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Helpline data class
class Helpline {
  final String category;
  final String name;
  final String number;

  Helpline({required this.category, required this.name, required this.number});
}

// Sample data for Food and Water Supply helplines
List<Helpline> helplineList = [
  Helpline(category: "Food and Water Supply", name: "श्रीम. सुरेखा माने", number: "7775905315, 02026061013"),
  Helpline(category: "Food and Water Supply", name: "श्रीमती मनिषा पाटील- जवंजाळ सहाय्यक आयु व औषध प्रशा", number: "9405556424, 02162235220"),
  Helpline(category: "Food and Water Supply", name: "व्हि. आर. सोनावणे", number: "8888994683, 02162235220"),
];

// Food and Water Supply Page UI
class FoodAndWaterSupplyPage extends StatefulWidget {
  @override
  _FoodAndWaterSupplyPageState createState() => _FoodAndWaterSupplyPageState();
}

class _FoodAndWaterSupplyPageState extends State<FoodAndWaterSupplyPage> {
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
        title: Text("अन्न आणि पाणी पुरवठा हेल्पलाईन"),
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
