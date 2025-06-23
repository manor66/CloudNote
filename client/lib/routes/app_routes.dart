import 'package:client/views/login/login_page.dart' show LoginPage;
import 'package:flutter/material.dart' show Scaffold, Text, Center;
import 'package:go_router/go_router.dart' show GoRouter, GoRoute;

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginPage()),
      // GoRoute(path: '/notes', name: 'notes', builder: (context, state) => const NoteListPage()),
      // GoRoute(path: '/settings', name: 'settings', builder: (context, state) => const SettingsPage()),
    ],
    errorBuilder: (context, state) => const Scaffold(body: Center(child: Text('页面未找到'))),
  );
}
