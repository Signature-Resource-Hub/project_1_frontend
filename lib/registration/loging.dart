import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_1_frontend/pages/dash.dart';
import 'package:project_1_frontend/registration/forgotpass.dart';
import 'package:project_1_frontend/registration/logsuccess.dart';
import 'package:project_1_frontend/registration/registration.dart';
import 'package:project_1_frontend/services/authservice.dart';

class loging extends StatefulWidget {
  const loging({super.key});
  @override
  State<loging> createState() => _logingState();
}

class _logingState extends State<loging> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool _rememberMe = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthService service = AuthService();
  final storage = FlutterSecureStorage();

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
      },
    );
  }

  checkauthentication() async {
    print("in check authentication");
    try {
      Map<String, String> allValues = await storage.readAll();
      if (allValues["token"]!.isEmpty) {
        print("No user login found");
      } else {
        Map<String, String> allValues = await storage.readAll();
        String normalizedSource =
            base64Url.normalize(allValues["token"]!.split(".")[1]);
        String userid =
            json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
        String user_type = json.decode(
            utf8.decode(base64Url.decode(normalizedSource)))["user_type"];
        print(userid);
        print(user_type);
        if (user_type == "user") {
          Navigator.pushNamedAndRemoveUntil(
              context, '/userdashboard', (route) => false);
        } else if (user_type == "guide") {
          Navigator.pushNamedAndRemoveUntil(
              context, '/guidedashboard', (route) => false);
        } else if (user_type == "blogger") {
          Navigator.pushNamedAndRemoveUntil(
              context, '/bloggerdashboard', (route) => false);
        } else {
          showError("You are not able to login here", "Oops");
        }
        // print(userid);
        // await storage.write(key :"userid",value:userid);
        // await storage.write(key :"usertype",value:user_type);
      }
    } catch (e) {
      print("exception in auth");
    }
  }

  Login() async {
    var email = _emailController.text;
    var password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showError("Please enter email and password", "Error");
      return;
    }

    var data = jsonEncode({"email": email, "password": password});
    print(data);

    try {
      final Response response = await service.userlogin(email, password);
      print(response.data);

      Map<String, String> allValues = await storage.readAll();
      String normalizedSource =
          base64Url.normalize(allValues["token"]!.split(".")[1]);
      String userid =
          json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
      String user_type = json
          .decode(utf8.decode(base64Url.decode(normalizedSource)))["user_type"];
      print(userid);
      print(user_type);
      // print(userid);
      await storage.write(key: "userid", value: userid);
      await storage.write(key: "usertype", value: user_type);

      // await storage.write(key :"usertype",value:response.data[]);

      if (user_type == "user") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/userdashboard', (route) => false);
      } else if (user_type == "guide") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/guidedashboard', (route) => false);
      } else if (user_type == "blogger") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/bloggerdashboard', (route) => false);
      } else {
        showError("You are not able to login here", "Oops");
      }

      // if (response.data("token")) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => dash()),
      //   );
      // } else {
      //   showError("You are not able to login here", "Oops");
      // }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        showError(e.response!.data["msg"], "Login Failed");
      } else {
        showError("Error occurred, please try again later", "Oops");
      }
    } catch (e) {
      print(e);
      showError("An error occurred, please try again later", "Oops");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkauthentication();
  }

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
            padding: EdgeInsets.all(38),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/welcome.svg",
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Travel Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Login to your account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontFamily: 'Arial',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
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
                    controller: _passwordController,
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
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to forgot password screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgotpass()),
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Login();
                        _formKey.currentState!.save();
                        // Perform login/authentication logic here
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                          // Navigate to the sign-up screen or perform any other action
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
