import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class AuthService {
  final String baseUrl = 'http://139.59.65.225:8052';

  // Login method
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];

      // Decode token to get role
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      String role = payload['role'];

      // Store token and role in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);
      await prefs.setString('userRole', role);

      return true;
    } else {
      print('Failed to log in: ${response.body}');
      return false;
    }
  }

  // Register method
  Future<bool> register(Map<String, dynamic> user) async {
    final url = Uri.parse('$baseUrl/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(user);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);

      return true;
    } else {
      print('Failed to register: ${response.body}');
      return false;
    }
  }

  // Image and Product Upload method
  Future<void> uploadProductAndImage(Map<String, dynamic> product, XFile? image, Uint8List? imageData) async {
    var uri = Uri.parse('$baseUrl/save');
    var request = http.MultipartRequest('POST', uri);

    // Add the product data as a JSON file
    request.files.add(
      http.MultipartFile.fromString(
        'product',
        jsonEncode(product),
        contentType: MediaType('application', 'json'),
      ),
    );

    // Add the image if provided
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );
    }

    // Handle web-specific case if imageData is provided
    if (kIsWeb && imageData != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageData,
        filename: 'upload.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
    } else if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    // Send the request
    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Product and image uploaded successfully');
      } else {
        print('Failed to upload product and image');
      }
    } catch (e) {
      print('Error during image upload: $e');
    }
  }

  // Get the stored auth token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Get the stored user role
  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }

  // Check if the token has expired
  Future<bool> isTokenExpired() async {
    String? token = await getToken();
    if (token != null) {
      DateTime expiryDate = Jwt.getExpiryDate(token)!;
      return DateTime.now().isAfter(expiryDate);
    }
    return true;
  }

  // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    String? token = await getToken();
    if (token != null && !(await isTokenExpired())) {
      return true;
    } else {
      await logout();
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('userRole');
  }

  // Check if the user has a specific role
  Future<bool> hasRole(List<String> roles) async {
    String? role = await getUserRole();
    return role != null && roles.contains(role);
  }

  // Check if the user is an admin
  Future<bool> isAdmin() async {
    return await hasRole(['ADMIN']);
  }

  // Check if the user is a regular user
  Future<bool> isUser() async {
    return await hasRole(['USER']);
  }
}
