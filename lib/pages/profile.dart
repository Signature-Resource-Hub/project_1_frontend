// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import 'package:project_1_frontend/pages/password.dart';
// import 'package:project_1_frontend/pages/updation.dart';
// import 'package:project_1_frontend/services/updateservice.dart';

// class Profile extends StatelessWidget {
//   const Profile({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(

//         title: Center(
//           child: Text(
//             'Edit Profile',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
//           ),
//         ),
//       ),
//       body: ProfileForm(),
//     );
//   }
// }

// class ProfileForm extends StatefulWidget {
//   const ProfileForm({Key? key}) : super(key: key);

//   @override
//   _ProfileFormState createState() => _ProfileFormState();
// }

// class _ProfileFormState extends State<ProfileForm> {
//   Map<String,dynamic>? _userdata;
//   final TextEditingController name = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController phone = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   late String _username = '';
//   late String _phoneNumber = '';
//   late String _email = '';
//   updateservice service=updateservice();

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }


//   void fetchUserData() async {
//     try {
//       final response = await service.getUser("660a4a6000bc8a9dbe32cbf3");
//       if (response.statusCode == 200) {
//         print(response.data);
//         final userData = response.data;
=======
//   final storage=const FlutterSecureStorage();

//   void fetchUserData() async {
//     try {
//       //final response = await service.getUser("660a4a6000bc8a9dbe32cbf3");
//       Map<String,String> allvalues=await storage.readAll();
//       String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       print(normalizedSource);
      
//       String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//       print("user");
//       print(userid);
//       final response = await service.getUser(userid);

//       if (response.statusCode == 200) {
//         print(response.data);
        
//         final userData = response.data;
//         print("userdata");
//         print(userData);


//         setState(() {
//           _username = userData['username'] ?? '';
//           _phoneNumber = userData['phone'].toString() ?? '';
//           _email = userData['email'] ?? '';
//           name.text = _username;
//           email.text = _email;
//           phone.text = _phoneNumber;
//         });
//       } else {
//         throw Exception('Failed to get user details');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
  
//   showError(String content, String title) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(title),
//             content: Text(content),
//             actions: [
//               TextButton(
//                 child: Text("Ok"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }
  
//   submitForm() async{

//     var data=jsonEncode({
//       "_id":"660a4a6000bc8a9dbe32cbf3",
//       "name":name.text,

//     Map<String,String> allvalues=await storage.readAll();
//       String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       print(normalizedSource);
//       String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//     var data=jsonEncode({
//       "_id":userid,
//       "name":name.text,
//       // "email":email.text,
//       // "phone":phone.text,

//     });
//     print(data);
   
//   }
//   submitFormusername() async{

//     var data=jsonEncode({
//       "_id":"660a4a6000bc8a9dbe32cbf3",
//       "username":name.text

//     Map<String,String> allvalues=await storage.readAll();
//       String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       print(normalizedSource);
//       String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//     var data=jsonEncode({
//       //"_id":"660a4a6000bc8a9dbe32cbf3",
//       "_id":userid,
//       "username":name.text
//        //"email":email.text,
//       // "phone":phone.text,

//     });
//     print(data);
//     try {
//       final Response res = await service.editusername(data);
//       print(res.data);
//       showError("Profile completed", "Profile completed Successfully");

//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => CreateProfile(widget.contactNumber),
//       //   ),
//       // );

//     } on DioException catch (e) {
//       print(e);
//       if (e.response?.statusCode == 400) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("User already exists"),
//             duration: Duration(milliseconds: 2000),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Error occurred, please try again"),
//             duration: Duration(milliseconds: 2000),
//           ),
//         );
//       }
//     }
//   }

//   submitFormphn() async{

//     var data=jsonEncode({
//       "id":"660a4a6000bc8a9dbe32cbf3",

//     Map<String,String> allvalues=await storage.readAll();
//       String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       print(normalizedSource);
//       String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//     var data=jsonEncode({
//       "_id":userid,
//       //"id":"660a4a6000bc8a9dbe32cbf3",
//       //"username":name.text
//        //"email":email.text,

//        "phone":phone.text,
//     });
//     print(data);
//     try {
//       final Response res = await service.editphone(data);
//       print(res.data);
//       showError("Profile completed", "Profile completed Successfully");
      
