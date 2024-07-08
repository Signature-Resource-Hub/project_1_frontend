
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/model/busbook.dart';
// import 'package:project_1_frontend/pages/BookingCancelledPage.dart';
// import 'package:project_1_frontend/pages/busreview.dart';
// import 'package:project_1_frontend/services/bookingservice.dart';
// import 'package:project_1_frontend/services/cancelbookservice.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';


// class BookingDetailsScreen extends StatefulWidget {
//   @override
//   _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
// }

// class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
// //  final BookingService _bookingService = BookingService();
//   final ViewService _viewService = ViewService();

// List<Map<String, dynamic>> _bookings = [];
// List<Map<String, dynamic>> _cancelledBookings = [];
// final storage=const FlutterSecureStorage();

// @override
// void initState() {
//   super.initState();
//   fetchBookings();
//   fetchCancelledBookings();
// }

// void fetchBookings() async {
//   try {
//     Map<String,String> allvalues=await storage.readAll();
//                    String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//                    print(normalizedSource);
//                    String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//                    print(userid);
//     String userId = userid;
//     List<Busbookings> fetchedBookings = await _viewService.getBookingsByUserId(userId);
//     List<Map<String, dynamic>> bookingsList = fetchedBookings.map((booking) {
//       return {
//         'busid':booking.busId,
//         'bookingId': booking.id,

//           'from': booking.from, // Add 'from' location
//         'to': booking.to, 
//         // 'status': booking.status ?? 'Confirmed',
//         'date': booking.createdAt,
//         // Add other fields you want to display
//       };
//     }).toList();
//     setState(() {
//       _bookings = bookingsList;
//     });
//   } catch (e) {
//     print('Error fetching bookings: $e');
//     setState(() {
//       _bookings = [];
//     });
//   }
// }

// void fetchCancelledBookings() async {
//   try {
//     Map<String,String> allvalues=await storage.readAll();
//                    String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
//                    print(normalizedSource);
//                    String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//                    print(userid);
//     String userId = userid;
//     List<Map<String, dynamic>> fetchedCancelledBookings = await _viewService.getCancelledBookingsByUserId(userId);
//     setState(() {
//       _cancelledBookings = fetchedCancelledBookings;
//     });
//   } catch (e) {
//     print('Error fetching cancelled bookings: $e');
//     setState(() {
//       _cancelledBookings = [];
//     });
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('My Trips', style: TextStyle(color: Colors.black)),
//       centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
//       elevation: 0,
//       bottom: PreferredSize(
//         preferredSize: Size.fromHeight(4),
//         child: Container(
//           color: Colors.deepPurple.shade700,
//           height: 4,
//         ),
//       ),
//     ),
//     body: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Upcoming Trips',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//           ),
//           _buildBookingsList(),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Cancelled Bookings',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//           _buildCancelledBookingsList(),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildBookingsList() {
//   if (_bookings.isEmpty) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Text('No upcoming trips.', style: TextStyle(color: Colors.grey)),
//     );
//   }
//   return ListView.builder(
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: _bookings.length,
//     itemBuilder: (context, index) {
//       return Card(
//         clipBehavior: Clip.hardEdge,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         elevation: 4,
//         child: InkWell(
//          onTap: () {
//           final bookings = _bookings[index];
//           final busId = bookings['busid'];
//           print('$busId');
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage(busId: busId,)));
//           // Handle onTap here, possibly navigate to a new screen with busId
//         },
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Booking ID: ${_bookings[index]['bookingId']}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple,
//                         ),
//                       ),

//                         SizedBox(height: 4),
//                       Text(
//                         'From: ${_bookings[index]['from']}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'To: ${_bookings[index]['to']}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//    SizedBox(height: 4),
//                       Text(
//                         'Status: ${_bookings[index]['status'] ?? 'Confirmed'}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.green,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Booking Date: ${_bookings[index]['date'] ?? 'Unknown'}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                         overflow: TextOverflow.ellipsis, // Adjust this based on your preference
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 8), // Adjust the spacing between the text and button
//                 ElevatedButton(
//                   onPressed: () async {
//                     await _cancelBooking(_bookings[index]['bookingId']); // Cancel the booking
//                   },
//                   child: Text('Cancel'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.red,
//                     onPrimary: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//      );
//     },
//   );
// }

