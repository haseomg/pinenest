import 'package:flutter/material.dart';
import 'estimate_request_delivery_plan.dart';
import 'step_progress_indicator.dart';

class EstimateRequestDayAndQuantity extends StatefulWidget {
  final String length;
  final String width;
  final String height;

  EstimateRequestDayAndQuantity({required this.length, required this.width, required this.height});

  @override
  _EstimateRequestDayAndQuantityState createState() => _EstimateRequestDayAndQuantityState();
}

class _EstimateRequestDayAndQuantityState extends State<EstimateRequestDayAndQuantity> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();

  void _nextStep(BuildContext context) {
    final year = _yearController.text;
    final month = _monthController.text;
    final day = _dayController.text;
    final quantity = _quantityController.text;

    print('📦 Box Size - Length: ${widget.length}, Width: ${widget.width}, Height: ${widget.height}');
    print('📆 Request Date: $year-$month-$day, 🔢 Quantity: $quantity');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EstimateRequestDeliveryPlan(
          length: widget.length,
          width: widget.width,
          height: widget.height,
          year: year,
          month: month,
          day: day,
          quantity: quantity,
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
    currentStep: 2,
    totalSteps: 4,
    ),
    ],
    ),
    SizedBox(height: 20),
    Center(
    child: Text(
    '원하는 날짜와 수량을 입력해 주세요',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
    ),
    ),
    SizedBox(height: 20),
    Row(
    children: [
    Expanded(
    child: TextField(
    controller: _yearController,
    decoration: InputDecoration(
    hintText: '년',
    hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
    ),
    keyboardType: TextInputType.number,
    ),
    ),
    SizedBox(width: 8),
    Expanded(
    child: TextField(
    controller: _monthController,
    decoration: InputDecoration(
    hintText: '월',
    hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
    ),
    keyboardType: TextInputType.number,
    ),
    ),
    SizedBox(width: 8),
    Expanded(
    child: TextField(
    controller: _dayController,
    decoration: InputDecoration(
    hintText: '일',
    hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
    ),
    keyboardType: TextInputType.number,
    ),
    ),
    ],
    ),
    SizedBox(height: 30),
    TextField(
    controller: _quantityController,
    decoration: InputDecoration(
    hintText: '총 수량을 입력해 주세요',
    hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
    ),
    keyboardType: TextInputType.number,
    ),
    SizedBox(height: 10),
    TextField(
    controller: _purposeController,
    decoration: InputDecoration(
    hintText: '* 박스 담을 용도를 적어주세요 (옵션)',
      hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
    ),
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

