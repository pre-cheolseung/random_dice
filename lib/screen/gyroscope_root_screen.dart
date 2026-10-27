import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';

import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeRootScreen extends StatefulWidget {
  const GyroscopeRootScreen({Key? key}) : super(key: key);   // const 생성자 : 최초 선언 후 변경 불가능한 빌드 타임 함수

  @override
  // State<GyroscopeRootScreen> createState() => _GyroscopeRootScreenState();
  State<GyroscopeRootScreen> createState() {
    return _GyroscopeRootScreenState();
  }
}

// TabController 초기화를 위한 vsync 기능을 사용하기 위해 TickerProviderStateMixin 사용
class _GyroscopeRootScreenState extends State<GyroscopeRootScreen> with TickerProviderStateMixin {
  TabController? controller;   // 사용할 TabController 선언
  double threshold = 5.0;   // 민감도 기본값 설정
  int number1 = 1;   // 주사위 숫자
  int number2 = 1;
  int total = 2;   // 주사위 숫자의 합계
  double scale = 1.0;   // 확대 후 다시 원래 크기로 축소되는 애니메이션에 사용될 이미지 크기

  @override
  void initState() {
    super.initState();

    // TabController를 위젯이 생성될 때 단 한 번만 초기화 시키기 위해 initState()에서 초기화
    controller = TabController(
      length: 2,
      vsync: this,
    );
    controller!.addListener(tabListener);   // 컨트롤러 속성이 변경될 때마다 실행할 함수 등록

    // accelerometerEventStream() : X, Y, Z축의 가속도 측정
    // gyroscopeEventStream() : X, Y, Z축의 각속도 측정
    // userAccelerometerEventStream() : X, Y, Z축의 중력이 제거된 가속도 측정
    // magnetometerEventStream() : 주변 자기장 측정 (나침반 등 구현 시 사용)

    // X, Y, Z축의 각속도 측정 이벤트 스트림
    gyroscopeEventStream().listen((event) {
      // 어느 한 축의 각속도가 민감도보다 크면 함수 실행
      if (event.x > threshold || event.y > threshold || event.z > threshold) {
        onPhoneRotation();
      }
    });
  }

  // 리스너로 사용할 함수
  tabListener() {
    // 상태 변경 시 setState() 함수 실행
    // 값 변경 시 build() 함수 재실행ß
    // Clean -> setState() -> Dirty -> build() -> Clean
    setState(() {});
  }

  // 각속도 감지 후 실행할 함수
  void onPhoneRotation() async {
    final random = new Random();

    // HapticFeedback.lightImpact();   // 흔들기 시작할 때 가벼운 진동 효과 (준비 신호)

    // 상태 변경 시 setState() 함수 실행
    // 값 변경 시 build() 함수 재실행ß
    // Clean -> setState() -> Dirty -> build() -> Clean
    setState(() {
      number1 = random.nextInt(5) + 1;
      number2 = random.nextInt(5) + 1;
      total = number1 + number2;

      scale = 1.3;   // 이미지 크기를 1.3배로 확대
    });

    await Future.delayed(const Duration(milliseconds: 150));   // 150밀리초(0.15초) 동안 확대 상태 유지
    
    HapticFeedback.heavyImpact();   // 주사위가 멈췄을 때 묵직한 진동 효과

    setState(() {
      scale = 1.0;   // 이미지를 다시 원래 크기(1.0)로 축소
    });
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);   // 리스너에 등록한 함수 등록 취소

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 탭 화면을 보여줄 위젯
      body: TabBarView(
        controller: controller,   // TabBarView 조작에 반드시 필요한 TabController 등록
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),   // 아래 탭 내비게이션을 구현하는 매개변수
    );
  }

  List<Widget> renderChildren() {
    return [
      // 홈 스크린 탭
      HomeScreen(
        number1: number1,
        number2: number2,
        total: total,
        scale: scale,
      ),
      // 설정 스크린 탭
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      ),
    ];
  }

  // 슬라이더 값 변경 시 실행 함수
  // 슬라이더 위젯의 현재 값이 변경될 때마다 threshold 변수에 값을 저장
  // setState() 함수를 실행해서 build() 함수를 재실행
  void onThresholdChange(double val) {
    // Clean -> setState() -> Dirty -> build() -> Clean
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    // 아래 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 현재 화면에 렌더링 되는 탭의 인덱스
      currentIndex: controller!.index,
      // 탭이 선택될 때마다 실행되는 함수
      onTap: (int index) {
        // 상태 변경 시 setState() 함수 실행
        // 값 변경 시 build() 함수 재실행
        // Clean -> setState() -> Dirty -> build() -> Clean
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        // 하단 탭 바의 각 버튼을 구현
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: 'Dice',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}