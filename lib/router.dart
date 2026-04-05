import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth/auth_notifier.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

GoRouter buildRouter(AuthNotifier auth) => GoRouter(
      initialLocation: '/',
      refreshListenable: auth,
      redirect: (context, state) {
        // Splash handles its own redirect — let it through unconditionally.
        if (state.matchedLocation == '/') return null;

        // Session not yet checked — send back to splash.
        if (!auth.initialised) return '/';

        final isLogin = state.matchedLocation == '/login';

        if (!auth.isLoggedIn && !isLogin) return '/login';
        if (auth.isLoggedIn && isLogin) return '/home';
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (_, __) => const HomeScreen(),
        ),
      ],
    );
