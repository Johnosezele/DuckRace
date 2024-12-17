import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/navigation_service.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const BurgerMenuContent(),
        );
      },
    );
  }
}

class BurgerMenuContent extends StatelessWidget {
  const BurgerMenuContent({super.key});

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          onTap: onTap,
        ),
        Divider(
          color: AppColors.primary.withOpacity(0.2),
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
            ],
          ),
          _buildMenuItem(
            'REGISTER AS SPONSOR',
            () {
              Navigator.pop(context);
              NavigationService.navigateToRegisterSponsor(context);
            },
          ),
          _buildMenuItem(
            'THE SPONSORS RACE',
            () {
              Navigator.pop(context);
              NavigationService.navigateToSponsors(context);
            },
          ),
          _buildMenuItem(
            'SHOP',
            () {
              Navigator.pop(context);
              // TODO: Implement shop navigation
            },
          ),
          _buildMenuItem(
            'WINNER',
            () {
              Navigator.pop(context);
              NavigationService.navigateToWinners(context);
            },
          ),
          _buildMenuItem(
            'MY DUCK',
            () {
              Navigator.pop(context);
              NavigationService.navigateToMyDucks(context);
            },
          ),
          _buildMenuItem(
            'SPONSORS',
            () {
              Navigator.pop(context);
              NavigationService.navigateToSponsors(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
