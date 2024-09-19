import 'package:flutter/material.dart';
import '../models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title ?? 'No Title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.urlToImage != null && news.urlToImage!.isNotEmpty)
              Image.network(news.urlToImage!)
            else
              Placeholder(fallbackHeight: 200, fallbackWidth: double.infinity),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.description ?? 'No Description Available',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.content ?? 'No Content Available',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
