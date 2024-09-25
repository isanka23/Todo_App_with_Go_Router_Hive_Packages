import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_sphere_app/models/note_model.dart';
import 'package:note_sphere_app/models/todo_model.dart';
import 'package:note_sphere_app/utils/router.dart';
import 'package:note_sphere_app/utils/theme_data.dart';

void main() async {
  // Initialize the hive package
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  // Open the hive boxes
  await Hive.openBox("notes");
  await Hive.openBox("todos");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NoteSphere",
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
