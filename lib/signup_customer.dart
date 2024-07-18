import 'package:flutter/material.dart';
import 'login.dart';

class CustomerSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 변경
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 투명 배경
        elevation: 0, // 그림자 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('고객 회원가입', style: TextStyle(color: Colors.black, fontFamily: 'SCDream')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontFamily: 'SCDream'),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '아이디',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontFamily: 'SCDream'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 56, // TextField 높이와 동일하게 설정
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '중복 확인',
                        style: TextStyle(fontFamily: 'SCDream', fontSize: 12, color: Colors.black),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0), // 모서리를 조금 둥글게 설정
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontFamily: 'SCDream'),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontFamily: 'SCDream'),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // 상하 좌우 여백을 16으로 설정
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  '명의 도용 시 계정이 정지되고 재가입이 불가능합니다.',
                  style: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'SCDream'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    '가입',
                    style: TextStyle(fontSize: 18, fontFamily: 'SCDream'),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomerSignup(),
  ));
}