// Future<void> _cancelBooking(String bookingId) async {
//   try {
//     await _viewService.cancelBooking(bookingId);
//     // Update UI to reflect cancellation
//     setState(() {
//       _bookings.removeWhere((booking) => booking['bookingId'] == bookingId);
//     });
//     // Navigate to the confirmation page
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BookingCancelledPage(bookingId: bookingId)),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error cancelling booking: $e')),
//     );
//   }
// }


// Widget _buildCancelledBookingsList() {
//   if (_cancelledBookings.isEmpty) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Text('No cancelled bookings.', style: TextStyle(color: Colors.grey)),
//     );
//   }
//   return ListView.builder(
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: _cancelledBookings.length,
//     itemBuilder: (context, index) {
//       return Card(
//         clipBehavior: Clip.hardEdge,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         elevation: 4,
//         child: InkWell(
//           onTap: () {
//             // Handle onTap here
//           },
//           child: ListTile(
//             leading: Icon(Icons.cancel, color: Colors.red),
//             title: Text(
//               'Booking ID: ${_cancelledBookings[index]['_id']}',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
                
//                 Text(
//                   'Status: ${_cancelledBookings[index]['status'] ?? 'Cancelled'}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.red,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Cancelled Date: ${_cancelledBookings[index]['cancelledAt'] ??'Unknown'}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/model/busbook.dart';
// import 'package:project_1_frontend/pages/BookingCancelledPage.dart';
// import 'package:project_1_frontend/pages/busreview.dart';
// import 'package:project_1_frontend/services/bookingservice.dart';
// import 'package:project_1_frontend/services/cancelbookservice.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';

// class BookingDetailsScreen extends StatefulWidget {
//   @override
//   _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
// }

// class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
//   final ViewService _viewService = ViewService();
//   List<Map<String, dynamic>> _bookings = [];
//   List<Map<String, dynamic>> _cancelledBookings = [];
//   final storage = const FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();
//     fetchBookings();
//     fetchCancelledBookings();
//   }

//   void fetchBookings() async {
//     try {
//       Map<String, String> allvalues = await storage.readAll();
//       String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       String userid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//       String userId = userid;
//       List<Busbookings> fetchedBookings = await _viewService.getBookingsByUserId(userId);
//       List<Map<String, dynamic>> bookingsList = fetchedBookings.map((booking) {
//         return {
//           'busid': booking.busId,
//           'bookingId': booking.id,
//           'from': booking.from,
//           'to': booking.to,
//           'date': booking.createdAt.toString(), // Ensure date is a String
//         };
//       }).toList();
//       setState(() {
//         _bookings = bookingsList;
//       });
//     } catch (e) {
//       print('Error fetching bookings: $e');
//       setState(() {
//         _bookings = [];
//       });
//     }
//   }

//   void fetchCancelledBookings() async {
//     try {
//       Map<String, String> allvalues = await storage.readAll();
//       String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       String userid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//       String userId = userid;
//       List<Map<String, dynamic>> fetchedCancelledBookings = await _viewService.getCancelledBookingsByUserId(userId);
//       setState(() {
//         _cancelledBookings = fetchedCancelledBookings;
//       });
//     } catch (e) {
//       print('Error fetching cancelled bookings: $e');
//       setState(() {
//         _cancelledBookings = [];
//       });
//     }
//   }

//   String formatDateTime(String dateTimeString) {
//     DateTime dateTime = DateTime.parse(dateTimeString);
//     return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Trips', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
//         elevation: 0,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(4),
//           child: Container(
//             color: Colors.deepPurple.shade700,
//             height: 4,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Upcoming Trips',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//             ),
//             _buildBookingsList(),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Cancelled Bookings',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             _buildCancelledBookingsList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBookingsList() {
//     if (_bookings.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text('No upcoming trips.', style: TextStyle(color: Colors.grey)),
//       );
//     }
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: _bookings.length,
//       itemBuilder: (context, index) {
//         return Card(
//           clipBehavior: Clip.hardEdge,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           elevation: 4,
//           child: InkWell(
//             onTap: () {
//               final bookings = _bookings[index];
//               final busId = bookings['busid'];
//               Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage(busId: busId)));
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Booking ID: ${_bookings[index]['bookingId']}',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepPurple,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'From: ${_bookings[index]['from']}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'To: ${_bookings[index]['to']}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'Status: ${_bookings[index]['status'] ?? 'Confirmed'}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.green,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'Booking Date: ${formatDateTime(_bookings[index]['date'] ?? 'Unknown')}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await _cancelBooking(_bookings[index]['bookingId']);
//                     },
//                     child: Text('Cancel'),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.red,
//                       onPrimary: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _cancelBooking(String bookingId) async {
//     try {
//       await _viewService.cancelBooking(bookingId);
//       setState(() {
//         _bookings.removeWhere((booking) => booking['bookingId'] == bookingId);
//       });
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => BookingCancelledPage(bookingId: bookingId)),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error cancelling booking: $e')),
//       );
//     }
//   }

