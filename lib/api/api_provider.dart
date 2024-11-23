import 'package:http/http.dart' as http;

class APIProvider {
  final String baseUrl;

  APIProvider({required this.baseUrl});

  Future<http.Response> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to load users');
    }
    return response;
  }
}
