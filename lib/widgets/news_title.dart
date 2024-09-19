import 'package:flutter/material.dart';
import '../models/news.dart';
import '../screens/news_detail_screen.dart';
// import '../screens/news_details_screen.dart';

class NewsTile extends StatelessWidget {
  final News news;

  NewsTile({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(news: news),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            if (news.urlToImage != null && news.urlToImage!.isNotEmpty)
              Image.network(news.urlToImage!)
            else
              Placeholder(fallbackHeight: 200, fallbackWidth: double.infinity),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.title ?? 'No Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.description ?? 'No Description Available',
              ),
            ),
          ],
        ),
      ),
    );
  }
}