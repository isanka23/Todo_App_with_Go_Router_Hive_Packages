import 'package:flutter/material.dart';
import 'package:note_sphere_app/helpers/helpers.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/services/todo_service.dart';
import 'package:note_sphere_app/utils/router.dart';
import 'package:note_sphere_app/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> inCompletedTodos;
  final List<Todo> completedTodo;
  const TodoTab({
    super.key,
    required this.inCompletedTodos,
    required this.completedTodo,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  //mark a todo as done
  void _markTodoAsDone(Todo todo) async {
    try {
      final Todo updatedTodo = Todo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );
      await TodoService().markAsDone(updatedTodo);
      AppHelpers.showSnackBar(
        context,
        "Todo marked as done",
      );
      setState(() {
        widget.inCompletedTodos.remove(todo);
        widget.completedTodo.add(updatedTodo);
      });

      AppRouter.router.go("/todos");
    } catch (error) {
      AppHelpers.showSnackBar(
        context,
        "An error occurred",
      );
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.inCompletedTodos.sort((a, b) => a.time.compareTo(b.time));
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.inCompletedTodos.length,
              itemBuilder: (context, index) {
                final Todo todo = widget.inCompletedTodos[index];
                return Dismissible(
                  key: Key(todo.id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      widget.inCompletedTodos.removeAt(index);
                      TodoService().deleteTodo(todo);
                    });

                    AppHelpers.showSnackBar(
                      context,
                      "Todo deleted",
                    );
                  },
                  child: TodoCard(
                    todo: todo,
                    isComplted: false,
                    onCheckBoxTap: () => _markTodoAsDone(todo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
