import 'package:flutter/material.dart';

void main() {
  runApp(PalkhiChatBot());
}

class PalkhiChatBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatBotScreen(),
    );
  }
}

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];

  // Predefined FAQs
  final Map<String, String> _faq = {
    "What is Palkhi Yatra?":
    "Palkhi Yatra is a revered pilgrimage in Maharashtra, associated with Sant Dnyaneshwar and Sant Tukaram, featuring a spiritual procession.",
    "How does the GPS tracking work?":
    "Our GPS system tracks the Palkhi in real time, updating location, speed, and route information directly in the app.",
    "What are the facilities available during the yatra?":
    "Facilities include water points, rest areas, and medical support. Check the 'Facilities' section for more details.",
    "How can I donate?":
    "You can donate using the QR code in the 'Donation' section of the app.",
    "What are the notifications for roadblocks?":
    "The app sends notifications about any roadblocks or route changes to help participants stay informed.",
    "Contact support": "Please reach out to our support team at support@palkhi.com.",
  };

  void _handleUserMessage(String message) {
    setState(() {
      // Add user message
      _chatMessages.add({"role": "user", "content": message});

      // Get response from FAQ
      String response = _faq[message] ?? "Sorry, I don't understand that question.";
      _chatMessages.add({"role": "bot", "content": response});

      // Clear input field
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Palkhi ChatBot"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                final isUser = message['role'] == "user";

                return Container(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.deepPurple[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message['content']!,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _handleUserMessage(_messageController.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
