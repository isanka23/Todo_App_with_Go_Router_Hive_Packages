import 'package:flutter/material.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/text_styles.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  final bool isComplted;
  const TodoCard({
    super.key,
    required this.todo,
    required this.isComplted,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          widget.todo.title,
          style: AppTextStyles.appDescriptionStyle,
        ),
        subtitle: Row(
          children: [
            Text(
              "${widget.todo.date.day} /${widget.todo.time.month} /${widget.todo.time.year}  ",
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "${widget.todo.date.hour}:${widget.todo.time.minute}",
              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isComplted,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
