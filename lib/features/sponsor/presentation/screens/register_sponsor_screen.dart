import 'package:duckrace/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/services/navigation_service.dart';

class RegisterSponsorScreen extends StatelessWidget {
  const RegisterSponsorScreen({super.key});

  void _handleNavigation(BuildContext context, int index) {
    debugPrint('RegisterSponsorScreen: Handling navigation for index $index');
    NavigationService.handleBottomNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true; 
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true,
        ),
        bottomNavigationBar: BottomNavBar(
          onIndexChanged: (index) => _handleNavigation(context, index),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '    Support for Sponsors',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Become a part of our movement and receive funding to fight extremism.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.push('/sponsor/register-form'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Register Your Organization',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'We support organizations that work tirelessly to promote democracy, tolerance, and inclusivity. By participating in our monthly raffle, your organization could be chosen to receive essential funding.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'How to Apply',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildStep('01', 'Registration', 'Fill out the registration form with your organization\'s details.'),
                _buildStep('02', 'Upload Credentials', 'Upload the necessary documents (e.g., tax exemption certificate).'),
                _buildStep('03', 'Waiting for Approval', 'Once approved by our team, your organization will be listed as \'Interested\' on our platform.'),
                _buildStep('04', 'Beneficiary Benefits', 'If chosen as a beneficiary, your organization will receive funds and be featured as a \'Funded Organization.\''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
