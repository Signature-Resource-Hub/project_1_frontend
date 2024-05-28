
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/pages/bookconfirmation.dart';
// import 'package:project_1_frontend/services/bookingservice.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'booking_confirmation_page.dart'; // Import the BookingConfirmationPage

// class ReviewBookingPage extends StatelessWidget {
//   final String busFrom;
//   final String busTo;
//   final String busName;
//   final String startTime;
//   final String endTime;
//   final int selectedSeats;
//   final int totalCost;
//   final String busType;
//   final String busId;
//   final String userId;
//   final Map<String, String>? selectedPickupPoint;
//   final Map<String, String>? selectedDropPoint;
//   final List<Map<String, dynamic>> travelers;

//   ReviewBookingPage({
//     required this.busFrom,
//     required this.busTo,
//     required this.busName,
//     required this.startTime,
//     required this.endTime,
//     required this.selectedSeats,
//     required this.totalCost,
//     required this.busType,
//     required this.selectedPickupPoint,
//     required this.selectedDropPoint,
//     required this.busId,
//     required this.travelers,
//     required this.userId,
//   });

//   final BookingService bookingService = BookingService();
//   final storage=const FlutterSecureStorage();

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Color.fromARGB(255, 62, 238, 241),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailsTile(String label, String value) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: Offset(0, 2), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
//           ),
//           Text(
//             value,
//             style: TextStyle(color: Colors.grey[700], fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeDetailsTile() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: Offset(0, 2), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.access_time, size: 18, color: Colors.black87),
//               SizedBox(width: 8),
//               Text(
//                 'Departure Time:',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
//               ),
//             ],
//           ),
//           Text(
//             '$startTime - $endTime',
//             style: TextStyle(color: Colors.grey[700], fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPickupDropTile() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: Offset(0, 2), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.location_on, size: 24, color: Colors.black87),
//               SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Pickup:',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
//                   ),
//                   Text(
//                     selectedPickupPoint?['name'] ?? 'Not selected',
//                     style: TextStyle(color: Colors.grey[700], fontSize: 16),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(Icons.location_on, size: 24, color: Colors.black87),
//               SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Drop:',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
//                   ),
//                   Text(
//                     selectedDropPoint?['name'] ?? 'Not selected',
//                     style: TextStyle(color: Colors.grey[700], fontSize: 16),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTravelersTile() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: Offset(0, 2), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Traveler Details',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 62, 238, 241)),
//           ),
//           SizedBox(height: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: travelers.map((traveler) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Text(
//                   '${traveler['fullName']} - Age: ${traveler['age']}, Gender: ${traveler['gender']}',
//                   style: TextStyle(color: Colors.grey[700], fontSize: 16),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Review Booking'),
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildSectionTitle('Booking Details'),
//             _buildDetailsTile('From', busFrom),
//             _buildDetailsTile('To', busTo),
//             _buildSectionTitle('Travel Details'),
//             _buildDetailsTile('Travel Name', busName),
//             _buildDetailsTile('Bus Type', busType),
//             _buildTimeDetailsTile(),
//             _buildPickupDropTile(),
//             _buildDetailsTile('Number of Seats', selectedSeats.toString()),
//             _buildDetailsTile('Total Cost', 'Rs. $totalCost'),
//             _buildTravelersTile(),
//             SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: () async {
//                 try {
//                   // Map<String,String> allvalues=await storage.readAll();
//                   //  String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//                   //  print(normalizedSource);
//                   //  String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["_id"];
//                   final Map<String, dynamic> bookingData = {
//                     'busFrom': busFrom,
//                     'busTo': busTo,
//                     'busName': busName,
//                     'startTime': startTime,
//                     'endTime': endTime,
//                     'selectedSeats': selectedSeats,
//                     'totalCost': totalCost,
//                     'busType': busType,
//                     'selectedPickupPoint': selectedPickupPoint,
//                     'selectedDropPoint': selectedDropPoint,
//                     'travelers': travelers,
//                     'userId': '6609ad6e41529c575ef27e1b', // Pass the userId to the bookingData
//                   };

//                   final Map<String, dynamic> responseData = await bookingService.createBooking(bookingData, busId, userId);

