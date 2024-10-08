import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                "ToDo",
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
        children: const [
          TodoTab(),
          CompletedTab(),
        ],
      ),
    );
  }
}
