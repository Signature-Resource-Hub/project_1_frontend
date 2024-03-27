import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_1_frontend/registration/loging.dart';

class forgotpass extends StatefulWidget {
  const forgotpass({super.key});
  @override
  State<forgotpass> createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: 500,
            height: 700,
            color: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
            padding: EdgeInsets.all(45),
            child: Column(children: [
              SizedBox(height: 5),
              Text(
                "FORGOT PASSWORD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                "assets/forgot.svg",
                height: 200,
                width: 200,
              ),
              SizedBox(height: 10),
              Text(
                "Enter Registered Email Address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 30),
            Form(
              key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add specific email validation here
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                        // Validation passed, proceed with resetting password
                        // Add functionality for resetting password here
                      }
                  
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16, // Font size
                    fontWeight: FontWeight.bold, // Font weight
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            loging()), // Replace RegSuccess with your actual registration success screen
                  ); // Navigate back to the previous screen (login page)
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Text(
                  'GO BACK TO LOGIN',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16, // Font size
                    fontWeight: FontWeight.bold, // Font weight
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
