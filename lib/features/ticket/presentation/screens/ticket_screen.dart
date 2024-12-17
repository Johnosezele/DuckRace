import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/services/navigation_service.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  void _handleNavigation(BuildContext context, int index) {
    debugPrint('TicketScreen: Handling navigation for index $index');
    NavigationService.handleBottomNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true; 
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buy Tickets'),
        ),
        bottomNavigationBar: BottomNavBar(
          onIndexChanged: (index) => _handleNavigation(context, index),
        ),
        body: const Center(
          child: Text('Ticket purchasing coming soon!'),
        ),
      ),
    );
  }
}
