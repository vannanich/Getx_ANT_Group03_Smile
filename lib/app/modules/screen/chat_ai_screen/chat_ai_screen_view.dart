import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const _purple      = Color(0xFF5B13EC);
const _purpleLight = Color(0xFFF3EEFF);
const _purpleMid   = Color(0xFF9C6BFF);
const _bg          = Color(0xFFF7F4FF);
const _dark        = Color(0xFF1A1A2E);
const _grey        = Color(0xFF9B8AB8);
const _border      = Color(0xFFE8E0F7);

class AiChatView extends GetView<AiChatController> {
  const AiChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _border, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15,
                color: _purple,
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // AI avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [_purpleMid, _purple],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _purple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.psychology_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Assistant',
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _dark,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF12B76A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style: GoogleFonts.balsamiqSans(
                        fontSize: 11,
                        color: const Color(0xFF12B76A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          // Clear chat button
          GestureDetector(
            onTap: () => _showClearDialog(context),
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _border, width: 1.5),
              ),
              child: const Icon(
                Icons.refresh_rounded,
                size: 18,
                color: _grey,
              ),
            ),
          ),
          // Profile image
          Obx(() => Container(
                margin: const EdgeInsets.only(right: 14),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _border, width: 2),
                  image: DecorationImage(
                    image: controller.profileImage.value,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        ],
      ),

      // ── Body ───────────────────────────────────────────────────────────────
      body: Column(
        children: [
          // Thin divider
          Container(height: 1, color: _border),

          // Messages
          Expanded(
            child: Obx(() => controller.messages.isEmpty
                ? _EmptyState()
                : ListView.builder(
                    controller: controller.scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    itemCount: controller.messages.length +
                        (controller.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < controller.messages.length) {
                        return _MessageBubble(
                            msg: controller.messages[index]);
                      }
                      return const _TypingIndicator();
                    },
                  )),
          ),

          // Input bar
          _InputBar(),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Clear chat?',
          style: GoogleFonts.balsamiqSans(
            fontWeight: FontWeight.bold,
            color: _dark,
          ),
        ),
        content: Text(
          'This will delete all messages and start a new conversation.',
          style: GoogleFonts.balsamiqSans(color: _grey, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.balsamiqSans(color: _grey)),
          ),
          GestureDetector(
            onTap: () {
              controller.clearChat();
              Get.back();
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_purpleMid, _purple],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Clear',
                style: GoogleFonts.balsamiqSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [_purpleMid, _purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: _purple.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Hello! I\'m your AI assistant',
            style: GoogleFonts.balsamiqSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _dark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Ask me anything about your health,\nI'm here to help you.",
            textAlign: TextAlign.center,
            style: GoogleFonts.balsamiqSans(
              fontSize: 14,
              color: _grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Suggestion chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _SuggestionChip('💊 What are common vitamins?'),
                _SuggestionChip('🧘 Tips for reducing stress'),
                _SuggestionChip('😴 How to sleep better?'),
                _SuggestionChip('🏃 Beginner exercise tips'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionChip extends GetView<AiChatController> {
  final String label;
  const _SuggestionChip(this.label);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Strip emoji prefix for cleaner message
        final text = label.replaceAll(RegExp(r'^[\S]+ '), '');
        controller.messageController.text = text;
        controller.sendMessage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.balsamiqSans(
            fontSize: 13,
            color: _dark,
          ),
        ),
      ),
    );
  }
}

// ── Message bubble ────────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> msg;
  const _MessageBubble({required this.msg});

  @override
  Widget build(BuildContext context) {
    final isUser = msg['isUser'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // AI avatar
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [_purpleMid, _purple],
                ),
              ),
              child: const Icon(Icons.psychology_rounded,
                  color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
          ],

          // Bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [_purpleMid, _purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isUser ? null : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                border: isUser
                    ? null
                    : Border.all(color: _border, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: isUser
                        ? _purple.withOpacity(0.25)
                        : Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                msg['text'] as String,
                style: GoogleFonts.balsamiqSans(
                  fontSize: 14,
                  color: isUser ? Colors.white : _dark,
                  height: 1.5,
                ),
              ),
            ),
          ),

          // User avatar spacer
          if (isUser) const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ── Typing indicator ──────────────────────────────────────────────────────────
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [_purpleMid, _purple],
              ),
            ),
            child: const Icon(Icons.psychology_rounded,
                color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              border: Border.all(color: _border, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: _purple,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'AI is typing...',
                  style: GoogleFonts.balsamiqSans(
                    fontSize: 13,
                    color: _grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Input bar ─────────────────────────────────────────────────────────────────
class _InputBar extends GetView<AiChatController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Text field
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: _bg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _border, width: 1.5),
                  ),
                  child: TextField(
                    controller: controller.messageController,
                    focusNode: controller.focusNode,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => controller.sendMessage(),
                    maxLines: null,
                    style: GoogleFonts.balsamiqSans(
                      fontSize: 14,
                      color: _dark,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ask something...',
                      hintStyle: GoogleFonts.balsamiqSans(
                        color: _grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Send button
              Obx(() => GestureDetector(
                    onTap: controller.isLoading.value
                        ? null
                        : controller.sendMessage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: controller.isLoading.value
                            ? null
                            : const LinearGradient(
                                colors: [_purpleMid, _purple],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        color: controller.isLoading.value
                            ? _border
                            : null,
                        boxShadow: controller.isLoading.value
                            ? []
                            : [
                                BoxShadow(
                                  color: _purple.withOpacity(0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                      ),
                      child: controller.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.all(14),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: _grey,
                              ),
                            )
                          : const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}