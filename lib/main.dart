import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_notifier.dart';
import 'auth/auth_service.dart';
import 'router.dart';

void main() {
  runApp(const MediatorApp());
}

class MediatorApp extends StatefulWidget {
  const MediatorApp({super.key});

  @override
  State<MediatorApp> createState() => _MediatorAppState();
}

class _MediatorAppState extends State<MediatorApp> {
  late final AuthNotifier _auth;

  @override
  void initState() {
    super.initState();
    _auth = AuthNotifier(AuthService());
  }

  @override
  void dispose() {
    _auth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _auth,
      child: Builder(
        builder: (context) {
          final router = buildRouter(_auth);
          return MaterialApp.router(
            title: 'Mediator Chat',
            routerConfig: router,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}
