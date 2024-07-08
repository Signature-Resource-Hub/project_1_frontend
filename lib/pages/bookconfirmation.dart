// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/pages/payment.dart'; // Import PaymentPage

// class BookingConfirmationPage extends StatelessWidget {
//   final String bookingId;
//   final String userId;
//   final String busId;
//   final String createdDate;
//   final int totalAmount;
//  final String busFrom; // Added busFrom field
//   final String busTo;

//   BookingConfirmationPage({
//     required this.bookingId,
//     required this.userId,
//     required this.busId,
//     required this.createdDate,
//     required this.totalAmount, 
//     required this.busFrom,
//     required this.busTo,

//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Booking Confirmation',
//           style: TextStyle(
//             fontFamily: 'Roboto',
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF64B5F6),
//               Color(0xFF42A5F5),
//             ],
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Card(
//               elevation: 6,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Booking ID: $bookingId',
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'User ID: $userId',
//                       style: TextStyle(fontSize: 20, color: Colors.grey[800]),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Bus ID: $busId',
//                       style: TextStyle(fontSize: 20, color: Colors.grey[800]),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'From: $busFrom', // Display from location
//                       style: TextStyle(fontSize: 20, color: Colors.grey[800]),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'To: $busTo', // Display to location
//                       style: TextStyle(fontSize: 20, color: Colors.grey[800]),
//                     ),
                    
//                     SizedBox(height: 10),
//                     Text(
//                       'Booking Date: $createdDate',
//                       style: TextStyle(fontSize: 20, color: Colors.grey[800]),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Total Amount: Rs. $totalAmount',
//                       style: TextStyle(fontSize: 20, color: Colors.grey[800]),
//                     ),
//                     SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => PaymentPage(totalAmount: totalAmount)), // Navigate to PaymentPage
//                             );
//                           },
//                           child: Text('PROCEED | Rs: $totalAmount', style: TextStyle(fontSize: 20)), // Display total amount
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green,
//                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context); // Go back to the previous screen
//                           },
//                           child: Text('Back', style: TextStyle(fontSize: 20)),
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.grey[700],
//                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting
import 'package:project_1_frontend/pages/payment.dart'; // Import PaymentPage

class BookingConfirmationPage extends StatelessWidget {
  final String bookingId;
  final String userId;
  final String busId;
  final String createdDate;
  final int totalAmount;
  final String busFrom; // Added busFrom field
  final String busTo;

  BookingConfirmationPage({
    required this.bookingId,
    required this.userId,
    required this.busId,
    required this.createdDate,
    required this.totalAmount,
    required this.busFrom,
    required this.busTo,
  });

  @override
  Widget build(BuildContext context) {
    // Format createdDate into "dd MMM yyyy" format
    String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.parse(createdDate));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Confirmation',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF64B5F6),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking ID: $bookingId',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'From: $busFrom', // Display from location
                      style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'To: $busTo', // Display to location
                      style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Booking Date: $formattedDate', // Display formatted date
                      style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Amount: Rs. $totalAmount',
                      style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PaymentPage(totalAmount: totalAmount)),
                            );
                          },
                          child: Text('PROCEED | Rs: $totalAmount', style: TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Back', style: TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[700],
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
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
      ),
    );
  }
}
