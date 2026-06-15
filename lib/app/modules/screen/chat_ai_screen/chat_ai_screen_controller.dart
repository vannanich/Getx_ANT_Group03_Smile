import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ImageProvider> profileImage = Rx<ImageProvider>(
    const NetworkImage(
      "https://ui-avatars.com/api/?name=Me&background=5B13EC&color=ffffff&size=128",
    ),
  );

  late GenerativeModel _model;
  late ChatSession _chat;

  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
  @override
  void onInit() {
    super.onInit();
    loadProfileImage();
    _initGemini();
  }

  void _initGemini() {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.8,
        maxOutputTokens: 512, // reduced to stay within free tier limits
      ),
      systemInstruction: Content.system(
        "You are a helpful and empathetic AI health assistant. "
        "Keep your answers concise and supportive. "
        "Always recommend consulting a doctor for serious concerns.",
      ),
    );
    _chat = _model.startChat();
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  // ── Profile image ─────────────────────────────────────────────────────────
  Future<void> loadProfileImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt("userId");
      if (userId == null) return;
      final String? localPath = prefs.getString("profileImage");
      final String? cloudUrl = prefs.getString("profileImageUrl");
      if (localPath != null &&
          localPath.isNotEmpty &&
          File(localPath).existsSync()) {
        profileImage.value = FileImage(File(localPath));
      } else if (cloudUrl != null && cloudUrl.isNotEmpty) {
        profileImage.value = NetworkImage(cloudUrl);
      }
    } catch (e) {
      log("loadProfileImage error: $e");
    }
  }

  // ── Send message with retry ───────────────────────────────────────────────
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty || isLoading.value) return;

    messages.add({"text": text, "isUser": true});
    messageController.clear();
    focusNode.requestFocus();
    isLoading.value = true;
    _scrollToBottom();

    String? reply = await _tryGetResponse(text, retries: 3);

    messages.add({
      "text": reply ?? "I'm having trouble responding right now. Please try again in a moment.",
      "isUser": false,
    });

    isLoading.value = false;
    _scrollToBottom();
  }

  // Retries up to [retries] times with increasing delay on quota errors
  Future<String?> _tryGetResponse(String text, {int retries = 3}) async {
    for (int attempt = 1; attempt <= retries; attempt++) {
      try {
        final response = await _chat.sendMessage(Content.text(text));
        final reply = response.text?.trim();
        if (reply != null && reply.isNotEmpty) return reply;
        return "I didn't get a response. Please try again.";
      } on GenerativeAIException catch (e) {
        log("Gemini attempt $attempt error: $e");
        final msg = e.message.toLowerCase();

        if (msg.contains('quota') || msg.contains('limit') || msg.contains('429')) {
          if (attempt < retries) {
            // Wait longer each retry: 2s, 4s, 8s
            await Future.delayed(Duration(seconds: 2 * attempt));
            continue;
          }
          return "I've reached my request limit. Please wait a moment and try again.";
        }

        if (msg.contains('api key') || msg.contains('invalid')) {
          return "⚠️ Invalid API key. Please update the key in the app settings.";
        }

        return "Something went wrong. Please try again.";
      } catch (e) {
        log("Unexpected error: $e");
        if (attempt < retries) {
          await Future.delayed(Duration(seconds: attempt));
          continue;
        }
        return "Connection error. Please check your internet and try again.";
      }
    }
    return null;
  }

  // ── Clear chat ────────────────────────────────────────────────────────────
  void clearChat() {
    messages.clear();
    _chat = _model.startChat();
  }

  // ── Scroll ────────────────────────────────────────────────────────────────
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}