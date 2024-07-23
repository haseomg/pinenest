import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_intro.dart';
import 'dashboard.dart'; // 대시보드 페이지 추가

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    print('🔵 아이디: $username, 비밀번호: $password');

    try {
      final hashedPassword = sha1.convert(utf8.encode(password)).toString();
      print('🔵 비밀번호 SHA1 해시값: $hashedPassword');

      final response = await http.post(
        Uri.parse('http://192.168.0.8:8095/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': username,
          'password': hashedPassword,
        }),
      );

      print('🔵 서버 응답 코드: ${response.statusCode}');
      print('🔵 서버 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print('🔵 서버 응답 메시지: ${responseBody['message']}');
        if (responseBody['message'] == "Login successful") {
          final String userType = responseBody['userType'];
          final String token = responseBody['token'];
          // FIXME - username decoding
          final String username = responseBody['username'];

          // JWT 토큰과 사용자 이름을 로컬 스토리지에 저장
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('userType', userType);
          await prefs.setString('username', username);

          print('🟢 로그인 성공 - 유저 타입: $userType, 토큰: $token, 사용자 이름: $username');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard(userType: userType, username: username)),
          );
        } else {
          print('🔴 로그인 실패');
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('로그인 실패', style: TextStyle(fontFamily: 'SCDream')),
                content: Text('아이디 또는 비밀번호가 일치하지 않습니다.', style: TextStyle(fontFamily: 'SCDream')),
                actions: [
                  TextButton(
                    child: Text('확인', style: TextStyle(fontFamily: 'SCDream')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print('🔴 서버 오류: ${responseBody['message']}');
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('오류', style: TextStyle(fontFamily: 'SCDream')),
              // content: Text('서버 오류가 발생했습니다. 메시지: ${responseBody['message']}', style: TextStyle(fontFamily: 'SCDream')),
              content: Text('아이디와 비밀번호를 확인해 주세요.', style: TextStyle(fontFamily: 'SCDream')),
              actions: [
                TextButton(
                  child: Text('확인', style: TextStyle(fontFamily: 'SCDream')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('🔴 네트워크 오류: $e');
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류', style: TextStyle(fontFamily: 'SCDream')),
            content: Text('네트워크 오류가 발생했습니다. 다시 시도해 주세요.', style: TextStyle(fontFamily: 'SCDream')),
            actions: [
              TextButton(
                child: Text('확인', style: TextStyle(fontFamily: 'SCDream')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('로그인', style: TextStyle(fontFamily: 'SCDream')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '아이디 입력',
                labelStyle: TextStyle(fontFamily: 'SCDream'),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호 입력',
                labelStyle: TextStyle(fontFamily: 'SCDream'),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text('로그인', style: TextStyle(fontFamily: 'SCDream')),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // 아이디 찾기 눌렀을 때 동작
                  },
                  child: Text('아이디찾기', style: TextStyle(fontFamily: 'SCDream')),
                ),
                Text('   |   '),
                TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 눌렀을 때 동작
                  },
                  child: Text('비밀번호찾기', style: TextStyle(fontFamily: 'SCDream')),
                ),
              ],
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {
                // 회원 가입 로직
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupIntro()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text('회원 가입하기', style: TextStyle(fontFamily: 'SCDream')),
              ),
              style: OutlinedButton.styleFrom(
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
