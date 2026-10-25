import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();

    // TabController를 위젯이 생성될 때 단 한 번만 초기화 시키기 위해 initState()에서 초기화
    controller = TabController(
      length: 2,
      vsync: this,
    );
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
      Container(
        child: Center(
          child: Text(
            'Tab 1',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      // 설정 스크린 탭
      Container(
        child: Center(
          child: Text(
            'Tab 2',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    // 아래 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
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