import 'package:flutter/material.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> isCompletedTodos;
  const TodoTab({
    super.key,
    required this.isCompletedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.isCompletedTodos.length,
              itemBuilder: (context, index) {
                final Todo todo = widget.isCompletedTodos[index];
                return TodoCard(
                  todo: todo,
                  isComplted: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
