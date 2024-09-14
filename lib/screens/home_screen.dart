import 'package:flutter/material.dart';
import '../services/news_api.dart';
import '../models/news.dart';
import '../widgets/news_title.dart';

class HomeScreen extends StatelessWidget {
  final NewsApi newsApi = NewsApi();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder<List<News>>(
        future: newsApi.fetchNews('general'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load news'));
          } else {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return NewsTile(news: newsList[index]);
              },
            );
          }
        },
      ),
    );
  }
}
