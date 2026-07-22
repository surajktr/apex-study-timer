import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.95),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            icon: Icons.calendar_today_rounded,
            label: 'Today',
          ),
          _buildNavItem(
            index: 1,
            icon: Icons.bar_chart_rounded,
            label: 'Stats',
          ),

          // Central Floating ADD Button
          GestureDetector(
            onTap: () => onTap(2),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primaryTeal,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryTeal.withOpacity(0.5),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),

          _buildNavItem(
            index: 3,
            icon: Icons.person_outline_rounded,
            label: 'Joined',
          ),
          _buildNavItem(
            index: 4,
            icon: Icons.groups_outlined,
            label: 'Groups',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? AppColors.primaryTeal
                  : AppColors.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? AppColors.primaryTeal
                    : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
