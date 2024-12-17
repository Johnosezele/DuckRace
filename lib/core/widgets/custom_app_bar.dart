import 'package:duckrace/core/widgets/bottom_nav_bar.dart';
import 'package:duckrace/features/home/presentation/screens/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/colors.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.onBackPressed,
    this.showBackButton = true,
  });

  final VoidCallback? onBackPressed;
  final bool showBackButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.primary,
              onPressed: onBackPressed ?? () {
                ref.read(bottomNavIndexProvider.notifier).state = 0;  // Set home tab index
                context.goNamed('home');
              },
            )
          : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          color: AppColors.primary,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DropDownMenu(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
