// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart'; // Import Dio package
// import 'package:project_1_frontend/models/blog.dart';
// import 'package:project_1_frontend/pages/blogdetails.dart';

// import 'package:project_1_frontend/services/blogservice.dart';


// class BlogbylocPage extends StatefulWidget {
//   @override
//   _BlogbylocState createState() => _BlogbylocState();
// }

// class _BlogbylocState extends State<BlogbylocPage> {
//   String? _selectedLocation; // From location

//   List<dynamic>_data=[];
//   BlogService service=BlogService();
//   List<String> _locations = [
//     "Ernakulam",  
//     "Chennai",
//     "banglore"
//   ];

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   void _searchBlogs() async {
//     var data = jsonEncode({
//       "location": _selectedLocation,
      
//     });
//     print("Selected Location: $_selectedLocation"); 

//     if (_formKey.currentState!.validate()) {
//       try {
//         final Response res = await service.getblogsByLocation(_selectedLocation!);
//         //print(res.data);
//         print(1);
//         setState(() {
//           _data = res.data;
//           //print(_data);
//         });

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BlogPage(travelblog: _data),
//           ),
//         );
//       } on DioException catch (e) {
//         print(e);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Sorry !! Blogs not found for particular location'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'BLOGS',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4), // Changed app bar color
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(height: 40),
//                 Center(
//                   child: Icon(
//                     Icons.location_on_outlined,
//                     size: 50,
//                     color: Colors.teal, // Changed icon color
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: Text(
//                     'Select Location',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: DropdownButtonFormField<String>(
//                     value: _selectedLocation,
//                     items: [
//                       DropdownMenuItem<String>(
//                         value: null,
//                         child: Text('-- Select --'),
//                       ),
//                       ..._locations.map((String location) {
//                         return DropdownMenuItem<String>(
//                           value: location,
//                           child: Text(location),
//                         );
//                       }),
//                     ],
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedLocation = newValue;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select a location';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 ElevatedButton(
//                   onPressed: _searchBlogs,
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),

//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     elevation: 8, // Added elevation
//                     shadowColor: Colors.blue.withOpacity(0.7), 
//                   ),
//                   child: Text(
//                     'Search Blogs',
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: BlogbylocPage(),
//   ));
// }

