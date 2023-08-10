import 'package:calculator/calculatorScreen.dart';
import 'package:flutter/material.dart';

import 'lightThemeCalculator.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Theme'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calculator()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red, // Set the background color for the button
              ),
              child: const Text(
                "Dark Theme",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16), // Adding some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LightCalculator()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue, // Set the background color for the button
              ),
              child: const Text(
                "Light Theme",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
