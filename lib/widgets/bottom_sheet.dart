import 'package:flutter/material.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/text_styles.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;
  const CategoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  State<CategoryInputBottomSheet> createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onNewNote,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a new note",
                    style: AppTextStyles.appDescriptionStyle,
                  ),
                  const Icon(Icons.arrow_right_alt_outlined)
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.5),
              thickness: 1,
            ),
            GestureDetector(
              onTap: widget.onNewCategory,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a new note category",
                    style: AppTextStyles.appDescriptionStyle,
                  ),
                  const Icon(Icons.arrow_right_alt_outlined)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
