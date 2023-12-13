import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/services/news/news_article.dart';

class NewsArticlePage extends StatelessWidget {
  final NewsArticle newsArticle;
  const NewsArticlePage({super.key, required this.newsArticle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          newsArticle.title,
          style: TextStyle(color: AppColors.brightColor),
        ),
        iconTheme: IconThemeData(
          color: AppColors.brightColor,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(newsArticle.urlToImage),
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              newsArticle.content,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16.0,
            ),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://www.google.com')),
              child: const Text(
                'Read more',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
