import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static Future<List<UserModel>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    
    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['data'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}