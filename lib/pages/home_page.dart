import 'package:flutter/material.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/text_styles.dart';
import 'package:note_sphere_app/widgets/notes_todo_card.dart';
import 'package:note_sphere_app/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteSphere",
          style: AppTextStyles.appTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: AppConstants.kDefaultPadding),
            const ProgressCard(
              completedTask: 2,
              totalTask: 5,
            ),
            const SizedBox(height: AppConstants.kDefaultPadding * 1.5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NotesTodoCard(
                  title: "notes",
                  description: "3 notes",
                  icon: Icons.bookmark_add_outlined,
                ),
                NotesTodoCard(
                  title: "To-Do-List",
                  description: "3 Tasks",
                  icon: Icons.today_outlined,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.kDefaultPadding * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todat's Progress",
                  style: AppTextStyles.appSubTitle,
                ),
                const Text(
                  "see all",
                  style: AppTextStyles.appButton,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
