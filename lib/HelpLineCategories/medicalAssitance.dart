import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Helpline data class
class Helpline {
  final String category;
  final String name;
  final String number;

  Helpline({required this.category, required this.name, required this.number});
}

List<Helpline> helplineList = [
  Helpline(category: "Medical Assistance", name: "डॉ. बहिरट वैद्यकीय व्यावसायिक", number: "9881231419"),
  Helpline(category: "Medical Assistance", name: "डॉ. निलेश रंधव", number: "9881502146"),
  Helpline(category: "Medical Assistance", name: "डॉ. देशपांडे", number: "9822302214"),
  Helpline(category: "Medical Assistance", name: "डॉ. राईलकर", number: "02026911339"),
  Helpline(category: "Medical Assistance", name: "डॉ. गजरमल", number: "02026913651"),
  Helpline(category: "Medical Assistance", name: "डॉ. हरपळे वैद्यकीय व्यावसायिक", number: "9371121694"),
  Helpline(category: "Medical Assistance", name: "डॉ. घोगरे", number: "9822042332"),
  Helpline(category: "Medical Assistance", name: "डॉ. विजय हरपळे", number: "02026981229"),
  Helpline(category: "Medical Assistance", name: "डॉ. शिवम हॉस्पिटल", number: "9372222883"),
  Helpline(category: "Medical Assistance", name: "डॉ. एमआयटी हॉस्पिटल", number: "8624848910"),
  Helpline(category: "Medical Assistance", name: "डॉ. माईनकर वैद्यकीय व्यावसायिक", number: "02115222553"),
  Helpline(category: "Medical Assistance", name: "चिंतामणी हॉस्पिटल", number: "9422005819"),
  Helpline(category: "Medical Assistance", name: "डॉ. हेंद्रे धन्वंतरी हॉस्पिटल", number: "02115225211"),
  Helpline(category: "Medical Assistance", name: "जय मल्हार हॉस्पिटल", number: "02115233629"),
  Helpline(category: "Medical Assistance", name: "डॉ. कांबळे (वाल्हे)", number: "02115284149"),
];

// Medical Assistance Page UI
class MedicalAssistancePage extends StatefulWidget {
  @override
  _MedicalAssistancePageState createState() => _MedicalAssistancePageState();
}

class _MedicalAssistancePageState extends State<MedicalAssistancePage> {
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
        title: Text("Medical Assistance Helplines"),
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
                          final url = 'tel:${helpline.number}'; // Corrected line
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
