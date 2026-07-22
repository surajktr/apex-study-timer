class TaskItem {
  final String id;
  final String title;
  bool isCompleted;
  final String? durationText;

  TaskItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.durationText,
  });
}

class RoutineGroup {
  final String categoryName;
  final List<TaskItem> tasks;
  bool isExpanded;

  RoutineGroup({
    required this.categoryName,
    required this.tasks,
    this.isExpanded = true,
  });

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  int get totalCount => tasks.length;
  double get progress => totalCount == 0 ? 0.0 : completedCount / totalCount;
}

class DayProgress {
  final String dayName;
  final int dateNumber;
  final bool isSelected;
  final double studyProgressRatio; // 0.0 to 1.0

  DayProgress({
    required this.dayName,
    required this.dateNumber,
    this.isSelected = false,
    this.studyProgressRatio = 0.0,
  });
}
