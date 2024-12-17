import 'package:flutter/material.dart';
import '../../../../core/services/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Wait for 3 seconds before navigating
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      NavigationService.navigateToHome(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/gif/duck.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
