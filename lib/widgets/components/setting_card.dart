import 'package:flutter/material.dart';
import 'package:messenger/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomSettingCard extends StatefulWidget {
  final String title; // Title of the setting card
  final String imageURL; // Image path of the setting card
  final Function function; // Function for the setting card

  const CustomSettingCard(
      {super.key,
      required this.title,
      required this.imageURL,
      required this.function});

  @override
  State<CustomSettingCard> createState() => _CustomSettingCardState();
}

class _CustomSettingCardState extends State<CustomSettingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 84.0,
      margin: const EdgeInsets.all(24.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.primaryColor),
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            margin: const EdgeInsets.only(right: 16.0),
            child: CachedNetworkImage(
              imageUrl: widget.imageURL,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.brightColor),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => widget.function(),
            child: Icon(Icons.edit, color: AppColors.brightColor),
          )
        ],
      ),
    );
  }
}
