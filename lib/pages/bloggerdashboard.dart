// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:project_1_frontend/services/addblog.dart';

// class AddBlogPage extends StatefulWidget {
//   @override
//   _AddBlogPageState createState() => _AddBlogPageState();
// }

// class _AddBlogPageState extends State<AddBlogPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _contentController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final storage = const FlutterSecureStorage();
//   final BlogService blogService = BlogService();

//   Future<void> _addBlog() async {
//     final String content = _contentController.text;
//     final String location = _locationController.text;
//     // final String userId = 'exampleUserId'; // Replace with actual user ID logic
//     Map<String, String> allValues = await storage.readAll();
//     String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
//     String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

//     try {
//       final response = await blogService.addBlog(
//         userid: userId,
//         content: content,
//         location: location,
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Blog added successfully')));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add blog')));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Blog'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _contentController,
//                 decoration: InputDecoration(labelText: 'Content'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter content';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _locationController,
//                 decoration: InputDecoration(labelText: 'Location'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter location';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _addBlog();
//                   }
//                 },
//                 child: Text('Add Blog'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/addblog.dart';
import 'package:project_1_frontend/pages/blog_view_page.dart';
import 'package:project_1_frontend/pages/blogdetails.dart';
import 'package:project_1_frontend/pages/bloglocation.dart';
import 'package:project_1_frontend/pages/blogsbyuserid.dart';
import 'package:project_1_frontend/pages/hotelList.dart';
import 'package:project_1_frontend/pages/hotelbyloc.dart';
import 'package:project_1_frontend/pages/hotels.dart';
import 'package:project_1_frontend/pages/orderdetails.dart';
import 'package:project_1_frontend/pages/profile.dart';
import 'package:project_1_frontend/registration/AddBusPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class bloggerdashboard extends StatelessWidget {
  const bloggerdashboard({Key? key});
  final storage = const FlutterSecureStorage();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.8),
          title: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/OIG2._MhK0bYdlnPfIi9SBEu.?w=270&h=270&c=6&r=0&o=5&pid=ImgGn',
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Dorothy Dix',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 18, // Increased font size
                  //   ),
                  // ),
                  Text(
                    'Lets Explore!!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Increased font size
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, size: 30),
              onPressed: () async {
                await storage.delete(key: 'token');
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                  ),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    buildMenuItem(
                      context: context,
                      icon: Icons.directions_bus,
                      text: 'Add Blogs',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddBlogPage(),
                        ));
                      },
                      color: Color.fromARGB(255, 238, 156, 150), // Specify color for this container
                    ),
                    // buildMenuItem(
                    //   context: context,
                    //   icon: Icons.hotel,
                    //   text: 'Hotel',
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => AddHotelPage(),
                    //     ));
                    //   },
                    //   color: Color.fromARGB(255, 165, 200, 230), // Specify color for this container
                    // ),
                    // buildMenuItem(
                    //   context: context,
                    //   icon: Icons.search,
                    //   text: 'Explore',
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => HotelbylocPage(),
                    //     ));
                    //   },
                    //   color: Color.fromARGB(255, 158, 224, 159), // Specify color for this container
                    // ),
                    
                    buildMenuItem(
                      context: context,
                      icon: Icons.article,
                      text: 'Blogs',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlogPage(),
                        ));
                      },
                      color: Color.fromARGB(255, 143, 134, 54), // Specify color for this container
                    ),
                    buildMenuItem(
                      context: context,
                      icon: Icons.people,
                      text: 'My Blogs',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlogListPage(),
                        ));
                      },
                      color: Color.fromARGB(255, 175, 114, 185), // Specify color for this container
                    ),
                    
                    buildMenuItem(
                      context: context,
                      icon: Icons.settings,
                      text: 'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                      color: Color.fromARGB(255, 235, 192, 129), // Specify color for this container
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Color color, // Add color parameter
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color, // Use the provided color
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 144, 199, 236),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              text.toUpperCase(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

class TravelBlogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Blogs'),
      ),
      body: Center(
        child: Text('Travel Blogs Page'),
      ),
    );
  }
}
