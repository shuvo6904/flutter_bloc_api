import 'package:flutter_bloc_api/api/api_provider.dart';
import 'package:flutter_bloc_api/models/user.dart';

class APIRepository {
  final APIProvider apiProvider;

  APIRepository({required this.apiProvider});

  Future<List<User>> getUsers() async {
    final response = await apiProvider.fetchUsers();
    return User.fromJsonList(response.body);
  }
}
