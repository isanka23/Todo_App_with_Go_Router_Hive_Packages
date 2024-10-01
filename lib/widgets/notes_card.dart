import 'package:flutter/material.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/text_styles.dart';

class NotesCard extends StatelessWidget {
  final String notesCategory;
  final int noOfNotes;
  const NotesCard({
    super.key,
    required this.notesCategory,
    required this.noOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notesCategory,
            style:
                AppTextStyles.appSubTitle.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            "$noOfNotes notes",
            style: AppTextStyles.appBody.copyWith(
              color: AppColors.kWhiteColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
