import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere_app/pages/home_page.dart';
import 'package:note_sphere_app/pages/notes_page.dart';
import 'package:note_sphere_app/pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
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
      )
    ],
  );
}
