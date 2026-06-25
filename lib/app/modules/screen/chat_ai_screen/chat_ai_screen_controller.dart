import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AiChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ImageProvider> profileImage =
      Rx<ImageProvider>(const AssetImage("assets/logo_short.png"));

  late GenerativeModel _model;

  @override
  void onInit() {
    super.onInit();
    _initModel();
    _loadProfileImage();
  }

  void _initModel() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: "AIzaSyBS4EW0QkufOlqaGsxNUGtqJC08oZqoM44",
    );
  }

  Future<void> _loadProfileImage() async {
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
  }

  Future<String> _getAIResponse(String message) async {
    try {
      final response =
          await _model.generateContent([Content.text(message)]);
      return response.text ?? "No response from AI.";
    } catch (e) {
      log("Gemini error: $e");
      return "Something went wrong. Please try again.";
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    isLoading.value = true;
    messageController.clear();
    focusNode.requestFocus();

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollToBottom();

    final aiResponse = await _getAIResponse(text);

    messages.add(ChatMessage(
      text: aiResponse,
      isUser: false,
      timestamp: DateTime.now(),
    ));

    isLoading.value = false;
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}