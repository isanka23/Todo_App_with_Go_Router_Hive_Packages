import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_sphere_app/models/note_model.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/text_styles.dart';

class SingleNotePage extends StatefulWidget {
  final Note note;
  const SingleNotePage({
    super.key,
    required this.note,
  });

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  @override
  Widget build(BuildContext context) {
    //formatted date
    final formattedDate = DateFormat.yMMMd().format(widget.note.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.title,
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.note.category,
              style: AppTextStyles.appButton.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              formattedDate,
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kFabColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.content,
              style: AppTextStyles.appDescriptionStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
