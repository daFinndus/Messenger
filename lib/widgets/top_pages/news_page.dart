import 'package:flutter/material.dart';
import 'package:messenger/services/news/news_article.dart';
import 'package:messenger/services/news/news_api.dart';
import 'package:messenger/widgets/components/news_tile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewsPage> {
  NewsAPI client = NewsAPI();

// FIXME: Builder doesn't work yet
// Only the CPI is displayed

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: client.getArticle(),
      builder:
          (BuildContext context, AsyncSnapshot<List<NewsArticle>> snapshot) {
        if (snapshot.hasData) {
          List<NewsArticle> articles = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index) => CustomNewsTile(
              newsArticle: articles[index],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
