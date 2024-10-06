import 'package:flutter/material.dart';

class CreateNotePage extends StatefulWidget {
  final bool isNewCategory;

  const CreateNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isNewCategory.toString()
        ),
      ),
    );
  }
}
