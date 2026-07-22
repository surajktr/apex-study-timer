import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';

class RoutineTasksCard extends StatefulWidget {
  final RoutineGroup routineGroup;
  final Function(String taskId) onToggleTask;

  const RoutineTasksCard({
    Key? key,
    required this.routineGroup,
    required this.onToggleTask,
  }) : super(key: key);

  @override
  State<RoutineTasksCard> createState() => _RoutineTasksCardState();
}

class _RoutineTasksCardState extends State<RoutineTasksCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.routineGroup.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.routineGroup;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.surfaceCardBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Collapsible Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.format_list_bulleted_rounded,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Title
                  Expanded(
                    child: Text(
                      group.categoryName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Progress Bar Line & Progress Text
                  SizedBox(
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: group.progress,
                        minHeight: 6,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryTeal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Progress Badge Text (e.g. 2/3)
                  Text(
                    '${group.completedCount}/${group.totalCount}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Chevron
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          // Task List (Animated CrossFade or Visibility)
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                children: group.tasks.map((task) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () => widget.onToggleTask(task.id),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Custom Checkbox Button
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: task.isCompleted
                                    ? AppColors.primaryTeal
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: task.isCompleted
                                      ? AppColors.primaryTeal
                                      : AppColors.textMuted,
                                  width: 1.8,
                                ),
                                boxShadow: task.isCompleted
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primaryTeal
                                              .withOpacity(0.4),
                                          blurRadius: 8,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: task.isCompleted
                                  ? const Icon(
                                      Icons.check_rounded,
                                      size: 17,
                                      color: Colors.black,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 14),

                            // Task Title & Duration Badge
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: task.isCompleted
                                          ? AppColors.textSecondary
                                          : Colors.white,
                                      decoration: task.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      decorationColor: AppColors.textMuted,
                                    ),
                                  ),
                                  if (task.durationText != null) ...[
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryTeal
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.access_time_rounded,
                                            size: 11,
                                            color: AppColors.primaryTeal,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            task.durationText!,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryTeal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // More options icon
                            const Icon(
                              Icons.more_vert_rounded,
                              color: AppColors.textMuted,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
