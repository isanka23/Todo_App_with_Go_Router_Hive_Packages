import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere_app/pages/home_page.dart';

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
    ],
  );
}
