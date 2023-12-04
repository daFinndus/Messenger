import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:messenger/services/news/news_article.dart';
import 'package:messenger/widgets/components/news_article_page.dart';

class CustomNewsTile extends StatefulWidget {
  final NewsArticle newsArticle;
  const CustomNewsTile({super.key, required this.newsArticle});

  @override
  State<CustomNewsTile> createState() => _CustomNewsTileState();
}

class _CustomNewsTileState extends State<CustomNewsTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsArticlePage(
              newsArticle: widget.newsArticle,
            ),
          ),
        );
      },
      child: Container(
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
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.newsArticle.urlToImage),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              width: double.infinity,
              height: 36.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.primaryColor,
              ),
              child: Text(
                widget.newsArticle.author,
                style: TextStyle(
                    color: AppColors.brightColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.brightColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                widget.newsArticle.title,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
