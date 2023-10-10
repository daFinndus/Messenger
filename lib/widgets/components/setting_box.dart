import 'package:flutter/material.dart';
import 'package:messenger/app_colors.dart';

class CustomSettingBox extends StatefulWidget {
  final String title;
  final Function function;

  const CustomSettingBox(
      {super.key, required this.title, required this.function});

  @override
  State<CustomSettingBox> createState() => _CustomSettingBoxState();
}

class _CustomSettingBoxState extends State<CustomSettingBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500.0,
        height: 60,
        child: ElevatedButton(
          onPressed: () => widget.function(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ]),
        ));
  }
}
