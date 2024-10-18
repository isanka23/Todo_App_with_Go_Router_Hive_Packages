import 'package:flutter/material.dart';
import 'package:note_sphere_app/models/note_model.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/services/note_service.dart';
import 'package:note_sphere_app/services/todo_service.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/router.dart';
import 'package:note_sphere_app/utils/text_styles.dart';
import 'package:note_sphere_app/widgets/main_screen_todo_card.dart';
import 'package:note_sphere_app/widgets/notes_todo_card.dart';
import 'package:note_sphere_app/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> allNote = [];
  List<Todo> allTodos = [];

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser =
        await NoteService().isNewUser() || await TodoService().isNewUser();

    if (isNewUser) {
      await NoteService().createInitialNotes();
      await TodoService().createIntialTodos();
    }
    _loadNotes();
    _loadTodos();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await NoteService().loadNotes();

    setState(() {
      allNote = loadedNotes;
    });
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await TodoService().loadTodos();

    setState(() {
      allTodos = loadedTodos;
    });
  }

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
            ProgressCard(
              completedTask: allTodos.where((todo) => todo.isDone).length,
              totalTask: allTodos.length,
            ),
            const SizedBox(height: AppConstants.kDefaultPadding * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: NotesTodoCard(
                    title: "notes",
                    description: "${allNote.length.toString()} notes",
                    icon: Icons.bookmark_add_outlined,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todos");
                  },
                  child: NotesTodoCard(
                    title: "To-Do-List",
                    description: "${allTodos.length.toString()} Tasks",
                    icon: Icons.today_outlined,
                  ),
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
            const SizedBox(
              height: 20,
            ),
            allTodos.isEmpty
                ? Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "No Task for today, add some task to get started!",
                            style: AppTextStyles.appDescriptionStyle.copyWith(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              AppRouter.router.push("/todos");
                            },
                            child: const Text("Add Task"),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: allTodos.length,
                      itemBuilder: (context, index) {
                        final Todo todo = allTodos[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: MainScreenTodoCard(
                            title: todo.title,
                            date: todo.date.toString(),
                            time: todo.time.toString(),
                            isDone: todo.isDone,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
