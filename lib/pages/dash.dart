
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/blog_view_page.dart';
import 'package:project_1_frontend/pages/blogdetails.dart';
import 'package:project_1_frontend/pages/bloglocation.dart';
import 'package:project_1_frontend/pages/hotelList.dart';
import 'package:project_1_frontend/pages/hotelbyloc.dart';
import 'package:project_1_frontend/pages/hotels.dart';
import 'package:project_1_frontend/pages/orderdetails.dart';
import 'package:project_1_frontend/pages/profile.dart';
import 'package:project_1_frontend/registration/AddBusPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class dash extends StatelessWidget {
  const dash({Key? key});
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
                    'Where do you want to go?',
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/pages/busbylocation.dart';
// import 'package:project_1_frontend/pages/guide/guidelocation.dart';
// import 'package:project_1_frontend/pages/guide/guides.dart';
// import 'package:project_1_frontend/pages/hotelList.dart';
// import 'package:project_1_frontend/pages/hotelbyloc.dart';
// import 'package:project_1_frontend/pages/hotels.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:project_1_frontend/pages/mytrips.dart';
// import 'package:project_1_frontend/pages/profile.dart';
// import 'package:project_1_frontend/registration/AddBusPage.dart';
// class dash extends StatelessWidget {
//   const dash ({Key? key});
// final storage = const FlutterSecureStorage();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(75),
//         child:AppBar(
//   backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
//   title: Row(
//     children: [
//       CircleAvatar(
//         radius: 35,
//         backgroundImage: NetworkImage(
//           'https://th.bing.com/th/id/OIG3.dAzB8Vq2mI2CKdIWPK29?w=270&h=270&c=6&r=0&o=5&pid=ImgGn',
//         ),
//       ),
//       SizedBox(width: 10),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Dorothy Dix',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 18, // Increased font size
//             ),
//           ),
//           Text(
//             'Where do you want to go?',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 14, // Increased font size
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     ],
//   ),
//   actions: [
//     IconButton(
//       icon: Icon(Icons.logout, size: 30),
//       onPressed: () async {
//         await storage.delete(key: 'token');
//         Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//       },
//     ),
//   ],
// ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(50),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 50),
//                   SizedBox(height: 30),
//                 ],
//               ),
//             ),
//             Container(
//               color: Colors.transparent,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(200))),
//                 child: GridView.count(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 40,
//                   mainAxisSpacing: 30,
//                   children: [
//                     buildMenuItem(
//                       context: context,
//                       icon: Icons.directions_bus,
//                       text: 'Bus',
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => AddBusPage(),
//                         ));
//                       },
//                     ),
//                     buildMenuItem(
//                       context: context,
//                       icon: Icons.hotel,
//                       text: 'Hotel',
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => AddHotelPage(),
//                         ));
//                       },
//                     ),
//                     buildMenuItem(
//                       context: context,
//                       icon: Icons.search,
//                       text: 'Explore',
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => BusByLocation(),
//                         ));
//                       },
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Profile()),
//                         );
//                       },
//                       child: Container(  // Settings container
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               offset: Offset(0, 5),
//                               color: Theme.of(context).primaryColor.withOpacity(.2),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center, // Aligns children in the center vertically
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 144, 199, 236), // You can change the color as needed
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(Icons.settings, color: Colors.black),
//                             ),
//                             SizedBox(height: 8),
//                             Text('Settings'.toUpperCase(), style: Theme.of(context).textTheme.headline6), // Text centered under the icon
//                           ],
//                         ),
//                       ),
//                     ),
//                     buildMenuItem(
//                       context: context,
//                       icon: Icons.people,
//                       text: '  Travel\n\t\tPartner',
//                       onTap: () {
//                         // Navigate to Travel Partner page
//                         // Replace TravelPartnerPage() with your desired page
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => GuidePage(),
//                         ));
//                       },
//                     ),
//                     buildMenuItem(
//                       context: context,
//                       icon: Icons.article,
//                       text: ' My Trips',
//                       onTap: () {
//                         // Navigate to Travel Blogs page
//                         // Replace TravelBlogsPage() with your desired page
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => BookingDetailsScreen(),
//                         ));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildMenuItem({required BuildContext context, required IconData icon, required String text, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               offset: Offset(0, 5),
//               color: Theme.of(context).primaryColor.withOpacity(.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center, // Aligns children in the center vertically
//           children: [
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 144, 199, 236), // You can change the color as needed
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, color: Colors.black),
//             ),
//             SizedBox(height: 8),
//             Text(text.toUpperCase(), style: Theme.of(context).textTheme.headline6), // Text centered under the icon
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Center(
//         child: Text('Settings Page'),
//       ),
//     );
//   }
// }

// class TravelPartnerPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Travel Partner'),
//       ),
//       body: Center(
//         child: Text('Travel Partner Page'),
//       ),
//     );
//   }
// }

// class TravelBlogsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Travel Blogs'),
//       ),
//       body: Center(
//         child: Text('Travel Blogs Page'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/pages/busbylocation.dart';
import 'package:project_1_frontend/pages/guide/guidelocation.dart';
import 'package:project_1_frontend/pages/guide/guides.dart';
import 'package:project_1_frontend/pages/hotelList.dart';
import 'package:project_1_frontend/pages/hotelbyloc.dart';
import 'package:project_1_frontend/pages/hotels.dart';
import 'package:project_1_frontend/pages/mytrips.dart';
import 'package:project_1_frontend/pages/profile.dart';
import 'package:project_1_frontend/registration/AddBusPage.dart';

class dash extends StatelessWidget {
  const dash ({Key? key});
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
        title: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://th.bing.com/th/id/OIG3.dAzB8Vq2mI2CKdIWPK29?w=270&h=270&c=6&r=0&o=5&pid=ImgGn',
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
                //     fontSize: 16,
                //   ),
                // ),
                Text(
                  'Where do you want to go?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
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
            icon: Icon(Icons.logout),
            onPressed: () async {
              await storage.delete(key: 'token');
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
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
                      text: 'Bus',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddBusPage(),
                        ));
                      },
                      color: Color.fromARGB(255, 238, 156, 150), // Specify color for this container
                    ),
                    buildMenuItem(
                      context: context,
                      icon: Icons.hotel,
                      text: 'Hotel',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddHotelPage(),
                        ));
                      },
                      color: Color.fromARGB(255, 165, 200, 230), // Specify color for this container
                    ),
                    buildMenuItem(
                      context: context,
                      icon: Icons.search,
                      text: 'Explore',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HotelbylocPage(),
                        ));
                      },
                      color: Color.fromARGB(255, 158, 224, 159), // Specify color for this container
                    ),
                    
                    buildMenuItem(
                      context: context,
                      icon: Icons.article,
                      text: '\t\t\t\tTravel             \t\t\t\tBlogs',
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
                      text: 'My Trips',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookingDetailsScreen(),
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

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // child: Text(
              //   'Explore',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  buildMenuItem(
                    context: context,
                    icon: Icons.directions_bus,
                    text: 'Bus',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddBusPage(),
                      ));
                    },
                  ),
                  buildMenuItem(
                    context: context,
                    icon: Icons.hotel,
                    text: 'Hotel',
                    color: Colors.green,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddHotelPage(),
                      ));
                    },
                  ),
                  buildMenuItem(
                    context: context,
                    icon: Icons.search,
                    text: 'Explore',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BusByLocation(),
                      ));
                    },
                  ),
                  buildMenuItem(
                    context: context,
                    icon: Icons.settings,
                    text: 'Settings',
                    color: Color.fromARGB(255, 226, 121, 242),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Profile(),
                      ));
                    },
                  ),
                  buildMenuItem(
                    context: context,
                    icon: Icons.people,
                    text: 'Travel Partner',
                    color: Colors.red,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GuidePage(),
                      ));
                    },
                  ),
                  buildMenuItem(
                    context: context,
                    icon: Icons.article,
                    text: 'My Trips',
                    color: Colors.teal,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookingDetailsScreen(),
                      ));
                    },
                  ),
                ],

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

      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add custom action here
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget buildMenuItem(
      {required BuildContext context,
      required IconData icon,
      required String text,
      required Color color,
      required VoidCallback onTap}) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(

          color: color, // Use the provided color

          color: color,

          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),

              color: Theme.of(context).primaryColor.withOpacity(.2),

              color: color.withOpacity(.5),

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

                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            SizedBox(height: 8),
            Text(text.toUpperCase(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),

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


class TravelPartnerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Partner'),
      ),
      body: Center(
        child: Text('Travel Partner Page'),
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
