import 'package:flutter/material.dart';

class CompletedHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('완료 내역', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'SCDream')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 1, // 예시로 1개의 완료 내역을 보여줌
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('마법의 현금박스 (160*70*100)', style: TextStyle(fontFamily: 'SCDream')),
                subtitle: Text('총 1,000 매 - 55,000원 · 배송 완료', style: TextStyle(fontFamily: 'SCDream')),
                trailing: Icon(Icons.shopping_cart, color: Colors.black),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
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
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
