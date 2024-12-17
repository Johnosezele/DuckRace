import 'package:duckrace/features/home/presentation/screens/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/assets_images.dart' as assets;
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../widgets/burger_menu.dart';
import '../../../../core/services/navigation_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _handleNavigation(int index) {
    debugPrint('HomeScreen: Handling navigation for index $index');
    NavigationService.handleBottomNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // App Bar
                      Row(
                        children: [
                          SizedBox(width: 36, height: 36,
                            child: Image.asset(assets.Images.duckLogo)),
                          const SizedBox(width: 8),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Duck',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextSpan(
                                  text: 'Race',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DropDownMenu(),
                                ),
                              );
                            },
                            child: SizedBox(height: 20, width: 20,
                              child: Image.asset(assets.Images.burgerMenu)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 150),
                      Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Buy Ticket Button
                          _ActionButton(
                            height: 117,
                            icon: assets.Images.ticketIcon,
                            label: 'Buy a Ticket',
                            onTap: () => NavigationService.navigateToTicket(context),
                          ),
                          const SizedBox(height: 15),
                          // See Winners Button
                          _ActionButton(
                            height: 117,
                            icon: assets.Images.winnerIcon,
                            label: 'See Winners',
                            onTap: () => NavigationService.navigateToWinners(context),
                          ),
                          const SizedBox(height: 15),
                          // Sponsor Button
                          _ActionButton(
                            height: 64,
                            label: 'Be a Sponsor & Race the Sponsors Race',
                            onTap: () => NavigationService.navigateToRegisterSponsor(context),
                          ),
                          const SizedBox(height: 30),
                          // Learn More Button
                          Container(
                            width: 335,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Learn More',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Image.asset(assets.Images.arrowIcon),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ),
                    
                    ],
                  ),
                ),
              ),
            ),
            BottomNavBar(onIndexChanged: _handleNavigation),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final double height;
  final String? icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.height,
    this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 335,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.buttonBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Image.asset(icon!, width: 50, height: 50),
              const SizedBox(height: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: AppColors.buttonText,
                fontSize: icon != null ? 18 : 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
