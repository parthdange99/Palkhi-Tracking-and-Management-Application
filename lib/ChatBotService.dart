import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBotService {
  final String apiKey = 'Your api key';  // Replace with your API Key

  // Endpoint for OpenAI's GPT-3 or ChatGPT model
  final String apiEndpoint = 'https://api.openai.com/v1/chat/completions';
  // Function to send a prompt to the OpenAI API and get a response
  Future<String> getResponse(String prompt) async {
    try {

      print(prompt);
      final response = await http.post(
        Uri.parse(apiEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",  // You can choose the model you want (like gpt-3.5-turbo or gpt-4)
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
          ],
          "max_tokens": 150,
          "temperature": 0.7,
        }),
      );
      print(response.body.toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String chatResponse = data['choices'][0]['message']['content'];
        return chatResponse;
      } else {
        return 'Error: Unable to get response from AI';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}