import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat.dart';

class ApiService {
  static const String baseUrl = 'https://api.thecatapi.com/v1/images/search';
  static const String _apiKey =
      'live_ZVjrZkwD4VIgoXz2GoBIjo6K5clgXCTLHaiZQ9ZTXP9AdNtGhpiO8l4CEqydMjdm';

  static Future<List<Cat>> fetchRandomCats(int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl?has_breeds=1&limit=$limit'),
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .where((json) => json['breeds'] != null && json['breeds'].isNotEmpty)
          .map((json) => Cat.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load cats: ${response.statusCode}');
    }
  }

  static Future<Cat?> fetchRandomCat() async {
    final cats = await fetchRandomCats(1);
    return cats.isNotEmpty ? cats.first : null;
  }
}