//   Widget _buildCancelledBookingsList() {
//     if (_cancelledBookings.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text('No cancelled bookings.', style: TextStyle(color: Colors.grey)),
//       );
//     }
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: _cancelledBookings.length,
//       itemBuilder: (context, index) {
//         return Card(
//           clipBehavior: Clip.hardEdge,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           elevation: 4,
//           child: InkWell(
//             onTap: () {
//               // Handle onTap here
//             },
//             child: ListTile(
//               leading: Icon(Icons.cancel, color: Colors.red),
//               title: Text(
//                 'Booking ID: ${_cancelledBookings[index]['_id']}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Status: ${_cancelledBookings[index]['status'] ?? 'Cancelled'}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.red,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Cancelled Date: ${formatDateTime(_cancelledBookings[index]['cancelledAt'] ?? 'Unknown')}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/model/busbook.dart';
// import 'package:project_1_frontend/pages/BookingCancelledPage.dart';
// import 'package:project_1_frontend/pages/busreview.dart';
// import 'package:project_1_frontend/services/bookingservice.dart';
// import 'package:project_1_frontend/services/cancelbookservice.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';

// class BookingDetailsScreen extends StatefulWidget {
//   @override
//   _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
// }

// class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
//   final ViewService _viewService = ViewService();
//   List<Map<String, dynamic>> _bookings = [];
//   List<Map<String, dynamic>> _cancelledBookings = [];
//   final storage = const FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();
//     fetchBookings();
//     fetchCancelledBookings();
//   }

//   void fetchBookings() async {
//     try {
//       Map<String, String> allvalues = await storage.readAll();
//       String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       String userid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//       String userId = userid;
//       List<Busbookings> fetchedBookings = await _viewService.getBookingsByUserId(userId);
//       List<Map<String, dynamic>> bookingsList = fetchedBookings.map((booking) {
//         return {
//           'busid': booking.busId,
//           'bookingId': booking.id,
//           'from': booking.from,
//           'to': booking.to,
//           'date': booking.createdAt.toString(), 
//           'startTime':booking.startTime,
//           'isExpanded': false, // Initialize isExpanded as false
//         };
//       }).toList();
//       setState(() {
//         _bookings = bookingsList;
//       });
//     } catch (e) {
//       print('Error fetching bookings: $e');
//       setState(() {
//         _bookings = [];
//       });
//     }
//   }

//   void fetchCancelledBookings() async {
//     try {
//       Map<String, String> allvalues = await storage.readAll();
//       String normalizedSource = base64Url.normalize(allvalues["token"]!.split(".")[1]);
//       String userid = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
//       String userId = userid;
//       List<Map<String, dynamic>> fetchedCancelledBookings = await _viewService.getCancelledBookingsByUserId(userId);
//       List<Map<String, dynamic>> cancelledBookingsList = fetchedCancelledBookings.map((booking) {
//         return {
//           ...booking,
//           'isExpanded': false, // Initialize isExpanded as false
//         };
//       }).toList();
//       setState(() {
//         _cancelledBookings = cancelledBookingsList;
//       });
//     } catch (e) {
//       print('Error fetching cancelled bookings: $e');
//       setState(() {
//         _cancelledBookings = [];
//       });
//     }
//   }

