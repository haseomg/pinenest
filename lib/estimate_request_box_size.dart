import 'package:flutter/material.dart';
import 'estimate_request_day_and_quantity.dart';
import 'step_progress_indicator.dart';

class EstimateRequestBoxSize extends StatefulWidget {
  @override
  _EstimateRequestBoxSizeState createState() => _EstimateRequestBoxSizeState();
}

class _EstimateRequestBoxSizeState extends State<EstimateRequestBoxSize> {
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  // 기본값 설정
  final String defaultLength = "100"; // 100mm
  final String defaultWidth = "100"; // 100mm
  final String defaultHeight = "55"; // 55mm

  String getLength() {
    return _lengthController.text.isEmpty ? defaultLength : _lengthController.text;
  }

  String getWidth() {
    return _widthController.text.isEmpty ? defaultWidth : _widthController.text;
  }

  String getHeight() {
    return _heightController.text.isEmpty ? defaultHeight : _heightController.text;
  }

  void _nextStep(BuildContext context) {
    final length = getLength();
    final width = getWidth();
    final height = getHeight();

    print('📦 Box Size - Length: $length, Width: $width, Height: $height');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EstimateRequestDayAndQuantity(
          length: length,
          width: width,
          height: height,
        ),
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StepProgressIndicator(
                  currentStep: 1,
                  totalSteps: 4,
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '박스 사이즈를 입력해 주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _lengthController,
              decoration: InputDecoration(
                labelText: '가로 (장)',
                hintText: '100mm 이상',
                suffixText: 'mm',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _widthController,
              decoration: InputDecoration(
                labelText: '세로 (폭)',
                hintText: '100mm 이상',
                suffixText: 'mm',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: '높이 (고)',
                hintText: '55mm 이상',
                suffixText: 'mm',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Spacer(),
            ElevatedButton(
              onPressed: () => _nextStep(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text('다음', style: TextStyle(fontFamily: 'SCDream', fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