//                   final String bookingId = responseData['bookingId'];
//                   final String createdDate = responseData['createdAt'];
//                   final int totalAmount = totalCost; // Assuming totalCost is the total amount

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BookingConfirmationPage(
//                         bookingId: bookingId,
//                         userId: userId,
//                         busId: busId,
//                         createdDate: createdDate,
//                         totalAmount: totalAmount,
//                       ),
//                     ),
//                   );
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Failed to create booking: $e'),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               icon: Icon(Icons.check),
//               label: Text('CONFIRM BOOKING'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.green,
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 textStyle: TextStyle(fontSize: 18),
//               ),
//             ),
//             SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/bookconfirmation.dart';
import 'package:project_1_frontend/services/bookingservice.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'booking_confirmation_page.dart'; // Import the BookingConfirmationPage

class ReviewBookingPage extends StatelessWidget {
  final String busFrom;
  final String busTo;
  final String busName;
  final String startTime;
  final String endTime;
  final int selectedSeats;
  final int totalCost;
  final String busType;
  final String busId;
  final String userId;
  final Map<String, String>? selectedPickupPoint;
  final Map<String, String>? selectedDropPoint;
  final List<Map<String, dynamic>> travelers;

  ReviewBookingPage({
    required this.busFrom,
    required this.busTo,
    required this.busName,
    required this.startTime,
    required this.endTime,
    required this.selectedSeats,
    required this.totalCost,
    required this.busType,
    required this.selectedPickupPoint,
    required this.selectedDropPoint,
    required this.busId,
    required this.travelers,
    required this.userId,
  });

  final BookingService bookingService = BookingService();
  final storage=const FlutterSecureStorage();

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 62, 238, 241),
        ),
      ),
    );
  }

  Widget _buildDetailsTile(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDetailsTile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, size: 18, color: Colors.black87),
              SizedBox(width: 8),
              Text(
                'Departure Time:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          Text(
            '$startTime - $endTime',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildPickupDropTile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, size: 24, color: Colors.black87),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    selectedPickupPoint?['name'] ?? 'Not selected',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 24, color: Colors.black87),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drop:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    selectedDropPoint?['name'] ?? 'Not selected',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTravelersTile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Traveler Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 62, 238, 241)),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: travelers.map((traveler) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '${traveler['fullName']} - Age: ${traveler['age']}, Gender: ${traveler['gender']}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Booking'),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Booking Details'),
            _buildDetailsTile('From', busFrom),
            _buildDetailsTile('To', busTo),
            _buildSectionTitle('Travel Details'),
            _buildDetailsTile('Travel Name', busName),
            _buildDetailsTile('Bus Type', busType),
            _buildTimeDetailsTile(),
            _buildPickupDropTile(),
            _buildDetailsTile('Number of Seats', selectedSeats.toString()),
            _buildDetailsTile('Total Cost', 'Rs. $totalCost'),
            _buildTravelersTile(),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  Map<String,String> allvalues=await storage.readAll();
                   String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
                   print(normalizedSource);
                   String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
                   print(userid);
                  final Map<String, dynamic> bookingData = {
                    'busFrom': busFrom,
                    'busTo': busTo,
                    'busName': busName,
                    'startTime': startTime,
                    'endTime': endTime,
                    'selectedSeats': selectedSeats,
                    'totalCost': totalCost,
                    'busType': busType,
                    'selectedPickupPoint': selectedPickupPoint,
                    'selectedDropPoint': selectedDropPoint,
                    'travelers': travelers,
                    'userId': userid, // Pass the userId to the bookingData
                  };

                  final Map<String, dynamic> responseData = await bookingService.createBooking(bookingData, busId, userId);

                  final String bookingId = responseData['bookingId'];
                  final String createdDate = responseData['createdAt'];
                  final int totalAmount = totalCost; // Assuming totalCost is the total amount

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingConfirmationPage(
                        bookingId: bookingId,
                        userId: userId,
                        busId: busId,
                         busFrom: busFrom, // Pass 'busFrom'
      busTo: busTo, 
                        createdDate: createdDate,
                        totalAmount: totalAmount,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to create booking: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              icon: Icon(Icons.check),
              label: Text('CONFIRM BOOKING'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
