import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';
import '../widgets/date_selector_strip.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/announcement_banner.dart';
import '../widgets/study_timer_card.dart';
import '../widgets/routine_tasks_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/focus_stats_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  bool _isDarkMode = true;

  // Sample Days
  final List<DayProgress> _weekDays = [
    DayProgress(dayName: 'Thu', dateNumber: 16, studyProgressRatio: 0.55),
    DayProgress(dayName: 'Fri', dateNumber: 17, studyProgressRatio: 0.70),
    DayProgress(dayName: 'Sat', dateNumber: 18, studyProgressRatio: 0.10),
    DayProgress(dayName: 'Sun', dateNumber: 19, studyProgressRatio: 0.20),
    DayProgress(dayName: 'Mon', dateNumber: 20, studyProgressRatio: 0.65),
    DayProgress(dayName: 'Tue', dateNumber: 21, studyProgressRatio: 0.80),
    DayProgress(
        dayName: 'Wed',
        dateNumber: 22,
        isSelected: true,
        studyProgressRatio: 0.45),
  ];

  // Sample Routine Group
  late RoutineGroup _morningRoutine;

  @override
  void initState() {
    super.initState();
    _morningRoutine = RoutineGroup(
      categoryName: 'Morning',
      tasks: [
        TaskItem(
          id: '1',
          title: 'Formula Revision',
          isCompleted: false,
        ),
        TaskItem(
          id: '2',
          title: 'Editorial Reading',
          isCompleted: true,
          durationText: '38m 58s',
        ),
        TaskItem(
          id: '3',
          title: 'Calculation',
          isCompleted: true,
          durationText: '25m 15s',
        ),
      ],
    );
  }

  void _onDaySelected(int index) {
    setState(() {
      for (int i = 0; i < _weekDays.length; i++) {
        _weekDays[i] = DayProgress(
          dayName: _weekDays[i].dayName,
          dateNumber: _weekDays[i].dateNumber,
          isSelected: i == index,
          studyProgressRatio: _weekDays[i].studyProgressRatio,
        );
      }
    });
  }

  void _toggleTask(String taskId) {
    setState(() {
      final task = _morningRoutine.tasks.firstWhere((t) => t.id == taskId);
      task.isCompleted = !task.isCompleted;
    });
  }

  void _showAddTaskDialog() {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: AppColors.surfaceCardBorder),
          ),
          title: const Text(
            'Add New Task',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: textController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Task Title (e.g., Mock Test)',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.textMuted)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                if (textController.text.trim().isNotEmpty) {
                  setState(() {
                    _morningRoutine.tasks.add(
                      TaskItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: textController.text.trim(),
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Scrollable Content
            CustomScrollView(
              slivers: [
                // Top Custom Header (Tracker Title + Action Icons)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title: ⚡ Tracker
                        Row(
                          children: const [
                            Icon(
                              Icons.bolt_rounded,
                              color: AppColors.accentGold,
                              size: 28,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Tracker',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // Action Icons: Sun/Moon Theme Toggle + Profile Avatar
                        Row(
                          children: [
                            // Theme Switch Button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isDarkMode = !_isDarkMode;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceCard,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.surfaceCardBorder,
                                  ),
                                ),
                                child: Icon(
                                  _isDarkMode
                                      ? Icons.wb_sunny_outlined
                                      : Icons.nightlight_round,
                                  color: AppColors.accentGold,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Profile Avatar
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryTeal,
                                  width: 2,
                                ),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://i.pravatar.cc/150?img=11',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Horizontal Date Selector Strip
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: DateSelectorStrip(
                      days: _weekDays,
                      onDaySelected: _onDaySelected,
                    ),
                  ),
                ),

                // Content Section
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        // 1. Daily Goal Hero Card
                        DailyGoalCard(
                          completedTasks: _morningRoutine.completedCount,
                          totalTasks: _morningRoutine.totalCount + 12,
                          percentage: 0.20,
                        ),

                        const SizedBox(height: 16),

                        // 2. Focus & Streak Quick Stats
                        const FocusStatsCard(),

                        const SizedBox(height: 16),

                        // 3. Announcement Stream Banner
                        const AnnouncementBanner(),

                        const SizedBox(height: 16),

                        // 4. Total Study Time Timer Card
                        StudyTimerCard(weekDays: _weekDays),

                        const SizedBox(height: 16),

                        // 5. Routine Tasks Card (Morning Routine)
                        RoutineTasksCard(
                          routineGroup: _morningRoutine,
                          onToggleTask: _toggleTask,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Floating Custom Bottom Nav Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomNavBar(
                selectedIndex: _currentNavIndex,
                onTap: (index) {
                  if (index == 2) {
                    _showAddTaskDialog();
                  } else {
                    setState(() {
                      _currentNavIndex = index;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
