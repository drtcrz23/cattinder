import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_models.dart';

class ApiService {
  static const String baseUrl = 'https://api.thecatapi.com/v1/images/search';
  static const String _apiKey =
      'live_ZVjrZkwD4VIgoXz2GoBIjo6K5clgXCTLHaiZQ9ZTXP9AdNtGhpiO8l4CEqydMjdm';

  Future<CatModel?> fetchRandomCats() async {
    final response = await http.get(
      Uri.parse('$baseUrl?has_breeds=1&limit=1'),
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return CatModel.fromJson(data[0]);
      }
      return null;
    } else {
      throw Exception('Failed to load cats: ${response.statusCode}');
    }
  }

  // static Future<CatModel?> fetchRandomCat() async {
  //   final cats = await fetchRandomCats();
  //   return cats.isNotEmpty ? cats.first : null;
  // }
}
