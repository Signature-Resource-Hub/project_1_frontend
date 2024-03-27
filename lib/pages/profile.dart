import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/password.dart';
import 'package:project_1_frontend/pages/updation.dart';
import 'package:project_1_frontend/services/updateservice.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
        title: Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: ProfileForm(),
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  Map<String,dynamic>? _userdata;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late String _username = '';
  late String _phoneNumber = '';
  late String _email = '';
  updateservice service=updateservice();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      final response = await service.getUser("6601a12265a5ae70d4022d2e");
      if (response.statusCode == 200) {
        print(response.data);
        final userData = response.data;

        setState(() {
          _username = userData['username'] ?? '';
          _phoneNumber = userData['phone'].toString() ?? '';
          _email = userData['email'] ?? '';
          name.text = _username;
          email.text = _email;
          phone.text = _phoneNumber;
        });
      } else {
        throw Exception('Failed to get user details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  
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
  
  submitForm() async{
    var data=jsonEncode({
      "_id":"6601a12265a5ae70d4022d2e",
      "name":name.text,
      // "email":email.text,
      // "phone":phone.text,
    });
    print(data);
    // try {
    //   final Response res = await service.editusername(data);
    //   print(res.data);
    //   showError("Profile completed", "Profile completed Successfully");
    //   // Navigator.push(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     builder: (context) => CreateProfile(widget.contactNumber),
    //   //   ),
    //   // );
    // } on DioException catch (e) {
    //   print(e);
    //   if (e.response?.statusCode == 400) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text("User already exists"),
    //         duration: Duration(milliseconds: 2000),
    //       ),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text("Error occurred, please try again"),
    //         duration: Duration(milliseconds: 2000),
    //       ),
    //     );
    //   }
    // }
  }
  submitFormusername() async{
    var data=jsonEncode({
      "_id":"6601a12265a5ae70d4022d2e",
      "username":name.text
       //"email":email.text,
      // "phone":phone.text,
    });
    print(data);
    try {
      final Response res = await service.editusername(data);
      print(res.data);
      showError("Profile completed", "Profile completed Successfully");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CreateProfile(widget.contactNumber),
      //   ),
      // );
    } on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User already exists"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error occurred, please try again"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      }
    }
  }

  submitFormphn() async{
    var data=jsonEncode({
      "id":"6601a12265a5ae70d4022d2e",
      //"username":name.text
       //"email":email.text,
       "phone":phone.text,
    });
    print(data);
    try {
      final Response res = await service.editphone(data);
      print(res.data);
      showError("Profile completed", "Profile completed Successfully");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CreateProfile(widget.contactNumber),
      //   ),
      // );
    } on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Phone no already exists"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error occurred, please try again"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      }
    }
  }
  
  submitFormemail() async{
    var data=jsonEncode({
      "id":"6601a12265a5ae70d4022d2e",
      //"username":name.text
       "email":email.text,
       //"phone":phone.text,
    });
    print(data);
    try {
      final Response res = await service.editemail(data);
      print(res.data);
      showError("Profile completed", "Profile completed Successfully");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CreateProfile(widget.contactNumber),
      //   ),
      // );
    } on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email already exists"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error occurred, please try again"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/1e/2f/28/1e2f28c0537debcf003afc48375d2775.jpg'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCAF1EC),
                ),
                child: Text(
                  '  Dorothy Dix  ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: 'Enter Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          if (value.length > 10) {
                            return 'Username should not exceed 10 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                      ),
                    ),
                    ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitFormusername();
                    _formKey.currentState!.save();
                    // Perform your update logic here
                    print('Username: $_username');
                    
                   

                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => updatesucc()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCAF1EC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: phone,
                        decoration: InputDecoration(
                          labelText: 'Enter Phone No',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (value.length != 10) {
                            return 'Phone number should contain 10 digits';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                      ),
                    ),
                    ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitFormphn();
                    _formKey.currentState!.save();
                    // Perform your update logic here
                    
                    print('Phone Number: $_phoneNumber');
                    

                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => updatesucc()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCAF1EC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Enter Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                    ),
                    ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitFormemail();
                    _formKey.currentState!.save();
                    // Perform your update logic here
                    
                    print('Email: $_email');

                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => updatesucc()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFCAF1EC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                      onTap: () {
                        // Navigate to forgot password screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
                        );
                      },
                      child: Text(
                        'Change Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
              
            ],
          ),
        ),
      ],
    );
  }
} 