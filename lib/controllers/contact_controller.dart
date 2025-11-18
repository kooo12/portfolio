import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/contact_service.dart';

class ContactController extends GetxController {
  final ContactService _contactService = ContactService();

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Observable states
  var isSubmitting = false.obs;
  var submitSuccess = false.obs;
  var errorMessage = ''.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  // Validate email format
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Validate message
  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a message';
    }
    if (value.length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  // Submit contact form
  Future<void> submitContactForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = '';
    submitSuccess.value = false;

    try {
      final result = await _contactService.sendMessage(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        message: messageController.text.trim(),
      );

      if (result['success'] == true) {
        submitSuccess.value = true;
        // Clear form after successful submission
        nameController.clear();
        emailController.clear();
        messageController.clear();

        // Show success message
        Get.snackbar(
          'Success',
          result['message'] ?? 'Message sent successfully!',
          snackPosition: SnackPosition.bottom,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        errorMessage.value = result['message'] ?? 'Failed to send message';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.bottom,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.bottom,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // Reset form
  void resetForm() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
    formKey.currentState?.reset();
    errorMessage.value = '';
    submitSuccess.value = false;
  }
}
