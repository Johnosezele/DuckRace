import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/updates/data/models/update_model.dart';

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static void handleDeepLink(String category, String type, String id) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.go('/updates/$category/$type/$id');
    }
  }

  // Sponsor Navigation
  static void navigateToSponsorRegistration(BuildContext context) {
    context.go('/sponsor/register');
  }

  static void navigateToSponsors(BuildContext context) {
    context.go('/sponsor');
  }

  static void navigateToRegisterSponsor(BuildContext context) {
    context.go('/sponsor/register');
  }

  static void navigateToRegisterSponsorForm(BuildContext context, {bool hasAgreedToTerms = false}) {
    context.go('/sponsor/register-form', extra: {'agreedToTerms': hasAgreedToTerms});
  }

  // Bottom Navigation Handler
  static void handleBottomNavigation(BuildContext context, int index) {
    debugPrint('Handling bottom navigation for index: $index');
    switch (index) {
      case 0:
        debugPrint('Navigating to home screen');
        navigateToHome(context);
        break;
      case 1:
        debugPrint('Navigating to ticket screen');
        navigateToTicket(context);
        break;
      case 2:
        debugPrint('Navigating to my ducks screen');
        navigateToMyDucks(context);
        break;
      case 3:
        debugPrint('Navigating to updates screen');
        navigateToUpdates(context, 'all', '', '');
        break;
      case 4:
        debugPrint('Navigating to sponsor registration screen');
        navigateToSponsorRegistration(context);
        break;
      default:
        debugPrint('Unknown navigation index: $index');
    }
  }

  // Main Navigation
  static void navigateToHome(BuildContext context) {
    debugPrint('NavigationService: Navigating to home');
    context.go('/home');
  }

  static void navigateToWinners(BuildContext context) {
    debugPrint('NavigationService: Navigating to winners');
    context.go('/winners');
  }

  static void navigateToTicket(BuildContext context) {
    debugPrint('NavigationService: Navigating to ticket');
    context.go('/ticket');
  }

  static void navigateToMyDucks(BuildContext context) {
    debugPrint('NavigationService: Navigating to my ducks');
    context.go('/my-ducks');
  }

  // Updates Navigation
  static void navigateToUpdates(BuildContext context, String category, String id, String s) {
    debugPrint('NavigationService: Navigating to updates');
    context.go('/updates/$category/$id');
  }

  static void navigateToEventUpdate(BuildContext context, EventUpdate update) {
    debugPrint('NavigationService: Navigating to event update');
    context.go('/updates/${update.category}/${update.type}/${update.id}');
  }

  // Utility Methods
  static void showNoUpdatesMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No Race Yet'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
