import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger/constants/app_colors.dart';

class CustomDatePicker extends StatefulWidget {
  final String text;
  final void Function(DateTime?) onDateSelected; // New callback function

  const CustomDatePicker({
    super.key,
    required this.text,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TextEditingController dateController = TextEditingController();
  DateTime? newDate;

  // Function to pick a date with showDatePicker
  void pickDate() async {
    newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.teal,
              ),
            ),
            child: child!);
      },
    );

    // If user clicks on cancel, newDate will be null so return nothing
    if (newDate != null) {
      String formattedDate = DateFormat("MM-dd-yyyy").format(newDate!);
      // If newDate isn't null, set date to the newDate
      setState(
        () {
          dateController.text = formattedDate;
          widget.onDateSelected(newDate); // Call the callback function
        },
      );
    } else {
      return;
    }
  }

  // Function to return newDate in DateTime
  DateTime? returnDate() {
    return newDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: TextField(
          style: TextStyle(color: AppColors.brightColor),
          controller: dateController,
          decoration: InputDecoration(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.brightColor,
            ),
            labelText: widget.text,
            labelStyle: TextStyle(color: AppColors.brightColor),
          ),
          readOnly: true,
          onTap: pickDate,
        ),
      ),
    );
  }
}
