import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/sponsor',
      builder: (context, state) => const SponsorScreen(),
      routes: [
        GoRoute(
          path: 'register',
          builder: (context, state) => const RegisterSponsorScreen(),
        ),
        GoRoute(
          path: 'showcase',
          builder: (context, state) => const SponsorShowcaseScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/updates/:category/:type/:id',
      builder: (context, state) {
        final category = state.params['category']!;
        final type = state.params['type']!;
        final id = state.params['id']!;
        
        switch (type) {
          case 'text':
            return EventUpdatesTextView(id: id, category: category);
          case 'image':
            return EventUpdatesImageView(id: id, category: category);
          case 'video':
            return EventUpdatesVideoView(id: id, category: category);
          default:
            return const UpdatesScreen();
        }
      },
    ),
  ],
);
