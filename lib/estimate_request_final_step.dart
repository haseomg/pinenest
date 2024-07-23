import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'step_progress_indicator.dart';

class EstimateRequestFinalStep extends StatefulWidget {
  final String length;
  final String width;
  final String height;
  final String year;
  final String month;
  final String day;
  final String quantity;
  final String name;
  final String location;
  final String phone;
  final String postalCode;
  final String address;
  final String detailedAddress;

  EstimateRequestFinalStep({
    required this.length,
    required this.width,
    required this.height,
    required this.year,
    required this.month,
    required this.day,
    required this.quantity,
    required this.name,
    required this.location,
    required this.phone,
    required this.postalCode,
    required this.address,
    required this.detailedAddress,
  });

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

  void _logInputs() {
    print('🔵 박스 사이즈');
    print('  - 가로 (장): ${widget.length}');
    print('  - 세로 (폭): ${widget.width}');
    print('  - 높이 (고): ${widget.height}');
    print('🔵 날짜 및 수량');
    print('  - ${widget.year}년 ${widget.month}월 ${widget.day}일');
    // print('  - 월: ${widget.month}');
    // print('  - 일: ${widget.day}');
    print('  - 총 수량: ${widget.quantity}');
    print('🔵 배송 관련 정보');
    print('  - 이름: ${widget.name}');
    print('  - 배송지명: ${widget.location}');
    print('  - 연락받을 번호: ${widget.phone}');
    print('  - 우편번호: ${widget.postalCode}');
    print('  - 주소: ${widget.address}');
    print('  - 상세주소: ${widget.detailedAddress}');
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                _logInputs();
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
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
