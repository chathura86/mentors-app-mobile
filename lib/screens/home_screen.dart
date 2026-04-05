import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_notifier.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();
    final user = auth.user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mediator Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () => auth.logout(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome, ${user.name}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(user.role.name,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
