import 'package:flutter/material.dart';
import 'package:note_sphere_app/helpers/helpers.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/services/todo_service.dart';
import 'package:note_sphere_app/utils/router.dart';
import 'package:note_sphere_app/widgets/todo_card.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;
  final List<Todo> inCompletedTodos;
  const CompletedTab({
    super.key,
    required this.completedTodos,
    required this.inCompletedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  //mark a todo as done
  void _markTodoAsUnDone(Todo todo) async {
    try {
      final Todo updatedTodo = Todo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );
      await TodoService().markAsDone(updatedTodo);
      setState(() {
        widget.completedTodos.remove(todo);
        widget.inCompletedTodos.add(todo);
      });

      AppHelpers.showSnackBar(
        context,
        "Todo marked as undone",
      );

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
      widget.completedTodos.sort((a,b) => a.time.compareTo(b.time));
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
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index) {
                final Todo todo = widget.completedTodos[index];
                return Dismissible(
                  key: Key(todo.id.toString()),
                  onDismissed: (direction){
                    setState(() {
                      widget.completedTodos.removeAt(index);
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
                    onCheckBoxTap: () => _markTodoAsUnDone(todo),
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
