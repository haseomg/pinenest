import 'package:flutter/material.dart';
import 'signup_customer.dart';
import 'signup_vendor.dart';
import 'dashboard.dart'; // Dashboard 페이지 추가

class SignupIntro extends StatefulWidget {
  @override
  _SignupIntroState createState() => _SignupIntroState();
}

class _SignupIntroState extends State<SignupIntro> {
  bool _isHoveringCustomer = false;
  bool _isHoveringVendor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // 배경색 변경
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 투명 배경
        elevation: 0, // 그림자 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Dashboard(userType: 'guest')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 수정
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            Center(
              child: Image.asset('/boxman_logo.png', height: 200),  // 이미지 경로 확인
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 여백 추가
              child: Text(
                '안녕하세요!\n박스 만드는 사람들입니다',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SCDream',
                ),
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 여백 추가
              child: Text(
                'BOXMAN은 다양한 거래처와 협업합니다\n박스를 용도에 맞춰 보다 편리하게 주문하세요',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'SCDream',
                ),
              ),
            ),

            SizedBox(height: 40),
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  _isHoveringCustomer = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _isHoveringCustomer = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(16), // 내부 패딩을 16으로 설정
                width: double.infinity, // 컨테이너가 가로로 충분히 넓게 확장되도록 설정
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _isHoveringCustomer ? Colors.grey[300] : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CustomerSignup()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 여백 추가
                            child: Text(
                              '고객으로 가입 ＞',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'SCDream',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8), // 고객으로 가입 텍스트와 설명 텍스트 사이의 여백

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 여백 추가
                      child: Text(
                        '다양한 박스 업체를 맞춤 제작으로 이용해 보세요.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SCDream',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  _isHoveringVendor = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _isHoveringVendor = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(16), // 내부 패딩을 16으로 설정
                width: double.infinity, // 컨테이너가 가로로 충분히 넓게 확장되도록 설정
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _isHoveringVendor ? Colors.grey[300] : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VendorSignup()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 여백 추가
                            child: Text(
                              '업체로 가입 ＞',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'SCDream',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8),
                    // 업체로 가입 텍스트와 설명 텍스트 사이의 여백
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 여백 추가
                      child: Text(
                        '고객에게 맞춤형 서비스를 제공하고 수익을 창출하세요.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SCDream',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