//   String formatDateTime(String dateTimeString) {
//     DateTime dateTime = DateTime.parse(dateTimeString);
//     return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Trips', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
//         elevation: 0,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(4),
//           child: Container(
//             color: Colors.deepPurple.shade700,
//             height: 4,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Upcoming Trips',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//             ),
//             _buildBookingsList(),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Cancelled Bookings',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             _buildCancelledBookingsList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBookingsList() {
//     if (_bookings.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text('No upcoming trips.', style: TextStyle(color: Colors.grey)),
//       );
//     }
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: _bookings.length,
//       itemBuilder: (context, index) {
//         return Card(
//           clipBehavior: Clip.hardEdge,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           elevation: 4,
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 _bookings[index]['isExpanded'] = !_bookings[index]['isExpanded'];
//               });
//             },
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Booking ID: ${_bookings[index]['bookingId']}',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'From: ${_bookings[index]['from']}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'To: ${_bookings[index]['to']}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'Status: ${_bookings[index]['status'] ?? 'Confirmed'}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.green,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'Booking Date: ${formatDateTime(_bookings[index]['date'] ?? 'Unknown')}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: () async {
//                           await _cancelBooking(_bookings[index]['bookingId']);
//                         },
//                         child: Text('Cancel'),
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.red,
//                           onPrimary: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (_bookings[index]['isExpanded'])
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text(
//                           'Detailed Information',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepPurple,
//                           ),
//                         ),
//                       ),
//                       // Add other detailed information fields here
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('Bus ID: ${_bookings[index]['busid']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('From: ${_bookings[index]['from']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('To: ${_bookings[index]['to']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('Additional Details...'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             final busId = _bookings[index]['busid'];
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => ReviewPage(busId: busId)),
//                             );
//                           },
//                           child: Text('Review'),
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.blue,
//                             onPrimary: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _cancelBooking(String bookingId) async {
//     try {
//       await _viewService.cancelBooking(bookingId);
//       setState(() {
//         _bookings.removeWhere((booking) => booking['bookingId'] == bookingId);
//       });
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => BookingCancelledPage(bookingId: bookingId)),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error cancelling booking: $e')),
//       );
//     }
//   }

//   Widget _buildCancelledBookingsList() {
//     if (_cancelledBookings.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text('No cancelled bookings.', style: TextStyle(color: Colors.grey)),
//       );
//     }
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: _cancelledBookings.length,
//       itemBuilder: (context, index) {
//         return Card(
//           clipBehavior: Clip.hardEdge,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           elevation: 4,
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 _cancelledBookings[index]['isExpanded'] = !_cancelledBookings[index]['isExpanded'];
//               });
//             },
//             child: Column(
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.cancel, color: Colors.red),
//                   title: Text(
//                     'Booking ID: ${_cancelledBookings[index]['_id']}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Status: ${_cancelledBookings[index]['status'] ?? 'Cancelled'}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.red,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Cancelled Date: ${formatDateTime(_cancelledBookings[index]['cancelledAt'] ?? 'Unknown')}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (_cancelledBookings[index]['isExpanded'])
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text(
//                           'Detailed Information',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                       // Add other detailed information fields here
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('Bus ID: ${_cancelledBookings[index]['busid']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('From: ${_cancelledBookings[index]['from']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('To: ${_cancelledBookings[index]['to']}'),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text('Additional Details...'),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/model/busbook.dart';
import 'package:project_1_frontend/pages/BookingCancelledPage.dart';
import 'package:project_1_frontend/pages/busreview.dart';
import 'package:project_1_frontend/services/bookingservice.dart';
import 'package:project_1_frontend/services/cancelbookservice.dart';

class BookingDetailsScreen extends StatefulWidget {
  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final ViewService _viewService = ViewService();
  List<Map<String, dynamic>> _bookings = [];
  List<Map<String, dynamic>> _cancelledBookings = [];
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchBookings();
    fetchCancelledBookings();
  }

  void fetchBookings() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
      String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

      List<Busbookings> fetchedBookings = await _viewService.getBookingsByUserId(userId);
      List<Map<String, dynamic>> bookingsList = fetchedBookings.map((booking) {
        return {
          'busid': booking.busId,
          'bookingId': booking.id,
          'from': booking.from,
          'to': booking.to,
          'date': booking.createdAt.toString(),
          'startTime': booking.startTime,
          'endTime': booking.endTime,
          'numberOfSeats': booking.numberOfSeats,
          'totalCost': booking.totalCost,
          'pickupPoint': booking.pickupPoint,
          'dropPoint': booking.dropPoint,
          'travelers': booking.travelers.map((traveler) => traveler.fullName).toList(),
          'isExpanded': false,
        };
      }).toList();

      setState(() {
        _bookings = bookingsList;
      });
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        _bookings = [];
      });
    }
  }

  void fetchCancelledBookings() async {
    try {
      Map<String, String> allValues = await storage.readAll();
      String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
      String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

      List<Map<String, dynamic>> fetchedCancelledBookings = await _viewService.getCancelledBookingsByUserId(userId);
      List<Map<String, dynamic>> cancelledBookingsList = fetchedCancelledBookings.map((booking) {
        return {
          '_id': booking['_id'],
          'from': booking['from'],
          'to': booking['to'],
          'date': booking['createdAt'].toString(),
          'status': booking['status'],
          'cancelledAt': booking['cancelledAt'].toString(),
          'busid': booking['busid'],
          'isExpanded': false,
        };
      }).toList();

      setState(() {
        _cancelledBookings = cancelledBookingsList;
      });
    } catch (e) {
      print('Error fetching cancelled bookings: $e');
      setState(() {
        _cancelledBookings = [];
      });
    }
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(
            color: Colors.deepPurple.shade700,
            height: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Upcoming Trips',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            _buildBookingsList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Cancelled Bookings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            _buildCancelledBookingsList(),
          ],
        ),
      ),
    );
  }

  
   Widget _buildBookingsList() {
  if (_bookings.isEmpty) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('No upcoming trips.', style: TextStyle(color: Colors.grey)),
    );
  }
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: _bookings.length,
    itemBuilder: (context, index) {
      return Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        elevation: 4,
        child: InkWell(
          onTap: () {
            setState(() {
              _bookings[index]['isExpanded'] = !_bookings[index]['isExpanded'];
            });
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From: ${_bookings[index]['from']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'To: ${_bookings[index]['to']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Status: ${_bookings[index]['status'] ?? 'Confirmed'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Booking Date: ${formatDateTime(_bookings[index]['date'] ?? 'Unknown')}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        bool confirmCancel = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Cancellation'),
                              content: Text('Are you sure you want to cancel this booking?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); // User did not confirm
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // User confirmed
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmCancel == true) {
                          await _cancelBooking(_bookings[index]['bookingId']);
                        }
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
              if (_bookings[index]['isExpanded'])
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Detailed Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    // Add other detailed information fields here
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Start Time: ${_bookings[index]['startTime']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'End Time: ${_bookings[index]['endTime']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Number of Seats: ${_bookings[index]['numberOfSeats']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Total Cost: ${_bookings[index]['totalCost']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Pickup Point: ${_bookings[index]['pickupPoint']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Drop Point: ${_bookings[index]['dropPoint']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Travelers: ${_bookings[index]['travelers'].join(", ")}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final busId = _bookings[index]['busid'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReviewPage(busId: busId)),
                          );
                        },
                        child: Text('Review'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    },
  );
}

   Future<void> _cancelBooking(String bookingId) async {
    try {
      await _viewService.cancelBooking(bookingId);
      setState(() {
        _bookings.removeWhere((booking) => booking['bookingId'] == bookingId);
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingCancelledPage(bookingId: bookingId)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cancelling booking: $e')),
      );
    }
  }

  Widget _buildCancelledBookingsList() {
    if (_cancelledBookings.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('No cancelled bookings.', style: TextStyle(color: Colors.grey)),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _cancelledBookings.length,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          elevation: 4,
          child: InkWell(
            onTap: () {
              setState(() {
                _cancelledBookings[index]['isExpanded'] = !_cancelledBookings[index]['isExpanded'];
              });
            },
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.cancel, color: Colors.red),
                  title: Text(
                    'Booking ID: ${_cancelledBookings[index]['_id']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: ${_cancelledBookings[index]['status'] ?? 'Cancelled'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Cancelled Date: ${formatDateTime(_cancelledBookings[index]['cancelledAt'] ?? 'Unknown')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      // SizedBox(height: 4),
                      // Text(
                      //   'From: ${_cancelledBookings[index]['from']}',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      // SizedBox(height: 4),
                      // Text(
                      //   'To: ${_cancelledBookings[index]['to']}',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      // SizedBox(height: 4),
                      // Text(
                      //   'Additional Details...',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                if (_cancelledBookings[index]['isExpanded'])
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Detailed Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      // Add other detailed information fields here
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Bus ID: ${_cancelledBookings[index]['busid']}'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
