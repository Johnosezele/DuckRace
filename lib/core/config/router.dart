import 'package:duckrace/features/home/presentation/screens/drop_down_menu.dart';
import 'package:duckrace/features/home/presentation/screens/home_screen.dart';
import 'package:duckrace/features/splash/presentation/screens/splash_screen.dart';
import 'package:duckrace/features/sponsor/presentation/screens/register_sponsor_form_screen.dart';
import 'package:duckrace/features/sponsor/presentation/screens/register_sponsor_screen.dart';
import 'package:duckrace/features/sponsor/presentation/screens/sponsor_showcase_screen.dart';
import 'package:duckrace/features/ticket/presentation/screens/ticket_screen.dart';
import 'package:duckrace/features/updates/presentation/screens/update_detail_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/winners/presentation/screens/winners_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/ticket',
      name: 'ticket',
      builder: (context, state) => const TicketScreen(),
    ),
    GoRoute(
      path: '/sponsor/register',
      name: 'registerSponsor',
      builder: (context, state) => const RegisterSponsorScreen(),
    ),
    GoRoute(
      path: '/sponsor/register-form',
      name: 'registerSponsorForm',
      builder: (context, state) => const RegisterSponsorFormScreen(),
    ),
    GoRoute(
      path: '/sponsor/showcase',
      name: 'sponsorShowcase',
      builder: (context, state) => const SponsorShowcaseScreen(),
    ),
    GoRoute(
      path: '/updates/:id',
      name: 'updateDetail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return UpdateDetailScreen(updateId: id);
      },
    ),
    GoRoute(
      path: '/winners',
      name: 'winners',
      builder: (context, state) => const WinnersScreen(),
    ),
  ],
);
