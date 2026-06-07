import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<Map<String, String>> faqs = [
    {"question": "What is 'Where is my Dindi'?", "answer": "'Where is my Dindi' is a real-time tracking app for the Palkhi Yatra."},
    {"question": "How does the GPS tracking work?", "answer": "The app uses GPS to track the Palkhi's live location and updates in real-time."},
    {"question": "Is an internet connection required?", "answer": "Yes, an internet connection is necessary to fetch real-time updates."},
    {"question": "Can I track multiple Palkhis?", "answer": "Yes, the app allows you to view multiple Palkhis on the map."},
    {"question": "Can I set alerts when the Palkhi is near?", "answer": "Yes, you can enable notifications for real-time alerts."},
    {"question": "How frequently is the location updated?", "answer": "The app updates the location every few seconds for accuracy."},
    {"question": "Can I see the route map?", "answer": "Yes, the app provides a full route map with key points."},
    {"question": "Does the app show estimated arrival times?", "answer": "Yes, it uses Google Distance Matrix API for ETAs."},
    {"question": "Can I save favorite Palkhis?", "answer": "Yes, you can mark them for quick tracking."},
    {"question": "Does the app work at night?", "answer": "Yes, the tracking works 24/7 if the GPS is active."},
    {"question": "What technologies are used?", "answer": "Flutter, CodeIgniter 4, Firebase, and Google Maps API."},
    {"question": "How accurate is tracking?", "answer": "It depends on GPS signal but is highly accurate."},
    {"question": "What if the location is not updating?", "answer": "Check internet and refresh the app. If needed, restart it."},
    {"question": "Is my data secure?", "answer": "Yes, user data is stored securely using Firebase authentication."},
    {"question": "Can I report incorrect location data?", "answer": "Yes, there's a 'Report Issue' option."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: faqs.length + 1,
        itemBuilder: (context, index) {
          if (index < faqs.length) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: ExpansionTile(
                title: Text(
                  faqs[index]["question"]!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      faqs[index]["answer"]!,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return _buildMoreQuestionsSection(context);
          }
        },
      ),
    );
  }

  Widget _buildMoreQuestionsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Have More Questions?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
          ),
          SizedBox(height: 10),
          Text(
            "If your query is not listed above, feel free to contact the admin for further assistance.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
            },
            icon: Icon(Icons.feedback, color: Colors.white),
            label: Text("Contact Admin"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> submitFeedback() async {
    final String apiUrl = "http://192.168.1.43:3306/contact/submit"; // Update this with your actual backend API URL

    if (nameController.text.isEmpty || emailController.text.isEmpty || messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "message": messageController.text.trim(),
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Query submitted successfully')),
        );
        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit query')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Add _buildTextField method
  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Admin"), backgroundColor: Colors.orangeAccent),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(nameController, "Your Name"),
            SizedBox(height: 10),
            _buildTextField(emailController, "Your Email"),
            SizedBox(height: 10),
            _buildTextField(messageController, "Your Query", maxLines: 4),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitFeedback,
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
