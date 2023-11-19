import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/services/news/news_article.dart';

class CustomNewsTile extends StatefulWidget {
  final NewsArticle newsArticle;
  const CustomNewsTile({super.key, required this.newsArticle});

  @override
  State<CustomNewsTile> createState() => _CustomNewsTileState();
}

class _CustomNewsTileState extends State<CustomNewsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.brightColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(color: AppColors.darkColor, blurRadius: 3.0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.newsArticle.urlToImage),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              widget.newsArticle.source,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
