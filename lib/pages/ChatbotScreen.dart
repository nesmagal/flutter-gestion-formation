import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 🔹 Remplace par ta clé API Gemini
const String apiKey = 'AIzaSyDp2p3MyVwPoZKUQwCfk6ECR5p2dZpK-04';
const String model = 'gemini-2.5-pro';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  // 🔹 Fonction pour appeler l'API Gemini
  Future<String> getChatbotResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey', // ✅ Clé dans header
        },
        body: jsonEncode({
          "prompt": {
            "text": query,
          },
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Récupère le texte de la réponse
        if (data['candidates'] != null &&
            data['candidates'] is List &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['text'] != null) {
          return data['candidates'][0]['content']['text'];
        } else {
          return "Erreur: format de réponse inattendu.";
        }
      } else {
        print('Gemini API error: ${response.statusCode} - ${response.body}');
        return 'Erreur: ${response.statusCode} lors de l\'appel à l\'API.';
      }
    } catch (e) {
      print('Exception: $e');
      return 'Erreur réseau ou exception: $e';
    }
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({'text': text, 'isUser': true});
      _isLoading = true;
    });

    _messageController.clear();

    final response = await getChatbotResponse(text);

    setState(() {
      _messages.add({'text': response, 'isUser': false});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assistant Chatbot",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 80, color: Colors.grey[300]),
                        SizedBox(height: 20),
                        Text(
                          "Commencez une conversation",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return _buildMessageBubble(msg['text'], msg['isUser']);
                    },
                  ),
          ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 10),
                  Text("Le bot réfléchit...",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Tapez votre message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xFF1565C0),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? Color(0xFF1565C0) : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isUser ? Colors.white : Colors.black87, fontSize: 16),
        ),
      ),
    );
  }
}
