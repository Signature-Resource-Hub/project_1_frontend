// import 'package:flutter/material.dart';

// class HotelDetailsPage extends StatelessWidget {
//   final dynamic hotel;

//   HotelDetailsPage({required this.hotel});

//   // Define a map that maps field names to custom titles
//   final Map<String, String> fieldTitles = {
//     "_id":"Hotel Id",
//     "hotelname": "Hotel Name",
//     "location":"Location",
//     "cost": "Cost",
//     "numberOfPersons": "Number of Persons",
//     "acNonAc": "AC/Non-AC",
//     "availability":"Availability"
//     // Add more mappings for other fields if needed
//   };

//   // Define a map that maps field names to corresponding icons
//   final Map<String, IconData> fieldIcons = {
//     "hotelname": Icons.hotel_sharp,
//     "location": Icons.location_on,
//     "cost": Icons.currency_rupee_outlined,
//     "numberOfPersons": Icons.person_2,
//     "acNonAc": Icons.ac_unit,
//     "availability": Icons.check_circle
//     // Add more mappings for other fields if needed
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(hotel["hotelname"]),
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4), // Display the busName as the title
//       ),
//       body: Card(
//         margin: EdgeInsets.all(16),
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               for (String fieldName in hotel.keys)
//                 Container(
//                   padding: EdgeInsets.only(bottom: 8), // Add space between each printed list item
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (fieldIcons.containsKey(fieldName))
//                         Icon(
//                           fieldIcons[fieldName],
//                           size: 24,
//                           color: Colors.blue,
//                         ),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           '${fieldTitles[fieldName]}: ${hotel[fieldName]}',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class HotelDetailsPage extends StatelessWidget {
//   final dynamic hotel;

//   HotelDetailsPage({required this.hotel});

//   // Define a map that maps field names to custom titles
//   final Map<String, String> fieldTitles = {
//     "hotelname": "Hotel Name",
//     "location": "Location",
//     "cost": "Cost",
//     "numberOfPersons": "Number of Persons",
//     "acNonAc": "AC/Non-AC",
//     "availability": "Availability",
//     "checkInTime" : "Check In Time",
//     "checkOutTime" : "Check out Time"
//     // Add more mappings for other fields if needed
//   };

//   // Define a map that maps field names to corresponding icons
//   final Map<String, IconData> fieldIcons = {
//     "hotelname": Icons.hotel_sharp,
//     "location": Icons.location_on,
//     "cost": Icons.currency_rupee_outlined,
//     "numberOfPersons": Icons.person_2,
//     "acNonAc": Icons.ac_unit,
//     "availability": Icons.check_circle,
//     "checkInTime" : Icons.login,
//     "checkOutTime" : Icons.logout
//     // Add more mappings for other fields if needed
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(hotel["hotelname"]),
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4), // Display the busName as the title
//       ),
//       body: Card(
//         margin: EdgeInsets.all(16),
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               for (String fieldName in hotel.keys)
//                 if (fieldName != "_id") // Exclude "hotelid" from being displayed
//                   Container(
//                     padding: EdgeInsets.only(bottom: 8), // Add space between each printed list item
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (fieldIcons.containsKey(fieldName))
//                           Icon(
//                             fieldIcons[fieldName],
//                             size: 24,
//                             color: Colors.blue,
//                           ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             '${fieldTitles[fieldName]}: ${hotel[fieldName]}',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/hotbook.dart';

class HotelDetailsPage extends StatelessWidget {
  final dynamic hotel;

  HotelDetailsPage({required this.hotel});

  final Map<String, String> fieldTitles = {
    "hotelname": "Hotel Name",
    "location": "Location",
    "cost": "Cost",
    "numberOfPersons": "Number of Persons",
    "acNonAc": "AC/Non-AC",
    "availability": "Availability",
    "checkInTime": "Check In Time",
    "checkOutTime": "Check out Time",
    "rating":"Rating"
  };

  final Map<String, IconData> fieldIcons = {
    "hotelname": Icons.hotel_sharp,
    "location": Icons.location_on,
    "cost": Icons.currency_rupee_outlined,
    "numberOfPersons": Icons.person,
    "acNonAc": Icons.ac_unit,
    "availability": Icons.check_circle,
    "checkInTime": Icons.login,
    "checkOutTime": Icons.logout,
    "rating":Icons.star
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.containsKey("hotelname") ? hotel["hotelname"] : "Hotel Details"),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.9),
      ),
      body: GestureDetector(
        onTap: () {
          // Navigate to another page when the tile is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelBookingPage(hotelid:hotel["_id"],hotelName: hotel["hotelname"], costPerNight: hotel["cost"],checkInTime: hotel["checkInTime"],
                  checkOutTime: hotel["checkOutTime"],rating: hotel["rating"],location: hotel["location"],),
            ),
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white, // Set card background color to white
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Hotel Details",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    for (String fieldName in hotel.keys)
                      if (fieldName != "_id" && fieldName != "checkInTime" && fieldName != "checkOutTime" && fieldName != "rating") // Exclude check-in and check-out time
                        ListTile(
                          title: Text(
                            fieldTitles[fieldName]!,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            hotel[fieldName].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




