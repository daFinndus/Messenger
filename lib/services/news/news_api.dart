import 'dart:convert';

import 'package:http/http.dart';
import 'package:messenger/services/news/news_article.dart';

class NewsAPI {
  // NOTE: Change country based on your location
  final newsURL =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=fe6d8765ae134045b52b4e5fa62eeb0e";

  Future<List<NewsArticle>> getArticle() async {
    Response res = await get(Uri.parse(newsURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<NewsArticle> articles =
          body.map((dynamic item) => NewsArticle.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the articles");
    }
  }
}
