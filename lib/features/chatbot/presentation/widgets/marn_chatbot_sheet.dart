import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/core/services/service_locator.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/features/chatbot/data/models/chat_message.dart';
import 'package:marn/features/chatbot/data/repositories/chatbot_repository.dart';
import 'package:marn/features/chatbot/logic/chatbot_cubit.dart';

Future<void> showMarnChatbotSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    barrierColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BlocProvider(
        create: (_) =>
            ChatbotCubit(repository: sl<ChatbotRepository>())..load(),
        child: const _MarnChatbotSheet(),
      );
    },
  );
}

class _MarnChatbotSheet extends StatefulWidget {
  const _MarnChatbotSheet();

  @override
  State<_MarnChatbotSheet> createState() => _MarnChatbotSheetState();
}

class _MarnChatbotSheetState extends State<_MarnChatbotSheet> {
  final TextEditingController _controller = TextEditingController();

  static const _categories = ['Housemaids', 'Housemaids Local', 'Hajj & Umrah'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    context.read<ChatbotCubit>().send(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .78,
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F1EC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 22),
              Container(
                width: 84,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D4CE),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.brandMaroon,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.baseWhite,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MARN AI Chatbot',
                          style: AppTypography.paragraph2(
                            const Color(0xFF24213A),
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Color(0xFF35D19A),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Online',
                              style: AppTypography.paragraph3(
                                const Color(0xFF9AA3AF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 32,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final selected = index == 0;
                    return _ChatCategoryChip(
                      label: _categories[index],
                      selected: selected,
                    );
                  },
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'Today',
                style: AppTypography.paragraph2(
                  const Color(0xFF24213A),
                ).copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ChatbotCubit, ChatbotState>(
                  builder: (context, state) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return _MessageBubble(message: message);
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<ChatbotCubit, ChatbotState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 14, 24, 22),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            minLines: 1,
                            maxLines: 3,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _send(),
                            decoration: InputDecoration(
                              hintText: 'write your message',
                              hintStyle: AppTypography.paragraph3(
                                const Color(0xFFA3ADB8),
                              ),
                              filled: true,
                              fillColor: AppColors.baseWhite,
                              suffixIcon: const Icon(
                                Icons.mic_none_rounded,
                                color: AppColors.brandMaroon,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: IconButton.filled(
                            onPressed: state.isSending ? null : _send,
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.brandMaroon,
                              disabledBackgroundColor: AppColors.brandMaroon
                                  .withValues(alpha: .55),
                            ),
                            icon: const Icon(Icons.send_rounded),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatCategoryChip extends StatelessWidget {
  const _ChatCategoryChip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppColors.brandMaroon : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.brandMaroon),
      ),
      child: Text(
        label,
        style: AppTypography.label4(
          selected ? AppColors.baseWhite : AppColors.brandMaroon,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[const _Avatar(), const SizedBox(width: 10)],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.brandMaroon : AppColors.baseWhite,
                    borderRadius: BorderRadius.circular(8).copyWith(
                      bottomRight: isUser ? Radius.zero : null,
                      bottomLeft: isUser ? null : Radius.zero,
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: AppTypography.paragraph4(
                      isUser ? AppColors.baseWhite : const Color(0xFF111827),
                    ).copyWith(height: 1.4),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isUser ? '1:22 AM' : '1:30 AM',
                  style: AppTypography.label4(const Color(0xFF9AA3AF)),
                ),
              ],
            ),
          ),
          if (isUser) ...[const SizedBox(width: 10), const _Avatar()],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFE7DDD0),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_rounded,
        color: Color(0xFF273746),
        size: 28,
      ),
    );
  }
}
