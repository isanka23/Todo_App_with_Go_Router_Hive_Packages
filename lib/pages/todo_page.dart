import 'package:flutter/material.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/services/todo_service.dart';
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
        onPressed: () {},
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
