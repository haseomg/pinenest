import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'completed_history.dart';
import 'estimate_request_box_size.dart';
import 'shopping_cart.dart';

class Dashboard extends StatefulWidget {
  final String userType;
  final String username;

  Dashboard({Key? key, required this.userType, required this.username}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions(BuildContext context) => <Widget>[
    Center(
      child: Text(
        '홈 화면',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
      ),
    ),
    Center(
      child: Text(
        '쪽지함 화면',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'SCDream'),
      ),
    ),
    Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EstimateRequestBoxSize()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Text('견적 신청', style: TextStyle(fontFamily: 'SCDream', fontSize: 14)),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompletedHistory()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Text('완료 내역', style: TextStyle(fontFamily: 'SCDream', fontSize: 14)),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: _logout,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text('로그아웃', style: TextStyle(fontFamily: 'SCDream', fontSize: 14)),
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('📌 Selected index: $_selectedIndex'); // 로그 출력
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userType');
    await prefs.remove('username');
    print('🔵 로그아웃 - 토큰 및 사용자 정보 제거 완료');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavigationItems;

    switch (widget.userType) {
      case 'boxman_user':
        bottomNavigationItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: '쪽지함',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '고객 견적',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이 페이지',
          ),
        ];
        break;
      case 'boxman_company':
        bottomNavigationItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: '쪽지함',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '업체 견적',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이 프로필',
          ),
        ];
        break;
      case 'member':
        bottomNavigationItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: '쪽지함',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '회원 견적',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ];
        break;
      default:
        bottomNavigationItems = const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: '쪽지함',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '견적',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ];
        break;
    }

    // Decode the username properly
    String decodedUsername = utf8.decode(widget.username.runes.toList());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('B O X M A N 📦', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'SCDream')),
        centerTitle: true,
        actions: [
          if (_selectedIndex == 3) // Only show the logout button on '마이 페이지' or '마이 프로필' or '설정'
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logout,
              color: Colors.black,
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedIndex == 3) // Only show welcome message on the rightmost tab
              Text(
                '$decodedUsername님 환영합니다',
                style: TextStyle(fontSize: 23, fontFamily: 'SCDream'),
              ),
            if (_selectedIndex == 3) // Only show the logout button on the rightmost tab
              SizedBox(height: 16.0),
            if (_selectedIndex == 3) // Only show the logout button on the rightmost tab
              _widgetOptions(context).elementAt(_selectedIndex),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: bottomNavigationItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? userType = prefs.getString('userType');
  String? username = prefs.getString('username');

  runApp(MaterialApp(
    home: token == null
        ? Login()
        : Dashboard(userType: userType!, username: username!),
    theme: ThemeData(
      fontFamily: 'SCDream',
    ),
  ));
}
