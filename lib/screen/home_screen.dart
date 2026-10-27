import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';

class HomeScreen extends StatelessWidget {
  final int number1;
  final int number2;
  final int total;
  final double scale;


  // const 생성자 : 최초 선언 후 변경 불가능한 빌드 타임 함수
  const HomeScreen({
    required this.number1,
    required this.number2,
    required this.total,
    required this.scale,
    
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 주사위 이미지
        // Center(
        //   child: Image.asset('assets/img/$number.png'),
        // ),
        SizedBox(height: 60.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // 주사위 이미지 2개를 가로로 배치
          children: [
            // 애니메이션 위젯
            AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 150),
              child: Image.asset(
                'assets/img/1_$number1.png'
              ),
            ),
            SizedBox(width: 32.0),
            AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 150),
              child: Image.asset(
                'assets/img/2_$number2.png'
              ),
            ),
          ],
        ),
        SizedBox(height: 32.0),
        Text(
          'Lucky Number',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number1.toString(),   // 주사위 값에 해당되는 숫자
              style: TextStyle(
                color: primaryColor,
                fontSize: 60.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(width: 164.0),
            Text(
              number2.toString(),   // 주사위 값에 해당되는 숫자
              style: TextStyle(
                color: primaryColor,
                fontSize: 60.0,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
        SizedBox(height: 60.0),
        Text(
          'Total',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 40.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          total.toString(),   // 주사위 값에 해당되는 숫자
          style: TextStyle(
            color: primaryColor,
            fontSize: 60.0,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}