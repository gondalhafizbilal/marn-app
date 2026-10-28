import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/features/chatbot/data/models/chat_message.dart';
import 'package:marn/features/chatbot/data/repositories/chatbot_repository.dart';

class ChatbotState extends Equatable {
  const ChatbotState({this.messages = const [], this.isSending = false});

  final List<ChatMessage> messages;
  final bool isSending;

  ChatbotState copyWith({List<ChatMessage>? messages, bool? isSending}) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object?> get props => [messages, isSending];
}

class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit({required this.repository}) : super(const ChatbotState());

  final ChatbotRepository repository;

  Future<void> load() async {
    final messages = await repository.getInitialMessages();
    emit(state.copyWith(messages: messages));
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty) {
      return;
    }
    final userMessage = ChatMessage(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      text: text.trim(),
      isUser: true,
    );
    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isSending: true,
      ),
    );
    final reply = await repository.sendMessage(text.trim());
    emit(
      state.copyWith(messages: [...state.messages, reply], isSending: false),
    );
  }
}
