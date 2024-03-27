import 'package:flutter/material.dart';
import 'package:project_1_frontend/registration/loging.dart';

class registrationsuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: 700,
          color: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50, // Adjust the size of the avatar as needed
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage(
                    'https://static.vecteezy.com/system/resources/thumbnails/015/130/843/small/check-mark-icon-free-png.png'), // Replace with your image URL
              ),
              SizedBox(height: 30),
              Text(
                "You Are Successfully Registered",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Email verification link sent to the registered email address.",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loging()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16, // Font size
                    fontWeight: FontWeight.bold, // Font weight
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
