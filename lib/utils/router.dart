import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere_app/pages/create_note.dart';
import 'package:note_sphere_app/pages/home_page.dart';
import 'package:note_sphere_app/pages/notes_by_category.dart';
import 'package:note_sphere_app/pages/notes_page.dart';
import 'package:note_sphere_app/pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: false,
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: "/",
    routes: [
      // Home Page
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return const HomePage();
        },
      ),
      //notes page
      GoRoute(
        name: "notes",
        path: '/notes',
        builder: (context, state) {
          return const NotesPage();
        },
      ),
      //todos page
      GoRoute(
        name: "todos",
        path: '/todos',
        builder: (context, state) {
          return const TodoPage();
        },
      ),
      //notes by category
      GoRoute(
        name: "category",
        path: "/category",
        builder: (context, state) {
          final String Category = state.extra as String;
          return NotesByCategory(category: Category);
        },
      ),
      //create new note
      GoRoute(
        name: "create new",
        path: "/create-note",
        builder: (context, state) {
          final bool isNewCategoryPage = state.extra as bool;
          return CreateNotePage(isNewCategory: isNewCategoryPage);
        },
      ),
    ],
  );
}
