import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_1_frontend/registration/regsuccess.dart';
import 'package:dio/dio.dart';
import 'package:project_1_frontend/services/authservice.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String getusername="",getemail="",getpassword="",getconfirmpassword="",getphonenumber="";
  TextEditingController username=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController confimpassword=new TextEditingController();
  TextEditingController phone=new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _password = '';
  late String _confirmPassword = '';
  late String _phoneNumber;
  AuthService service=AuthService();
  bool _agreeToTAndC = false;
  showError(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  submitform()async{
     try {
    final Response res = await service.registerUser(username: _username, email: _email, password: _password,confirmPassword: _confirmPassword,phone: _phoneNumber);
    print(res.data);
    Navigator.push(context,MaterialPageRoute(builder: (context) =>registrationsuccess()), 
  );
  } on DioException catch (e) {
    print(e);
    if (e.response?.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User already exists"),
        duration: Duration(milliseconds: 2000),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error occurred, please try again"),
        duration: Duration(milliseconds: 2000),
      ));
    }
  }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          TextFormField(
            controller: username,
            decoration: InputDecoration(
              labelText: "USERNAME",
              hintText: "Enter Username",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            onSaved: (value) {
              _username = value!;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              labelText: "EMAIL ID",
              hintText: "Enter Email Id",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
              labelText: "PASSWORD",
              hintText: "Enter Password",
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.remove_red_eye_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              setState(() {
                _password = value;
              });
              return null;
            },
            onSaved: (value) {
              _password = value!; 
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: confimpassword,
            decoration: InputDecoration(
              labelText: "CONFIRM PASSWORD",
              hintText: "Re-enter Password",
              prefixIcon: Icon(Icons.lock),
              suffixIcon: Icon(Icons.remove_red_eye_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please re-enter your password';
              }
              if (value != _password) {
                return 'Passwords do not match';
              }
              return null;
            },
            onSaved: (value) {
              _confirmPassword = value!;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: phone,
            decoration: InputDecoration(
              labelText: "PHONE NUMBER",
              hintText: "Enter Phone Number",
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
            onSaved: (value) {
              _phoneNumber = value!;
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTAndC,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTAndC = value!;
                      });
                    },
                  ),
                  Text(
                    'I agree to T&C', // Changed label
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                 _formKey.currentState!.save();
                submitform();
               
                print('Username: $_username');
                print('Email: $_email');
                print('Password: $_password');
                print('Confirm Password: $_confirmPassword');
                print('Phone Number: $_phoneNumber');
                Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => registrationsuccess()),
      );
                
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), 
              ),
            ),
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Text(
              "Travel Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.black,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 10),
            SvgPicture.asset(
              "assets/login.svg",
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  RegistrationForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
