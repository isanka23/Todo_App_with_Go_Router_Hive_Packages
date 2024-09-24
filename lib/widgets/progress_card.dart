import 'package:flutter/material.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/text_styles.dart';

class ProgressCard extends StatefulWidget {
  final int completedTask;
  final int totalTask;

  const ProgressCard({
    super.key,
    required this.completedTask,
    required this.totalTask,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    //calculate the percentage of the completed task
    double percentage = widget.totalTask != 0
        ? (widget.completedTask / widget.totalTask) * 100
        : 0;
    return Container(
      padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: AppTextStyles.appSubTitle,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  "You Have Completed ${widget.completedTask} out of ${widget.totalTask} tasks \nkeep up the progress!",
                  style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.19,
                height: MediaQuery.of(context).size.width * 0.19,
                decoration: BoxDecoration(
                    gradient: AppColors().kPrimaryGradient,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  "$percentage%",
                  style: AppTextStyles.appSubTitle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
