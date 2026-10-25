import 'package:flutter/material.dart';

import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);   // const 생성자 : 최초 선언 후 변경 불가능한 빌드 타임 함수

  @override
  // State<RootScreen> createState() => _RootScreenState();
  State<RootScreen> createState() {
    return _RootScreenState();
  }
}

// TabController 초기화를 위한 vsync 기능을 사용하기 위해 TickerProviderStateMixin 사용
class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;   // 사용할 TabController 선언
  double threshold = 2.7;   // 민감도 기본값 설정

  @override
  void initState() {
    super.initState();

    // TabController를 위젯이 생성될 때 단 한 번만 초기화 시키기 위해 initState()에서 초기화
    controller = TabController(
      length: 2,
      vsync: this,
    );

    controller!.addListener(tabListener);   // 컨트롤러 속성이 변경될 때마다 실행할 함수 등록
  }

  // 리스너로 사용할 함수
  tabListener() {
    // 상태 변경 시 setState() 함수 실행
    // 값 변경 시 build() 함수 재실행ß
    // Clean -> setState() -> Dirty -> build() -> Clean
    setState(() {
      
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
      HomeScreen(number: 1),
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