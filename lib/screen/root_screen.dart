import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 탭 화면을 보여줄 위젯
      body: TabBarView(
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),   // 아래 탭 내비게이션을 구현하는 매개변수
    );
  }

  List<Widget> renderChildren() {
    return [];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(items: []);   // 아래 탭 내비게이션을 구현하는 위젯
  }
}