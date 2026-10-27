import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:random_dice/const/colors.dart';
import 'package:random_dice/screen/gyroscope_root_screen.dart';
import 'package:random_dice/screen/shake_root_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();   // 플러터 프레임워크가 앱을 실행할 준비가 될 때까지 대기

  // 화면 세로 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        // Slider 위젯 관련 테마
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor,   // 노브 색상
          activeTrackColor: primaryColor,   // 노브가 이동한 트랙 색상
          inactiveTrackColor: primaryColor.withValues(alpha: 0.3),   // 노브가 아직 이동하지 않은 트랙 색상
        ),
        // BottomNavigationBar 위젯 관련 테마
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,   // 선택 상태 색상
          unselectedItemColor: secondaryColor,   // 비선택 상태 색상
          backgroundColor: backgroundColor,   // 배경색
        ),
      ),
      // home: GyroscopeRootScreen(),   // Gyroscope
      home: ShakeRootScreen(),   // Accelerometer
    ),
  );
}