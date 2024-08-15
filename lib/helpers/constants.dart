import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tanzmed/helpers/settings.dart';

class ApiClient {
  ApiClient();
  final box = GetStorage();
  Future<String?> getToken() async {
    // Retrieve the authentication token from secure storage.
    String? secureStorage = box.read("access_token");
    return secureStorage;
  }

  Future<http.Response> get(String path) async {
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('${AppSettings.baseUrl}$path');

    try {
      final response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      throw Exception('Failed to perform GET request: $e');
    }
  }

  Future<http.Response> post(String path, {dynamic body}) async {
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('${AppSettings.baseUrl}$path');

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      return response;
    } catch (e) {
      throw Exception('Failed to perform POST request: $e');
    }
  }

  Future<http.StreamedResponse> multipart(String path, var imageData) async {
    final token = await getToken();
    // final headers = {
    //   'Content-Type': 'application/json',
    //   if (token != null) 'Authorization': 'Bearer $token',
    // };

    final Uri uri = Uri.parse('${AppSettings.baseUrl}$path');

    try {
      final request = http.MultipartRequest('POST', uri);

      // Attach the image file

      request.files.add(
        http.MultipartFile.fromBytes(
          'avatar',
          imageData,
          filename: 'image.jpg',
        ),
      );

      // Attach other form fields if needed
      // request.fields['caption'] = captionController.text;
      request.headers['Authorization'] = 'Bearer $token';

      var response = request.send();

      return response;
    } catch (e) {
      throw Exception('Failed to perform POST request: $e');
    }
  }
}
// 
// import 'package:http/http.dart' as http;