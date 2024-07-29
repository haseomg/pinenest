import 'package:flutter/material.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('장바구니', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'SCDream')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CartItem(
              title: '마법의 현금박스 (160*70*100)',
              description: '총 1,000 매',
              price: '55,000원',
            ),
            CartItem(
              title: '게임박스 (200*100*100)',
              description: '총 500매',
              price: '25,000원',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // 결제 버튼 클릭 시 동작
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text('결제하기', style: TextStyle(fontFamily: 'SCDream', fontSize: 16)),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: Size(double.infinity, 48),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String title;
  final String description;
  final String price;

  CartItem({
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(fontFamily: 'SCDream', color: Colors.grey),
                ),
              ],
            ),
            Text(
              price,
              style: TextStyle(fontFamily: 'SCDream', fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
