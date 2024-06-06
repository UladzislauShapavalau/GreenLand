import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:greenland/src/data/plant.dart';

Future<List<Plant>> fetchPlants() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');

  final url = 'http://localhost:8000/api/plants';
  final headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.toString(),
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Plant.fromJson(json)).toList();
    } else {
      print('Failed to fetch plants: ${response.body}');
      return [];
    }
  } catch (error) {
    print('Error fetching plants: $error');
    return [];
  }
}
