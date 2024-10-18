import 'package:flutter/material.dart';
import 'package:note_sphere_app/helpers/helpers.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/services/todo_service.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/text_styles.dart';
import 'package:note_sphere_app/widgets/completed_tab.dart';
import 'package:note_sphere_app/widgets/todo_tab.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Todo> allTodos = [];
  late List<Todo> incompletedTodos = [];
  late List<Todo> completedTodos = [];
  TodoService todoService = TodoService();
  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    taskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();
    if (isNewUser) {
      await todoService.createIntialTodos();
    }
    _loadToDos();
  }

  Future<void> _loadToDos() async {
    final List<Todo> loadTodos = await todoService.loadTodos();
    setState(() {
      allTodos = loadTodos;
      //incompleted todos
      incompletedTodos = allTodos.where((todo) => !todo.isDone).toList();
      //completed todos
      completedTodos = allTodos.where((todos) => todos.isDone).toList();
    });
  }

  //method to save task
  void _addTask() async {
    try {
      if (taskController.text.isNotEmpty) {
        final Todo newTodo = Todo(
          title: taskController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );

        await todoService.addTodo(newTodo);
        setState(() {
          allTodos.add(newTodo);
          incompletedTodos.add(newTodo);
        });

        AppHelpers.showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          "Task Added",
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      AppHelpers.showSnackBar(context, "failed to add task");
      print(e);
    }
  }

  void openMessageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "AddTask",
              style: AppTextStyles.appDescriptionStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: taskController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: "Enter Task",
                hintStyle: AppTextStyles.appDescriptionSmallStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask();
              },
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  AppColors.kFabColor,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: const Text(
                "Add Task",
                style: AppTextStyles.appButton,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  AppColors.kCardColor,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: const Text(
                "Cancel",
                style: AppTextStyles.appButton,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "ToDo",
                style: AppTextStyles.appDescriptionStyle,
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appDescriptionStyle,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMessageModel(context);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(
            inCompletedTodos: incompletedTodos,
            completedTodo: completedTodos,
          ),
          CompletedTab(
            completedTodos: completedTodos,
            inCompletedTodos: incompletedTodos,
          ),
        ],
      ),
    );
  }
}
