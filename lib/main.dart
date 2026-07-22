import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set System UI Overlay Style for transparent status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const ApexStudyTimerApp());
}

class ApexStudyTimerApp extends StatelessWidget {
  const ApexStudyTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apex Study Timer',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primaryTeal,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryTeal,
          surface: AppColors.surface,
          background: AppColors.background,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
