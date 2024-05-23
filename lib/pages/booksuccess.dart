import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Success'),
        backgroundColor: Colors.green, // Set app bar color to green
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline, // Display check mark icon
              color: Colors.green, // Set icon color to green
              size: 100, // Set icon size
            ),
            SizedBox(height: 20),
            Text(
              'Booking Successful', // Display success message
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
              child: Text('Back to Home'), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