//     } on DioException catch (e) {
//       print(e);
//       if (e.response?.statusCode == 400) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Phone no already exists"),
//             duration: Duration(milliseconds: 2000),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Error occurred, please try again"),
//             duration: Duration(milliseconds: 2000),
//           ),
//         );
//       }
//     }
//   }
  
//   submitFormemail() async{

//     var data=jsonEncode({
//       "id":"660a4a6000bc8a9dbe32cbf3",

//     Map<String,String> allvalues=await storage.readAll();
//       String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       print(normalizedSource);
//       String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

//     var data=jsonEncode({
      
//       //"id":"660a4a6000bc8a9dbe32cbf3",
//       "_id":userid,

//       //"username":name.text
//        "email":email.text,
//        //"phone":phone.text,
//     });
//     print(data);
//     try {
//       final Response res = await service.editemail(data);
//       print(res.data);
//       showError("Profile completed", "Profile completed Successfully");
      
//     } on DioException catch (e) {
//       print(e);
//       if (e.response?.statusCode == 400) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Email already exists"),
//             duration: Duration(milliseconds: 2000),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Error occurred, please try again"),
//             duration: Duration(milliseconds: 2000),
//           ),
//         );
//       }
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 20),
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(
//                     'https://i.pinimg.com/736x/1e/2f/28/1e2f28c0537debcf003afc48375d2775.jpg'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xFFCAF1EC),
//                 ),
//                 child: Text(
//                   '  Dorothy Dix  ',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: name,
//                         decoration: InputDecoration(
//                           labelText: 'Enter Username',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Username is required';
//                           }
//                           if (value.length > 10) {
//                             return 'Username should not exceed 10 characters';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _username = value!;
//                         },
//                       ),
//                     ),
//                     ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     submitFormusername();

//                     _formKey.currentState!.save();                   
//                     print('Username: $_username');

//                     _formKey.currentState!.save();
//                     // Perform your update logic here
//                     print('Username: $_username');
                    
                   

//                     // Navigate to the next page

//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => updatesucc()),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xFFCAF1EC),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Update',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: phone,
//                         decoration: InputDecoration(
//                           labelText: 'Enter Phone No',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Phone number is required';
//                           }
//                           if (value.length != 10) {
//                             return 'Phone number should contain 10 digits';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _phoneNumber = value!;
//                         },
//                       ),
//                     ),
//                     ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     submitFormphn();
//                     _formKey.currentState!.save();

//                     // Perform your update logic here
                    
//                     print('Phone Number: $_phoneNumber');
                    

//                     // Navigate to the next page

//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => updatesucc()),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xFFCAF1EC),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Update',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: email,
//                         decoration: InputDecoration(
//                           labelText: 'Enter Email',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Email is required';
//                           }
//                           if (!value.contains('@') || !value.contains('.')) {
//                             return 'Enter a valid email address';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _email = value!;
//                         },
//                       ),
//                     ),
//                     ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     submitFormemail();
//                     _formKey.currentState!.save();

//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => updatesucc()),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xFFCAF1EC),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Update',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               GestureDetector(
//                       onTap: () {

//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
//                         );
//                       },
//                       child: Text(
//                         'Change Password?',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30,),

              
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/pages/password.dart';
import 'package:project_1_frontend/pages/updation.dart';
import 'package:project_1_frontend/services/updateservice.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromARGB(255, 73, 128, 129).withOpacity(.4),

          backgroundColor: Color.fromARGB(255, 62, 238, 241),

        title: Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 141, 198, 229), // Background color
        child: ProfileForm(),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  Map<String, dynamic>? _userdata;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late String _username = '';
  late String _phoneNumber = '';
  late String _email = '';
  updateservice service = updateservice();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
  final storage=const FlutterSecureStorage();

  final storage = const FlutterSecureStorage();

  void fetchUserData() async {
    try {

      //final response = await service.getUser("660a4a6000bc8a9dbe32cbf3");
      Map<String,String> allvalues=await storage.readAll();
      String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
      print(normalizedSource);
      
      String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
      print("user");
      print(userid);
      final response = await service.getUser(userid);

      if (response.statusCode == 200) {
        print(response.data);
        

      Map<String, String> allvalues = await storage.readAll();
      String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
      String userid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

      final response = await service.getUser(userid);

      if (response.statusCode == 200) {

        final userData = response.data;
        print("userdata");
        print(userData);

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
    Map<String,String> allvalues=await storage.readAll();
      String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
      print(normalizedSource);
      String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
    var data=jsonEncode({
      "_id":userid,
      "name":name.text,
      // "email":email.text,
      // "phone":phone.text,
    });
    print(data);
   
  }
  submitFormusername() async{
    Map<String,String> allvalues=await storage.readAll();
      String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
      print(normalizedSource);
      String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
    var data=jsonEncode({
      //"_id":"660a4a6000bc8a9dbe32cbf3",
      "_id":userid,
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
    Map<String,String> allvalues=await storage.readAll();
      String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
      print(normalizedSource);
      String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
    var data=jsonEncode({
      "_id":userid,
      //"id":"660a4a6000bc8a9dbe32cbf3",
      //"username":name.text
       //"email":email.text,
       "phone":phone.text,
    });
    print(data);
    try {
      final Response res = await service.editphone(data);
      print(res.data);
      showError("Profile completed", "Profile completed Successfully");
      
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

 submitFormphn() async {
  try {
    Map<String, String> allvalues = await storage.readAll();
    String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
    String userid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
    var data = jsonEncode({
      "_id": userid,
      "phone": phone.text,
    });

    final Response res = await service.editphone(data);
    print(res.data);
    showError("Profile completed", "Profile completed Successfully");
    
    // Navigate to the next page after successful update
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => updatesucc()),
    );
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone number already exists"),
          duration: Duration(milliseconds: 2000),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("updated"),
          duration: Duration(milliseconds: 2000),
        ),
      );

    }
  } catch (e) {
    print('Error: $e');
    // Handle any other unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("updated"),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }
}

  

  submitFormemail() async{
    Map<String,String> allvalues=await storage.readAll();
      String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
      print(normalizedSource);
      String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

    var data=jsonEncode({
      
      //"id":"660a4a6000bc8a9dbe32cbf3",
      "_id":userid,
      //"username":name.text
       "email":email.text,
       //"phone":phone.text,
    });
    print(data);
    try {
      final Response res = await service.editemail(data);
      print(res.data);
      showError("Profile completed", "Profile completed Successfully");
      
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

  submitFormemail() async {
  try {
    Map<String, String> allvalues = await storage.readAll();
    String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
    String userid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

    var data = jsonEncode({
      "_id": userid,
      "email": email.text,
    });

    final Response res = await service.editemail(data);
    print(res.data);
    showError("Profile completed", "Profile completed Successfully");
    
    // Navigate to the next page after successful update
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => updatesucc()),
    );
  } on DioError catch (e) {
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
          content: Text("Please try again later"),
          duration: Duration(milliseconds: 2000),
        ),
      );

    }
  } catch (e) {
    print('Error: $e');
    // Handle any other unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Updated"),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }
}


  @override
@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              SizedBox(height: 20),
              // CircleAvatar(
              //   radius: 50,
              //   backgroundImage: NetworkImage(
              //       'https://i.pinimg.com/736x/1e/2f/28/1e2f28c0537debcf003afc48375d2775.jpg'),
              // ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     primary: Color(0xFFCAF1EC),
              //   ),
              //   child: Text(
              //     '  Dorothy Dix  ',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),

              SizedBox(height: 32),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/2/2066.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue, size: 18),
                          onPressed: () {
                            // Add functionality to edit the profile picture
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Center(
                // child: Text(
                //   'Dorothy Dix',
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
              SizedBox(height: 32),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: 'Enter Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.person), // Icon inside text field
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
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                           submitFormusername();
                    _formKey.currentState!.save();
                    // Perform your update logic here
                    print('Username: $_username');

                          
                          // Perform your update logic here
                          // Navigate to the next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => updatesucc()),
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
                        'Update Username',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: phone,
                      decoration: InputDecoration(
                        labelText: 'Enter Phone No',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.phone), // Icon inside text field
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
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                           submitFormphn();
                    _formKey.currentState!.save();
                    // Perform your update logic here
                    
                    print('Phone Number: $_phoneNumber');
                          // Perform your update logic here
                          // Navigate to the next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => updatesucc()),
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
                        'Update Phone Number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.email), // Icon inside text field
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
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                           submitFormemail();
                    _formKey.currentState!.save();
                    // Perform your update logic here
                    
                    print('Email: $_email');
                          // Perform your update logic here
                          // Navigate to the next page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => updatesucc()),
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
                        'Update Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  // Navigate to forgot password screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Change Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.blue, size: 16),
                  ],
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

}
