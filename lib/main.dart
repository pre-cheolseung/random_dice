import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:random_dice/const/colors.dart';
import 'package:random_dice/screen/gyroscope_root_screen.dart';
import 'package:random_dice/screen/shake_root_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();   // 플러터 프레임워크가 앱을 실행할 준비가 될 때까지 대기

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);   // 화면 전체(Edge-to-Edge) 영역까지 앱이 그려지도록 설정
  // 상단 상태바 및 하단 내비게이션바 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,   // 상단 상태바 투명
      // statusBarIconBrightness: Brightness.light,   // 상단 상태바 아이콘 색상 (밝게: light, 어둡게: dark)
      systemNavigationBarColor: Colors.transparent,   // 하단 내비게이션바 투명
      systemNavigationBarDividerColor: Colors.transparent,   // 하단 구분선 제거
      // systemNavigationBarIconBrightness: Brightness.light,   // 하단 내비게이션바 아이콘 색상 (밝게: light, 어둡게: dark)
    ),
  );
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);   // 상단 상태바 및 하단 내비게이션바 숨김

  // 화면 세로 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,   // 우측 상단 DEBUG 빨간색 배너 삭제
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