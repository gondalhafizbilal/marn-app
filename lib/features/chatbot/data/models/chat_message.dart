class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
  });

  final String id;
  final String text;
  final bool isUser;
}
