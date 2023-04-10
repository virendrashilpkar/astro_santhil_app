import 'package:flutter/material.dart';

class UnderConstructionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/under_construction.png', width: 150),
            SizedBox(height: 20),
            Text(
              'Page Under Construction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We are working hard to bring you the best experience!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
