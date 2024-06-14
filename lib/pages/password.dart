import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_1_frontend/services/updateservice.dart';
import 'package:dio/dio.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _rememberMe = false;
  updateservice service = updateservice();

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter both current and new passwords.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    var data = jsonEncode({

      "_id": "660a4a6000bc8a9dbe32cbf3",
      "password": currentPassword,
      "newPassword": newPassword,
    });

    try {
      final Response res = await service.updatePassword("660a4a6000bc8a9dbe32cbf3", _currentPasswordController.text, _newPasswordController.text);
      print(res.data);
      // Show success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Password successfully updated.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 400) {
        // Show error message that password update failed due to incorrect current password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Incorrect current password"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      } else {
        // Show generic error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error occurred, please try again"),
            duration: Duration(milliseconds: 2000),
          ),
        );
      }
    }
  }

  void _toggleCurrentPasswordVisibility() {
    setState(() {
      _obscureCurrentPassword = !_obscureCurrentPassword;
    });
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30.0),
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(
                labelText: 'Current Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrentPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggleCurrentPasswordVisibility,
                ),
                border: OutlineInputBorder(),
              ),
              obscureText: _obscureCurrentPassword,
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureNewPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggleNewPasswordVisibility,
                ),
                border: OutlineInputBorder(),
              ),
              obscureText: _obscureNewPassword,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) => _toggleRememberMe(),
                ),
                Text('Remember Me'),
              ],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                updatePassword();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/services/updateservice.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class UpdatePasswordPage extends StatefulWidget {
//   const UpdatePasswordPage({Key? key}) : super(key: key);

//   @override
//   _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
// }

// class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
//   late TextEditingController _currentPasswordController;
//   late TextEditingController _newPasswordController;

//   bool _obscureCurrentPassword = true;
//   bool _obscureNewPassword = true;
//   bool _rememberMe = false;
//   updateservice service = updateservice();

//   final storage = const FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();
//     _currentPasswordController = TextEditingController();
//     _newPasswordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> updatePassword() async {
//     final currentPassword = _currentPasswordController.text;
//     final newPassword = _newPasswordController.text;

//     if (currentPassword.isEmpty || newPassword.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Please enter both current and new passwords.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//       return;
//     }

//     Map<String, String> allValues = await storage.readAll();


//   Map<String,String> allvalues=await storage.readAll();

//     String? token = allValues["token"];
//     if (token != null) {
//       String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
//       try {
//         final Response res = await service.updatePassword(userId, currentPassword, newPassword);
//         print(res.data);
//         // Show success message
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Success'),
//             content: Text('Password successfully updated.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       } on DioError catch (e) {
//         print(e);
//         if (e.response?.statusCode == 400) {
//           // Show error message that password update failed due to incorrect current password
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Incorrect current password"),
//               duration: Duration(milliseconds: 2000),
//             ),
//           );
//         } else {
//           // Show generic error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Error occurred, please try again"),
//               duration: Duration(milliseconds: 2000),
//             ),
//           );
//         }
//       }
//     } else {
//       // Handle the case where token is null
//       print("Token is null");
//     }
//   }

//   void _toggleCurrentPasswordVisibility() {
//     setState(() {
//       _obscureCurrentPassword = !_obscureCurrentPassword;
//     });
//   }

//   void _toggleNewPasswordVisibility() {
//     setState(() {
//       _obscureNewPassword = !_obscureNewPassword;
//     });
//   }

//   void _toggleRememberMe() {
//     setState(() {
//       _rememberMe = !_rememberMe;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Password'),
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 30.0),
//             TextField(
//               controller: _currentPasswordController,
//               decoration: InputDecoration(
//                 labelText: 'Current Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(_obscureCurrentPassword ? Icons.visibility : Icons.visibility_off),
//                   onPressed: _toggleCurrentPasswordVisibility,
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//               obscureText: _obscureCurrentPassword,
//             ),
//             SizedBox(height: 30.0),
//             TextField(
//               controller: _newPasswordController,
//               decoration: InputDecoration(
//                 labelText: 'New Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(_obscureNewPassword ? Icons.visibility : Icons.visibility_off),
//                   onPressed: _toggleNewPasswordVisibility,
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//               obscureText: _obscureNewPassword,
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               children: [
//                 Checkbox(
//                   value: _rememberMe,
//                   onChanged: (value) => _toggleRememberMe(),
//                 ),
//                 Text('Remember Me'),
//               ],
//             ),
//             SizedBox(height: 32.0),
//             ElevatedButton(
//               onPressed: () {
//                 updatePassword();
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
