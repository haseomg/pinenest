import 'package:flutter/material.dart';
import 'dart:math' as math;

class EstimateRequestFinalStep extends StatefulWidget {
  @override
  _EstimateRequestFinalStepState createState() => _EstimateRequestFinalStepState();
}

class _EstimateRequestFinalStepState extends State<EstimateRequestFinalStep> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('견적 등록', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'SCDream')),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StepProgressIndicator(
                  currentStep: 4,
                  totalSteps: 4,
                ),
              ],
            ),
            SizedBox(height: 40),
            AnimatedBuilder(
              animation: _controller,
              child: Icon(Icons.autorenew, size: 100, color: Colors.grey),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              '견적 등록이 완료되었습니다!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '작성하신 요청에 맞는 업체를 찾고 있습니다.',
              style: TextStyle(fontSize: 16, fontFamily: 'SCDream'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '48시간 내에 업체에서 견적을 보내드립니다.\n견적이 도착하면 알림을 통해 알려드립니다.',
                style: TextStyle(fontSize: 14, fontFamily: 'SCDream', color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // 텍스트 길이에 맞춰 가로 크기 조정
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                  SizedBox(width: 8), // 텍스트와 체크박스 사이의 간격 조정
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0), // 텍스트 위아래 패딩 추가
                      child: Text(
                        '업체와 전화수신 동의\n빠른 상담을 위해 업체에서 전화를 걸 수 있습니다.',
                        style: TextStyle(fontSize: 14, fontFamily: 'SCDream', color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/dashboard'); // 대시보드로 이동
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text('견적서 등록 완료', style: TextStyle(fontFamily: 'SCDream', fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                minimumSize: Size(double.infinity, 48), // 버튼 크기 수정
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  StepProgressIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            index < currentStep ? Icons.circle : Icons.circle_outlined,
            color: index < currentStep ? Colors.black : Colors.grey,
            size: 12.0,
          ),
        );
      }),
    );
  }
}
