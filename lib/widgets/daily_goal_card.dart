import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DailyGoalCard extends StatelessWidget {
  final String dayName;
  final String dateText;
  final int completedTasks;
  final int totalTasks;
  final int countdownDays;
  final double percentage; // e.g. 0.20 for 20%

  const DailyGoalCard({
    Key? key,
    this.dayName = 'Wednesday',
    this.dateText = 'July 22',
    this.completedTasks = 3,
    this.totalTasks = 15,
    this.countdownDays = 40,
    this.percentage = 0.20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: AppColors.dailyGoalGradient,
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Background scenic elements / moon glow
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryTeal.withOpacity(0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Content padding
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Daily Goal Header + Cloud Badge Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.bolt,
                            color: AppColors.accentGold,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'DAILY GOAL',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTeal.withOpacity(0.85),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryTeal.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.cloud_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Middle Row: Day Name & Date + Circular Progress Arc
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayName,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dateText,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 14),
                            // Done Badge Pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.12),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.emoji_events_outlined,
                                    color: AppColors.accentGold,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$completedTasks / $totalTasks Done',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Circular Arc Progress
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CustomPaint(
                          painter: CircularArcPainter(
                            progress: percentage,
                            accentColor: Colors.white,
                            trackColor: Colors.white.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              '${(percentage * 100).round()}%',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.extrabold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.white.withOpacity(0.08),
                    height: 1,
                  ),
                  const SizedBox(height: 14),

                  // Bottom Row: Countdown Days Left
                  Row(
                    children: [
                      const Text(
                        'COUNTDOWN ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        '$countdownDays ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'days left',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularArcPainter extends CustomPainter {
  final double progress;
  final Color accentColor;
  final Color trackColor;

  CircularArcPainter({
    required this.progress,
    required this.accentColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 12) / 2;
    const strokeWidth = 8.0;

    // Track Paint
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc Paint
    final progressPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircularArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
