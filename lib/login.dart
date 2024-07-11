import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    print('🔵 아이디: $username, 비밀번호: $password');

    final response = await http.post(
      Uri.parse('http://localhost:8095/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // 로그인 성공
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('성공'),
            content: Text('로그인 성공!'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print('🟢 Login successful');
    } else {
      // 로그인 실패
      print('🔴 Login failed');
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('실패'),
            content: Text('로그인 실패'),
            actions: [
              TextButton(
                child: Text('확인'),
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

  Future<void> _register(BuildContext context) async {
    print('🔵 Register button clicked'); // 버튼 클릭 로그
    final username = _usernameController.text;
    final password = _passwordController.text;
    print('🔵 Username: $username, Password: $password'); // 입력된 데이터 로그

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8095/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print('🟢Registration successful');
        // showDialog<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('성공'),
        //       content: Text('회원 가입 성공!'),
        //       actions: [
        //         TextButton(
        //           child: Text('확인'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      } else {
        print('🔴 Registration failed');
        print('🔴 Response status: ${response.statusCode}');
        print('🔴 Response body: ${response.body}');
        // showDialog<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('실패'),
        //       content: Text('회원 가입 실패'),
        //       actions: [
        //         TextButton(
        //           child: Text('확인'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      }
    } catch (e) {
      print('🔴 Exception caught: $e');
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('오류 발생: $e'),
            actions: [
              TextButton(
                child: Text('확인'),
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
      appBar: AppBar(
        title: Text('로그인', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로 가기 버튼 눌렀을 때 동작
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
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호 입력',
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
                child: Text('로그인', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  child: Text('아이디찾기'),
                ),
                Text('   |   '),
                TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 눌렀을 때 동작
                  },
                  child: Text('비밀번호찾기'),
                ),
              ],
            ),
            Spacer(),
            OutlinedButton(
              onPressed: () {
                _register(context); // 회원 가입하기 버튼 눌렀을 때 데이터베이스 연결 상태 확인
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text('회원 가입하기', style: TextStyle(fontWeight: FontWeight.bold)),
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
