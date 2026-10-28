import 'package:marn/features/chatbot/data/models/chat_message.dart';

class ChatbotRepository {
  Future<List<ChatMessage>> getInitialMessages() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return const [
      ChatMessage(id: 'user-1', text: 'can it be negotiated ?', isUser: true),
      ChatMessage(
        id: 'assistant-1',
        text: 'Hi there, the price is negotiable',
        isUser: false,
      ),
      ChatMessage(
        id: 'user-2',
        text: 'Can you share available timings?',
        isUser: true,
      ),
      ChatMessage(
        id: 'assistant-2',
        text: 'Sure. I found morning and evening slots for this service.',
        isUser: false,
      ),
    ];
  }

  Future<ChatMessage> sendMessage(String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    return ChatMessage(
      id: 'assistant-${DateTime.now().millisecondsSinceEpoch}',
      text:
          'I found matching options for "$text". Open Browse or create a request to continue.',
      isUser: false,
    );
  }
}
