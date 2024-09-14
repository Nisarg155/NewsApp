import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsApi {
  final String apiKey = 'a21390a3d5374e1f8b23c1259425050b';
  final String baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<News>> fetchNews(String category) async {
    final url = '$baseUrl?q=demon slayer&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        final List<News> newsList = (jsonData['articles'] as List)
            .map((json) => News.fromJson(json))
            .toList();

        if (newsList.isNotEmpty) {
          return newsList;
        } else {
          throw Exception('No news articles found');
        }
      } else {
        throw Exception('Error in API response: ${jsonData['status']}');
      }
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to load news with status code: ${response.statusCode}');
    }
  }
}
