import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/models/hotels.dart';

import 'package:project_1_frontend/pages/bookingcancels.dart';
import 'package:project_1_frontend/pages/hotelreview.dart';
import 'package:project_1_frontend/services/orderhotel.dart';
import 'package:project_1_frontend/models/orders.dart';
import 'package:project_1_frontend/models/ordedetail.dart';


class BookingDetailScreen extends StatefulWidget {
  @override
  _BookingDetailScreenState createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
//  final BookingService _bookingService = BookingService();
  final DisplayService _displayService = DisplayService();
  final storage=const FlutterSecureStorage();

List<Map<String, dynamic>> _bookings = [];
List<Map<String, dynamic>> _cancelledBookings = [];

@override
void initState() {
  super.initState();
  fetchBookings();
  fetchCancelledBookings();
}

void fetchBookings() async {
  try {

    Map<String,String> allvalues=await storage.readAll();
                   String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
                   print(normalizedSource);
                   String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
                   print(userid);
    String userId = userid;


    // String userId = '6609ad6e41529c575ef27e1b';
    List<Display> fetchedBookings = await _displayService.getBookingsByUserId(userId);
    List<Map<String, dynamic>> bookingsList = fetchedBookings.map((booking) {
      print('Booking Price: ${booking.price}'); 
      print(booking.hotelId);
      return {
        'bookingId': booking.id,
        'hotelId':booking.hotelId,
        // 'status': booking.status ?? 'Confirmed',
        'date': booking.bookingDate,
        'price':booking.price,
        //'hotelName':booking.hotelName
        // Add other fields you want to display
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

    Map<String,String> allvalues=await storage.readAll();
                   String normalizedSource=base64Url.normalize(allvalues["token"]!.split(".")[1]);
                   print(normalizedSource);
                   String userid=json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
                   print(userid);
    String userId = userid;
    // String userId = '6609ad6e41529c575ef27e1b';
    List<Map<String, dynamic>> fetchedCancelledBookings = await _displayService.getCancelledBookingsByUserId(userId);
    setState(() {
      _cancelledBookings = fetchedCancelledBookings;
    });
  } catch (e) {
    print('Error fetching cancelled bookings: $e');
    setState(() {
      _cancelledBookings = [];
    });
  }
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
            final bookings = _bookings[index];
            final hotelId = bookings['hotelId'];
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage(hotelid: hotelId)));
            // Handle onTap here
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking ID: ${_bookings[index]['bookingId']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
  'Price: ${_bookings[index]['price']}', // Accessing price here
  style: TextStyle(
    fontSize: 14,
    color: Colors.green,
  ),
   
),
// Text(
//   'HotelName: ${_bookings[index]['hotelName']}', // Accessing price here
//   style: TextStyle(
//     fontSize: 14,
//     color: Colors.green,
//   ),
   
// ),
                      Text(
                        'Status: ${_bookings[index]['status'] ?? 'Confirmed'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Booking Date: ${_bookings[index]['date'] ?? 'Unknown'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis, // Adjust this based on your preference
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8), // Adjust the spacing between the text and button
                ElevatedButton(
                  onPressed: () async {
                    await _cancel(_bookings[index]['bookingId']); // Cancel the booking
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
        ),
      );
    },
  );
}

// Future<void> _cancel(String bookingId) async {
//   try {
//     await _displayService.cancelBooking(bookingId);
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

Future<void> _cancel(String bookingId) async {
  try {
    // Call the cancelBooking method from the service
    await _displayService.cancelBooking(bookingId);
    
    // Update UI to reflect cancellation
    setState(() {
      // Remove the cancelled booking from the _bookings list
      _bookings.removeWhere((booking) => booking['bookingId'] == bookingId);
    });
    
    // Navigate to the confirmation page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingCancelledPage(bookingId: bookingId)),
    );
  } catch (e) {
    // Display error message if cancellation fails
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
            // Handle onTap here
          },
          child: ListTile(
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
                  'Cancelled Date: ${_cancelledBookings[index]['cancelledAt'] ??'Unknown'}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

}