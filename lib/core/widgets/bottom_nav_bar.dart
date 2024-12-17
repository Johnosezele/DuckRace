import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/colors.dart';
import '../constants/assets_images.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavBar extends ConsumerWidget {
  final void Function(int)? onIndexChanged;

  const BottomNavBar({
    super.key,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            selectedIndex: selectedIndex,
            index: 0,
            filledIcon: Images.homeFilled,
            emptyIcon: Images.homeEmpty,
            label: 'Home',
            onTap: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
              onIndexChanged?.call(index);
            },
          ),
          _NavItem(
            selectedIndex: selectedIndex,
            index: 1,
            filledIcon: Images.ticketFilled,
            emptyIcon: Images.ticketEmpty,
            label: 'Ticket',
            onTap: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
              onIndexChanged?.call(index);
            },
          ),
          _NavItem(
            selectedIndex: selectedIndex,
            index: 2,
            filledIcon: Images.duckFilled,
            emptyIcon: Images.duckEmpty,
            label: 'My Ducks',
            onTap: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
              onIndexChanged?.call(index);
            },
          ),
          _NavItem(
            selectedIndex: selectedIndex,
            index: 3,
            filledIcon: Images.updatesFilled,
            emptyIcon: Images.updatesEmpty,
            label: 'Updates',
            onTap: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
              onIndexChanged?.call(index);
            },
          ),
          _NavItem(
            selectedIndex: selectedIndex,
            index: 4,
            filledIcon: Images.sponsorsFilled,
            emptyIcon: Images.sponsorsEmpty,
            label: 'Sponsor',
            onTap: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
              onIndexChanged?.call(index);
            },
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String filledIcon;
  final String emptyIcon;
  final String label;
  final Function(int) onTap;

  const _NavItem({
    required this.selectedIndex,
    required this.index,
    required this.filledIcon,
    required this.emptyIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isSelected ? filledIcon : emptyIcon, width: 24, height: 24
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.navSelected : AppColors.navUnselected,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
