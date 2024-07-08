import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/guide/guides.dart';
import 'package:project_1_frontend/pages/guide/viewguidesindashboard.dart';
import 'package:project_1_frontend/pages/guide/viewreviews.dart';
// import 'package:project_1_frontend/pages/blog_view_page.dart';
// import 'package:project_1_frontend/pages/blogdetails.dart';
// import 'package:project_1_frontend/pages/bloglocation.dart';
import 'package:project_1_frontend/pages/hotelList.dart';
import 'package:project_1_frontend/pages/hotelbyloc.dart';
import 'package:project_1_frontend/pages/hotels.dart';
// import 'package:project_1_frontend/pages/orderdetails.dart';
import 'package:project_1_frontend/pages/profile.dart';
import 'package:project_1_frontend/registration/AddBusPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/pages/guide/viewreviews.dart';
class guidedashboard extends StatefulWidget {
  const guidedashboard({super.key});
  
  @override
  State<guidedashboard> createState() => _guidedashboardState();
  
}

class _guidedashboardState extends State<guidedashboard>
    with SingleTickerProviderStateMixin {
     
  //late AnimationController _controller;
  

  @override
  void initState() {
    super.initState();
    getguidedetails();
    //_controller = AnimationController(vsync: this);
  }
 String guideid='';
 void getguidedetails()async {
  Map<String, String> allvalues = await storage.readAll();
      String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
       guideid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
       print(guideid);
 }
  @override
  void dispose() {
   // _controller.dispose();
    super.dispose();
  }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// class guidedashboard extends StatelessWidget {
//   const guidedashboard({Key? key});
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
                      text: 'REVIEWS',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => viewreviews(guideId: guideid,),
                        ));
                      },
                      
                      color: Color.fromARGB(255, 238, 156, 150), // Specify color for this container
                    ),
                    buildMenuItem(
                      context: context,
                      icon: Icons.hotel,
                      text: 'VIEW ALL GUIDES',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => viewguides(),
                        ));
                      },
                      color: Color.fromARGB(255, 165, 200, 230), // Specify color for this container
                    ),
                    // buildMenuItem(
                    //   context: context,
                    //   icon: Icons.search,
                    //   text: 'Explore',
                    //   onTap: () {
                    //     // Navigator.of(context).push(MaterialPageRoute(
                    //     //   builder: (context) => HotelbylocPage(),
                    //     // ));
                    //   },
                    //   color: Color.fromARGB(255, 158, 224, 159), // Specify color for this container
                    // ),
                    
                    // buildMenuItem(
                    //   context: context,
                    //   icon: Icons.article,
                    //   text: '\t\t\t\tTravel             \t\t\t\tBlogs',
                    //   onTap: () {
                    //     // Navigator.of(context).push(MaterialPageRoute(
                    //     //   builder: (context) => BlogPage(),
                    //     // ));
                    //   },
                    //   color: Color.fromARGB(255, 143, 134, 54), // Specify color for this container
                    // ),
                    // buildMenuItem(
                    //   context: context,
                    //   icon: Icons.people,
                    //   text: 'My Trips',
                    //   onTap: () {
                    //     // Navigator.of(context).push(MaterialPageRoute(
                    //     //   builder: (context) => BookingDetailsScreen(),
                    //     // ));
                    //   },
                    //   color: Color.fromARGB(255, 175, 114, 185), // Specify color for this container
                    // ),
                    
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
