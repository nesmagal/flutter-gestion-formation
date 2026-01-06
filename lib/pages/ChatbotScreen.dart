import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Constantes de l'API (à placer AVANT la classe ChatbotScreen)
const String apiKey = 'AIzaSyDp2p3MyVwPoZKUQwCfk6ECR5p2dZpK-04';
const String model = 'gemini-3-flash-preview';
const String apiUrl = 
    'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey&quot';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  // Fonction pour obtenir la réponse du chatbot via l'API Gemini
  Future<String> getChatbotResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': query}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'];

        // Vérification défensive de la structure de la réponse
        if (candidates != null &&
            candidates is List &&
            candidates.isNotEmpty &&
            candidates[0]['content'] != null &&
            candidates[0]['content']['parts'] != null &&
            candidates[0]['content']['parts'] is List &&
            candidates[0]['content']['parts'].isNotEmpty &&
            candidates[0]['content']['parts'][0]['text'] != null) {
          return candidates[0]['content']['parts'][0]['text'];
        } else {
          return "Désolé, je n'ai pas pu générer une réponse.";
        }
      } else {
        return "Erreur: ${response.statusCode}";
      }
    } catch (e) {
      return "Erreur de connexion: $e";
    }
  }

  // Fonction pour envoyer un message
  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text;
    _messageController.clear();

    setState(() {
      _messages.add({
        'text': userMessage,
        'isUser': true,
      });
      _isLoading = true;
    });

    // Appel à l'API Gemini
    final botResponse = await getChatbotResponse(userMessage);

    setState(() {
      _messages.add({
        'text': botResponse,
        'isUser': false,
      });
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assistant Chatbot",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                             size: 80, 
                             color: Colors.grey[300]),
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
                      final message = _messages[index];
                      return _buildMessageBubble(
                        message['text'],
                        message['isUser'],
                      );
                    },
                  ),
          ),
          
          // Indicateur de chargement
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  CircularProgressIndicator(strokeWidth: 2),
                  SizedBox(width: 12),
                  Text(
                    "Le bot écrit...",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          // Zone de saisie
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20, 
                        vertical: 10
                      ),
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
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? Color(0xFF1565C0) : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}