import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
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
    const AssetImage("assets/logo_short.png"),
  );

  late GenerativeModel model;

  @override
  void onInit() {
    super.onInit();
    loadProfileImage();
    model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: "AIzaSyBS4EW0QkufOlqaGsxNUGtqJC08oZqoM44",
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userId");

    if (userId == null) {
      profileImage.value = const AssetImage("assets/logo_short.png");
      return;
    }

    String? localPath = prefs.getString("profileImage");
    String? cloudUrl = prefs.getString("profileImageUrl");

    if (localPath != null &&
        localPath.isNotEmpty &&
        File(localPath).existsSync()) {
      profileImage.value = FileImage(File(localPath));
    } else if (cloudUrl != null && cloudUrl.isNotEmpty) {
      profileImage.value = NetworkImage(cloudUrl);
    }
  }

  Future<String> getAIResponse(String message) async {
    try {
      final response = await model.generateContent([Content.text(message)]);
      return response.text ?? "No response from AI";
    } catch (e) {
      log("Gemini error: $e");
      return "Something went wrong";
    }
  }

  void sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add({"text": text, "isUser": true});
    isLoading.value = true;

    messageController.clear();
    focusNode.requestFocus();

    await Future.delayed(const Duration(milliseconds: 100));
    scrollToBottom();

    final aiResponse = await getAIResponse(text);

    messages.add({"text": aiResponse, "isUser": false});
    isLoading.value = false;

    scrollToBottom();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
