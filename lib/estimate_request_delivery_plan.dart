import 'package:flutter/material.dart';
import 'estimate_request_final_step.dart';

class EstimateRequestDeliveryPlan extends StatefulWidget {
  @override
  _EstimateRequestDeliveryPlanState createState() => _EstimateRequestDeliveryPlanState();
}

class _EstimateRequestDeliveryPlanState extends State<EstimateRequestDeliveryPlan> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _phoneController2 = TextEditingController();
  final TextEditingController _phoneController3 = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailedAddressController = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StepProgressIndicator(
                  currentStep: 3,
                  totalSteps: 4,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '이름*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: '수령인을 입력해 주세요',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
              ),
            ),
            SizedBox(height: 30),
            Text(
              '배송지명(선택)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: '배송지명을 입력해 주세요',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '연락 받을 번호*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _phoneController1,
                    decoration: InputDecoration(
                      hintText: '000',
                      hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Text('-'),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _phoneController2,
                    decoration: InputDecoration(
                      hintText: '0000',
                      hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Text('-'),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _phoneController3,
                    decoration: InputDecoration(
                      hintText: '0000',
                      hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '주소*',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
            ),
            TextField(
              controller: _postalCodeController,
              decoration: InputDecoration(
                hintText: '우편번호',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
                suffixIcon: TextButton(
                  onPressed: () {
                    // 주소 찾기 기능
                  },
                  child: Text(
                    '주소 찾기',
                    style: TextStyle(fontFamily: 'SCDream', color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: '주소',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _detailedAddressController,
              decoration: InputDecoration(
                hintText: '상세주소',
                hintStyle: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EstimateRequestFinalStep()),
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
                minimumSize: Size(double.infinity, 48), // 수정된 부분
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
