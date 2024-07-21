import 'package:flutter/material.dart';
import 'estimate_request_day_and_quantity.dart';

class EstimateRequestBoxSize extends StatefulWidget {
  @override
  _EstimateRequestBoxSizeState createState() => _EstimateRequestBoxSizeState();
}

class _EstimateRequestBoxSizeState extends State<EstimateRequestBoxSize> {
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EstimateRequestDayAndQuantity()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text('다음', style: TextStyle(fontFamily: 'SCDream', fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
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
