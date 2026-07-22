import 'dart:async';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';

class StudyTimerCard extends StatefulWidget {
  final List<DayProgress> weekDays;

  const StudyTimerCard({
    Key? key,
    required this.weekDays,
  }) : super(key: key);

  @override
  State<StudyTimerCard> createState() => _StudyTimerCardState();
}

class _StudyTimerCardState extends State<StudyTimerCard> {
  late Timer _timer;
  int _secondsElapsed = 2 * 3600 + 41 * 60 + 48; // Default 02:41:48
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDigit(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final hours = _formatDigit(_secondsElapsed ~/ 3600);
    final minutes = _formatDigit((_secondsElapsed % 3600) ~/ 60);
    final seconds = _formatDigit(_secondsElapsed % 60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.surfaceCardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Green glowing vertical pill line
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryTeal.withOpacity(0.6),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOTAL STUDY TIME',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          // Goal: 10h Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: const Text(
                              'Goal: 10h',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // 27% Indicator Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryTeal.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primaryTeal.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Text(
                                  '27%',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryTeal,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.data_usage_rounded,
                                  size: 11,
                                  color: AppColors.primaryTeal,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Glowing Red Stop Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isRunning = !_isRunning;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isRunning
                        ? AppColors.accentRed.withOpacity(0.15)
                        : AppColors.primaryTeal.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isRunning
                          ? AppColors.accentRed.withOpacity(0.5)
                          : AppColors.primaryTeal.withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isRunning
                            ? AppColors.accentRedGlow
                            : AppColors.primaryTealGlow,
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _isRunning
                          ? AppColors.accentRed
                          : AppColors.primaryTeal,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Digital Timer Display
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildDigitGroup(hours),
                  _buildColonSeparator(),
                  _buildDigitGroup(minutes),
                  _buildColonSeparator(),
                  _buildDigitGroup(seconds),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Weekly Liquid Height Fill Level Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.weekDays.map((day) {
              final isToday = day.isSelected;
              return Column(
                children: [
                  // Bar Card
                  Container(
                    width: 40,
                    height: 52,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppColors.primaryTeal.withOpacity(0.15)
                          : Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isToday
                            ? AppColors.primaryTeal
                            : Colors.white.withOpacity(0.08),
                        width: isToday ? 1.5 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Fill Height
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 52 * day.studyProgressRatio,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: isToday
                                    ? [
                                        AppColors.primaryTeal,
                                        AppColors.primaryTealDark,
                                      ]
                                    : [
                                        AppColors.primaryTeal.withOpacity(0.7),
                                        AppColors.primaryTealDark
                                            .withOpacity(0.5),
                                      ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Day Text Label
                  Text(
                    day.dayName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: isToday
                          ? AppColors.primaryTeal
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitGroup(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 54,
        fontWeight: FontWeight.w900,
        fontFamily: 'Courier',
        letterSpacing: -1,
        color: Colors.white,
      ),
    );
  }

  Widget _buildColonSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: AppColors.textMuted,
          ),
          SizedBox(height: 10),
          CircleAvatar(
            radius: 4,
            backgroundColor: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
