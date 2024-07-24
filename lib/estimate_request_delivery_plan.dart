import 'package:flutter/material.dart';
import 'estimate_request_final_step.dart';
import 'step_progress_indicator.dart';

class EstimateRequestDeliveryPlan extends StatefulWidget {
  final String length;
  final String width;
  final String height;
  final String year;
  final String month;
  final String day;
  final String quantity;

  EstimateRequestDeliveryPlan({
    required this.length,
    required this.width,
    required this.height,
    required this.year,
    required this.month,
    required this.day,
    required this.quantity,
  });

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

  // 기본값 설정
  final String defaultName = "고객";
  final String defaultLocation = "배송지";
  final String defaultPhone1 = "010";
  final String defaultPhone2 = "1234";
  final String defaultPhone3 = "5678";
  final String defaultPostalCode = "00000";
  final String defaultAddress = "주소를 입력해 주세요";
  final String defaultDetailedAddress = "상세주소를 입력해 주세요";

  String getName() {
    return _nameController.text.isEmpty ? defaultName : _nameController.text;
  }

  String getLocation() {
    return _locationController.text.isEmpty ? defaultLocation : _locationController.text;
  }

  String getPhonePart1() {
    return _phoneController1.text.isEmpty ? defaultPhone1 : _phoneController1.text;
  }

  String getPhonePart2() {
    return _phoneController2.text.isEmpty ? defaultPhone2 : _phoneController2.text;
  }

  String getPhonePart3() {
    return _phoneController3.text.isEmpty ? defaultPhone3 : _phoneController3.text;
  }

  String getPostalCode() {
    return _postalCodeController.text.isEmpty ? defaultPostalCode : _postalCodeController.text;
  }

  String getAddress() {
    return _addressController.text.isEmpty ? defaultAddress : _addressController.text;
  }

  String getDetailedAddress() {
    return _detailedAddressController.text.isEmpty ? defaultDetailedAddress : _detailedAddressController.text;
  }

  void _nextStep(BuildContext context) {
    final name = getName();
    final location = getLocation();
    final phone = '${getPhonePart1()}-${getPhonePart2()}-${getPhonePart3()}';
    final postalCode = getPostalCode();
    final address = getAddress();
    final detailedAddress = getDetailedAddress();

    print('📦 Box Size - Length: ${widget.length}, Width: ${widget.width}, Height: ${widget.height}');
    print('📆 Request Date: ${widget.year}-${widget.month}-${widget.day}, 🔢 Quantity: ${widget.quantity}');
    print('👍🏻 Delivery Info - Name: $name, Location: $location, Phone: $phone, Postal Code: $postalCode, Address: $address, Detailed Address: $detailedAddress');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EstimateRequestFinalStep(
          length: widget.length,
          width: widget.width,
          height: widget.height,
          year: widget.year,
          month: widget.month,
          day: widget.day,
          quantity: widget.quantity,
          name: name,
          location: location,
          phone: phone,
          postalCode: postalCode,
          address: address,
          detailedAddress: detailedAddress,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
