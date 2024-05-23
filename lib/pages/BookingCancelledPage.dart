import 'package:flutter/material.dart';

class BookingCancelledPage extends StatelessWidget {
  final String bookingId;

  const BookingCancelledPage({Key? key, required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Cancelled',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent, // Set app bar color
        elevation: 0, // Remove app bar shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.redAccent, Colors.red],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                size: 100,
                color: Colors.white, // Set icon color
              ),
              SizedBox(height: 20),
              Text(
                'Booking $bookingId has been cancelled.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Set text style
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to previous screen
                },
                child: Text(
                  'Back to My Trips',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Set button text style
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Set button background color
                  onPrimary: Colors.redAccent, // Set button text color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Set button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Set button border radius
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
