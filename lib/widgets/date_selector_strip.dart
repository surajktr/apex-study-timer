import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';

class DateSelectorStrip extends StatelessWidget {
  final List<DayProgress> days;
  final Function(int index) onDaySelected;

  const DateSelectorStrip({
    Key? key,
    required this.days,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = day.isSelected;

          return GestureDetector(
            onTap: () => onDaySelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 58,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.datePillSelected
                    : AppColors.datePillUnselected,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? Colors.white
                      : AppColors.surfaceCardBorder.withOpacity(0.6),
                  width: isSelected ? 1.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.dayName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: isSelected
                          ? AppColors.background
                          : AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${day.dateNumber}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.background
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
