import 'package:hive/hive.dart';
import 'package:note_sphere_app/models/todo_model.dart';

class TodoService {
  //all todos
  List<Todo> todos = [
    Todo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Go for a walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  // create the database reference for the todos
  final _myBox = Hive.box("todos");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //method to create the intial todos if the box is empty
  Future<void> createIntialTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", todos);
    }
  }

  //method to load the todos
  Future<List<Todo>> loadTodos() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<Todo>().toList();
    }
    return [];
  }

  //marked the todo as done
  Future<void> markAsDone(Todo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element.id == todo.id);
      allTodos[index] = todos;

      await _myBox.put("todos", allTodos);
    } catch (error) {
      print(error.toString());
    }
  }
}
