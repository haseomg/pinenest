import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'completed_history.dart';
import 'estimate_request_box_size.dart';
import 'shopping_cart.dart';
import 'models/estimate_request_dto.dart';  // 모델 파일 import

class Dashboard extends StatefulWidget {
  final String userType;
  final String username;

  Dashboard({Key? key, required this.userType, required this.username}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  late String decodedUsername;
  late Future<String> _userIdFuture;

  @override
  void initState() {
    super.initState();
    decodedUsername = utf8.decode(widget.username.runes.toList());
    _userIdFuture = _loadUserId();
    print('🟢 void initState - decodedUsername: $decodedUsername');
  }

  Future<String> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    print('🟢 void _loadUserId - Loaded userId: $userId');
    return userId ?? '';
  }

  Future<List<EstimateRequestDTO>> fetchEstimateRequests(String userId) async {
    print('🟢 void fetchEstimateRequests - Fetching for userId: $userId');
    try {
      final response = await http.get(Uri.parse('http://192.168.0.8:8095/api/estimate-requests/user/$userId'));

      print('🟢 fetchEstimateRequests - Response status: ${response.statusCode}');
      print('🟢 fetchEstimateRequests - Response headers: ${response.headers}');
      print('🟢 fetchEstimateRequests - Response body: ${response.body}');


      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        print('🔵 void fetchEstimateRequests - Response body: $body');
        return body.map((dynamic item) => EstimateRequestDTO.fromJson(item)).toList();
      } else {
        print('🔴 fetchEstimateRequests - Failed to load, status code: ${response.statusCode}');
        throw Exception('Failed to load estimate requests');
      }
    } catch (e) {
      print('🔴 fetchEstimateRequests - Error: $e');
      throw Exception('Failed to load estimate requests');
    }
  }

  List<Widget> _widgetOptions(BuildContext context) => <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬을 위해 추가
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '내 견적 신청 모아보기',
            style: TextStyle(fontFamily: 'SCDream', fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: buildMyEstimateList()),
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
      ],
    ),
    Center(
      child: Text(
        '쪽지함 화면',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        '견적 화면\n'
            '- 업체가 고객에게 발송한 견적서 목록 모음',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$decodedUsername님 환영합니다',
          style: TextStyle(fontSize: 23, fontFamily: 'SCDream'),
        ),
        SizedBox(height: 16.0),
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
      print('📌 _onItemTapped - Selected index: $_selectedIndex');
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userType');
    await prefs.remove('username');
    await prefs.remove('userId');
    print('🔵 _logout - 토큰 및 사용자 정보 제거 완료');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Widget buildMyEstimateList() {
    return FutureBuilder<String>(
      future: _userIdFuture,
      builder: (context, snapshot) {
        print('🟢 buildMyEstimateList - snapshot.connectionState:  ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          String userId = snapshot.data ?? '';
          print('🟢 void buildMyEstimateList - Loaded userId: $userId');
          return FutureBuilder<List<EstimateRequestDTO>>(
            future: fetchEstimateRequests(userId),
            builder: (context, snapshot) {

              print('🟢 fetchEstimateRequests - snapshot.connectionState: ${snapshot.connectionState}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('🔴 (else if) buildMyEstimateList - Error: ${snapshot.error}');
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                print('🔵 (else if) buildMyEstimateList - No estimate requests found');
                return Center(child: Text('견적 요청이 없습니다.'));
              } else {
                print('🔵 (else) buildMyEstimateList - Fetched estimate requests: ${snapshot.data}');
                return ListView(
                  children: snapshot.data!.map((request) => buildMyEstimateListItem(
                      '${request.boxLength}*${request.boxWidth}*${request.boxHeight}',
                      '${request.quantity}매',
                      '${request.quoteReceived}개',
                      calculateTimeAgo(request.requestedDate)
                  )).toList(),
                );
              }
            },
          );
        }
      },
    );
  }

  String calculateTimeAgo(DateTime requestedDate) {
    final duration = DateTime.now().difference(requestedDate);
    if (duration.inMinutes < 1) {
      return '방금';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}분 전';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}시간 전';
    } else {
      return '${duration.inDays}일 전';
    }
  }

  Widget buildMyEstimateListItem(String title, String quantity, String receivedQuotes, String timeAgo) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title $quantity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 4),
            Text('받은 견적 $receivedQuotes • $timeAgo'),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('삭제', style: TextStyle(color: Colors.black)),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('자세히 보기', style: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavigationItems;

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
        label: '완료 내역',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: '마이 페이지',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, color: Colors.blueAccent), // 쇼핑 카트 아이콘 추가
            SizedBox(width: 5),
            Text('B O X M A N', style: TextStyle(color: Colors.blueAccent, fontSize: 23, fontWeight: FontWeight.bold)), // 파란색 텍스트
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions(context).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: bottomNavigationItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
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
  String? userId = prefs.getString('userId');

  print('🔵 main - token: $token, userType: $userType, username: $username, userId: $userId');

  runApp(MaterialApp(
    home: token == null
        ? Login()
        : Dashboard(userType: userType!, username: username!),
    theme: ThemeData(
      fontFamily: 'SCDream',
    ),
  ));
}
