import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactService {
  // ============================================
  // SETUP INSTRUCTIONS (Choose one option):
  // ============================================
  //
  // OPTION 1: Formspree (Recommended - Free, Easy Setup)
  // 1. Go to https://formspree.io/
  // 2. Sign up for a free account
  // 3. Create a new form
  // 4. Copy your form ID (e.g., "xqkjvqkj")
  // 5. Replace 'YOUR_FORMSPREE_ID' below with your form ID
  // 6. Uncomment the Formspree option in sendMessage()
  //
  // OPTION 2: Web3Forms (Alternative - Free, No Signup Required)
  // 1. Go to https://web3forms.com/
  // 2. Enter your email and get your access key
  // 3. Replace 'YOUR_WEB3FORMS_KEY' below with your access key
  // 4. Uncomment the Web3Forms option in sendMessage()
  //
  // OPTION 3: EmailJS (Free tier available)
  // 1. Go to https://www.emailjs.com/
  // 2. Sign up and create a service
  // 3. Configure the constants below
  // 4. Uncomment the EmailJS option in sendMessage()
  //
  // OPTION 4: Your own backend API
  // 1. Set up your backend endpoint
  // 2. Replace apiEndpoint below
  // 3. Uncomment the API option in sendMessage()
  // ============================================

  // Formspree Configuration
  static const String formspreeId = 'mblnkzwa';
  // Example: 'xqkjvqkj' (get this from https://formspree.io/)

  // Web3Forms Configuration
  static const String web3formsKey = 'YOUR_WEB3FORMS_KEY';
  // Example: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'

  // EmailJS Configuration (if using)
  // static const String emailjsServiceId = 'YOUR_SERVICE_ID';
  // static const String emailjsTemplateId = 'YOUR_TEMPLATE_ID';
  // static const String emailjsPublicKey = 'YOUR_PUBLIC_KEY';

  // Backend API Configuration (if using)
  static const String apiEndpoint = 'https://formspree.io/f/';

  Future<Map<String, dynamic>> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      // OPTION 1: Formspree (Recommended - Free, Easy)
      // Uncomment the line below and replace YOUR_FORMSPREE_ID with your form ID
      return await sendViaFormspree(name: name, email: email, message: message);

      // OPTION 2: Web3Forms (Alternative - Free, No Signup)
      // Uncomment the line below and replace YOUR_WEB3FORMS_KEY with your access key
      // return await sendViaWeb3Forms(name: name, email: email, message: message);

      // OPTION 3: EmailJS (Free tier available)
      // return await _sendViaEmailJS(name, email, message);

      // OPTION 4: Your own backend API
      // return await _sendViaAPI(name, email, message);

      // For development/testing: Use mock send (logs to console)
      // Remove this when you configure a real service
      // return await _mockSend(name, email, message);
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to send message: ${e.toString()}',
      };
    }
  }

  // Method 1: Send via Backend API
  Future<Map<String, dynamic>> _sendViaAPI(
    String name,
    String email,
    String message,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(apiEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'message': message,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Message sent successfully!',
        };
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Method 2: Send via EmailJS (uncomment and configure if needed)
  /*
  Future<Map<String, dynamic>> _sendViaEmailJS(
    String name,
    String email,
    String message,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': emailjsServiceId,
          'template_id': emailjsTemplateId,
          'user_id': emailjsPublicKey,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message,
          },
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Message sent successfully!',
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to send email',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
  */

  // Method 3: Mock send for development/testing
  Future<Map<String, dynamic>> _mockSend(
    String name,
    String email,
    String message,
  ) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Log the message (in production, you'd send this to your backend)
    print('Contact Form Submission:');
    print('Name: $name');
    print('Email: $email');
    print('Message: $message');

    return {
      'success': true,
      'message': 'Message received! (This is a mock response)',
    };
  }

  // Method 1: Send via Formspree (Free, Easy Setup)
  Future<Map<String, dynamic>> sendViaFormspree({
    required String name,
    required String email,
    required String message,
  }) async {
    if (formspreeId == 'YOUR_FORMSPREE_ID') {
      return {
        'success': false,
        'message': 'Please configure your Formspree ID in contact_service.dart',
      };
    }

    try {
      final response = await http.post(
        Uri.parse('https://formspree.io/f/$formspreeId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'message': message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Message sent successfully! I\'ll get back to you soon.',
        };
      } else {
        final errorBody = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              errorBody['error'] ?? 'Failed to send message. Please try again.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Method 2: Send via Web3Forms (Free, No Signup Required)
  Future<Map<String, dynamic>> sendViaWeb3Forms({
    required String name,
    required String email,
    required String message,
  }) async {
    if (web3formsKey == 'YOUR_WEB3FORMS_KEY') {
      return {
        'success': false,
        'message':
            'Please configure your Web3Forms access key in contact_service.dart',
      };
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.web3forms.com/submit'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'access_key': web3formsKey,
          'subject': 'New Contact Form Message from Portfolio',
          'name': name,
          'email': email,
          'message': message,
          'from_name': name,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        return {
          'success': true,
          'message': 'Message sent successfully! I\'ll get back to you soon.',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ??
              'Failed to send message. Please try again.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }
}
