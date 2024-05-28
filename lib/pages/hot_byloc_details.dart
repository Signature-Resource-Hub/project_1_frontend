
// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/model/postprd.dart';

// class LocationDetails extends StatelessWidget {
//   final List<dynamic> hotelRooms;

//   LocationDetails({required this.hotelRooms});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hotel Details'),
//       ),
//       body: ListView.builder(
//         itemCount: hotelRooms.length,
//         itemBuilder: (context, index) {
//           // Build each list item using the bus data

//           return ListTile(
//             title: Text(hotelRooms[index]["hotelname"]),
//             
//           );
//         },
//       ),
//     );
//   }
// }


//wrking properly
import 'package:flutter/material.dart';
import 'package:project_1_frontend/models/post.dart';
import 'package:project_1_frontend/pages/hot_more_details.dart';


class LocationDetails extends StatelessWidget {
  final List<dynamic> hotelRooms;

  LocationDetails({required this.hotelRooms});

  @override
  Widget build(BuildContext context) {
    // Set to keep track of displayed hotel names
    final Set<String> displayedHotels = {};

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.8), // Adjust opacity for app bar color
        title: Text('Hotel Details'),
      ),
      body: ListView.builder(
        
        padding: EdgeInsets.only(top: 8.0), // Add spacing from app bar to tiles
        itemCount: hotelRooms.length,
        itemBuilder: (context, index) {
          final hotelName = hotelRooms[index]["hotelname"];
          final cost = hotelRooms[index]["cost"];

          // Check if hotel name or cost is null, or if hotel name has been displayed before
          if (hotelName == null || cost == null || displayedHotels.contains(hotelName)) {
            return SizedBox(); // Return empty SizedBox to skip this item
          } else {
            // Add hotel name to displayed set
            displayedHotels.add(hotelName);
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Add spacing between tiles
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                
                BoxShadow(
                
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetailsPage(hotel: hotelRooms[index]),
            ),
          );// Implement onTap action here if needed
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotelName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.blue),
                      ],
                    ),
                    SizedBox(height: 8), // Add spacing between hotel name and cost
                    Row(
                      children: [
                        Icon(Icons.currency_rupee_outlined, color: Colors.blue),
                        SizedBox(width: 4),
                        Text('$cost', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


