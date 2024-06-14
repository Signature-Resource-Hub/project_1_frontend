
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:project_1_frontend/pages/dash.dart';
// import 'package:project_1_frontend/services/bookhotel.dart';
// //import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class RoomSelectionPage extends StatefulWidget {
//   final String hotelName;
//   final int rating;
//   final String location;
//   final String checkInTime;
//   final String checkOutTime;
//   final int numberOfNights;
//   final int costPerNight; // Added cost per night
//   final DateTime checkInDate;
//   final DateTime checkOutDate;
//   final String hotelid;
//   final String userName;
//   final String userEmail;
//   final String userPhone;

//   RoomSelectionPage({
//     required this.hotelid,
//     required this.hotelName,
//     required this.rating,
//     required this.location,
//     required this.checkInTime,
//     required this.checkOutTime,
//     required this.numberOfNights,
//     required this.costPerNight, 
//     required this.checkInDate,
//     required this.checkOutDate,
//     required this.userName,
//     required this.userEmail,
//     required this.userPhone,
//   });

//   @override
//   _RoomSelectionPageState createState() => _RoomSelectionPageState();
// }

// class _RoomSelectionPageState extends State<RoomSelectionPage> {
//   int _numberOfRooms = 1;
//   late double _totalCost;
//   late double _discountAmount;
//   late double _priceAfterDiscount;
//   String bookingFor = 'Myself';
//   late String _userName;
//   late String _userEmail;
//   late String _userPhone;
//   final _storage = FlutterSecureStorage();

//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _contactController;

  

//   @override
// void initState() {
//   super.initState();
//   _userName = widget.userName;
//   _userEmail = widget.userEmail;
//   _userPhone = widget.userPhone;
//   _emailController = TextEditingController(text: _userEmail);
//   _nameController = TextEditingController(text: _userName);
//   _contactController = TextEditingController(text: _userPhone);
  
//   _fetchUserDetails(); // Call _fetchUserDetails to populate text fields
//   _calculateCost();
//   _calculateDiscount();
// }


//   void _calculateCost() {
//     _totalCost = widget.numberOfNights * widget.costPerNight * _numberOfRooms.toDouble();
//   }

//   void _calculateDiscount() {
//     _discountAmount = _totalCost * 0.05; // 5% discount
//     _priceAfterDiscount = _totalCost - _discountAmount;
//   }

//   //  void sendBookData(String bookfor, String price) async {
//   //   SharedPreferences pref = await SharedPreferences.getInstance();
//   //   String userid = pref.getString('userid') ?? '';
//   //   String name = pref.getString('username') ?? '';
//   //   String email = pref.getString('useremail') ?? '';
//   //   String phone = pref.getString('phone') ?? '';
//   //   try {
//   //     final response = await BookHotelService().bookHotel(userid, widget.hotelid, bookfor,price);
//   //     if (response.statusCode == 200) {
//   //       // Assuming the response contains a JSON object
//   //       // Check if the response data contains the 'msg' key
//   //       if (response.data is Map<String, dynamic> && response.data.containsKey('msg')) {
//   //         print(response.data['msg']);
          
//   //       } else {
//   //         print('Unexpected response format: ${response.data}');
//   //       }
        
//   //     } else {
//   //       // Handle error responses
//   //       print('Error: ${response.statusCode}');
//   //       print('Response: ${response.data}');
//   //       _showSuccessDialog();
//   //     }
//   //   } catch (e) {
//   //     // Handle Dio errors or exceptions
//   //     print('Error: $e');
//   //   }
//   // }

//   void sendBookData(String bookfor, String price, String username, String useremail, String userphone) async {
//     String userid = await _storage.read(key: 'userid') ?? '';
//     String name = await _storage.read(key: 'username') ?? '';
//     String email = await _storage.read(key: 'useremail') ?? '';
//     String phone = await _storage.read(key: 'phone') ?? '';
    
//     try {
//       final response = await BookHotelService().bookHotel(userid, widget.hotelid, bookfor, price, username, useremail, userphone);
//       if (response.statusCode == 200) {
//         if (response.data is Map<String, dynamic> && response.data.containsKey('msg')) {
//           print(response.data['msg']);
//         } else {
//           print('Unexpected response format: ${response.data}');
//         }
//       } else {
//         print('Error: ${response.statusCode}');
//         print('Response: ${response.data}');
//         _showSuccessDialog();
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Success"),
//           content: Text("Your booking has been successful!"),
//           actions: <Widget>[
//             TextButton(
//               child: Text("OK"),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>dash()));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

// void _fetchUserDetails() async {
//   String userid = await _storage.read(key: 'userid') ?? '';
//   String name = await _storage.read(key: 'username') ?? '';
//   String email = await _storage.read(key: 'useremail') ?? '';
//   String phone = await _storage.read(key: 'phone') ?? '';
//   print("userid"+userid);
//   print("name"+name);
//   print("email"+email);
//   print(phone);
//   setState(() {
//     _nameController.text = name;
//     _emailController.text = email;
//     _contactController.text = phone;
//   });
// }



//   @override
//   Widget build(BuildContext context) {
//     DateFormat dateFormat = DateFormat('dd MMM yyyy');

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Review Booking'),
//         backgroundColor: Color.fromARGB(223, 238, 240, 239),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.hotelName,
//                         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       Row(
//                         children: List.generate(
//                           5,
//                           (index) => Icon(
//                             index < widget.rating ? Icons.star : Icons.star_border,
//                             color: index < widget.rating ? Colors.black : Colors.grey,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10), 
//                       Row(
//                         children: [
//                           Icon(Icons.location_on, color: Colors.black),
//                           SizedBox(width: 5),
//                           Text(
//                             widget.location,
//                             style: TextStyle(fontSize: 18, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'CHECK - IN',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         widget.checkInTime,
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         'CHECK - OUT',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         widget.checkOutTime,
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.black),
//                 ),
//                 child: Text(
//                   '${widget.numberOfNights} Night',
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.black),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Number of Rooms:',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//                         ),
//                         SizedBox(width: 20),
//                         DropdownButton<int>(
//                           value: _numberOfRooms,
//                           onChanged: (value) {
//                             setState(() {
//                               _numberOfRooms = value!;
//                               _calculateCost();
//                               _calculateDiscount();
//                             });
//                           },
//                           items: List.generate(
//                             10,
//                             (index) => DropdownMenuItem<int>(
//                               value: index + 1,
//                               child: Text((index + 1).toString()),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Non-refundable',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       'Refundable is not applicable for this booking',
//                       style: TextStyle(fontSize: 14, color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Price Breakup section
//               Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.black),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Price Breakup',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total Cost:',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           '₹${_totalCost.toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Discount:',
//                           style: TextStyle(fontSize: 16, color: Colors.green),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           '₹${_discountAmount.toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 16, color: Colors.green),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Price after Discount:',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           '₹${_priceAfterDiscount.toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//   padding: EdgeInsets.all(10),
//   margin: EdgeInsets.symmetric(vertical: 10),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(10),
//     border: Border.all(color: Colors.black),
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(bottom: 10),
//         child: Text(
//           'I am booking for',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       Row(
//         children: [
       
// //         Radio(
// //         value: 'Myself',
// //         groupValue: bookingFor, // Use the bookingFor variable
// //         onChanged: (value) {
// //         setState(() {
// //       bookingFor = value.toString();
// //     });
// //   },
// //   activeColor: Colors.blue,
// // ),

// Radio(
//   value: 'Myself',
//   groupValue: bookingFor,
//   onChanged: (value) async {
//     setState(() {
//       bookingFor = value.toString();
      
//     });
//     if (bookingFor == 'Myself') {
//       _fetchUserDetails(); // Call method to fetch user details
//     }
//   },
//   activeColor: Colors.blue,
// ),

//           Text(
//             'Myself',
//             style: TextStyle(fontSize: 16, color: Colors.black),
//           ),
        
//         Radio(
//         value: 'SomeoneElse',
//         groupValue: bookingFor, // Use the bookingFor variable
//         onChanged: (value) async {
//         setState(() {
//       bookingFor = value.toString();
//     });
//   },
//   activeColor: Colors.blue,
// ),


//           Text(
//             'Someone else',
//             style: TextStyle(fontSize: 16, color: Colors.black),
//           ),
//         ],
//       ),
//       SizedBox(height: 10),
//       TextField(
//         controller: _nameController,
//         decoration: InputDecoration(
//           labelText: 'Name',
//           //hintText: 'Enter your name',
//           border: OutlineInputBorder(),
//         ),
//       ),
//       SizedBox(height: 10),
//       TextField(
//         controller: _emailController,
//         decoration: InputDecoration(
//           labelText: 'Email',
//           //hintText: 'Enter your email',
//           border: OutlineInputBorder(),
//         ),
//       ),
//       SizedBox(height: 10),
//       TextField(
//         controller: _contactController,
//         decoration: InputDecoration(
//           labelText: 'Contact No',
//           //hintText: 'Enter your contact number',
//           border: OutlineInputBorder(),
//         ),
//       ),
//     ],
//   ),
// ),

//             ],
//           ),
//         ),
//       ),
//      bottomNavigationBar: BottomAppBar(
//         color: Colors.grey.shade800,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '₹${_priceAfterDiscount.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   sendBookData(bookingFor,_priceAfterDiscount.toString(),);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.black,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//                 ),
//                 minimumSize: Size(100, 50),
                
//                 ),
//                 //child: Text('Book Now', style: TextStyle(fontSize: 16)),
//                 //child: Padding(padding: const EdgeInsets.all(10),
//                 child: Text('Book Now',style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),),),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_1_frontend/models/blog.dart';
import 'package:project_1_frontend/pages/book_hotel.dart';
import 'package:project_1_frontend/pages/dash.dart';
import 'package:project_1_frontend/pages/payment.dart';
import 'package:project_1_frontend/services/bookhotel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RoomSelectionPage extends StatefulWidget {
  final String hotelName;
  final int rating;
  final String location;
  final String checkInTime;
  final String checkOutTime;
  final int numberOfNights;
  final int costPerNight;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String hotelid;

  RoomSelectionPage({
    required this.hotelid,
    required this.hotelName,
    required this.rating,
    required this.location,
    required this.checkInTime,
    required this.checkOutTime,
    required this.numberOfNights,
    required this.costPerNight,
    required this.checkInDate,
    required this.checkOutDate,
  });

  @override
  _RoomSelectionPageState createState() => _RoomSelectionPageState();
}

class _RoomSelectionPageState extends State<RoomSelectionPage> {
  int _numberOfRooms = 1;
  late double _totalCost;
  late double _discountAmount;
  late double _priceAfterDiscount;
  String bookingFor = 'Myself';

  final _storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _calculateCost();
    _fetchUserData();
    _calculateDiscount();
  }

  void _calculateCost() {
    _totalCost = widget.numberOfNights * widget.costPerNight * _numberOfRooms.toDouble();
  }

  void _calculateDiscount() {
    _discountAmount = _totalCost * 0.05; // 5% discount
    _priceAfterDiscount = _totalCost - _discountAmount;
  }

  void sendBookData(
    String bookfor,
    String price,
    String username,
    String useremail,
    String userphone,
    String hotelName,
    String startDate,
    String endDate,
  ) async {
    String userid = await _storage.read(key: 'userid') ?? '';
    String name = await _storage.read(key: 'username') ?? '';
    String email = await _storage.read(key: 'useremail') ?? '';
    String phone = await _storage.read(key: 'phone') ?? '';
    try {
      final response = await BookHotelService().bookHotel(userid, widget.hotelid, bookfor, price, username, useremail, userphone);
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic> && response.data.containsKey('msg')) {
          print(response.data['msg']);
        } else {
          print('Unexpected response format: ${response.data}');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.data}');
        _showSuccessDialog();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _fetchUserData() async {
    if (bookingFor == 'Myself') {
      String name = await _storage.read(key: 'username') ?? '';
      String email = await _storage.read(key: 'useremail') ?? '';
      String phone = await _storage.read(key: 'phone') ?? '';
      setState(() {
        _nameController.text = name;
        _emailController.text = email;
        _contactController.text = phone;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Your booking has been successful!"),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Background color
                onPrimary: Colors.white, // Text color
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(totalAmount: _priceAfterDiscount)));
              },
              child: Text("VIEW DETAILS", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text('Review Bookingsz'),
        backgroundColor: Color.fromARGB(223, 238, 240, 239),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.hotelName,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < widget.rating ? Icons.star : Icons.star_border,
                              color: index < widget.rating ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              widget.location,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHECK - IN',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.checkInTime,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          '${DateFormat('dd MMM yyyy').format(widget.checkInDate)}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'CHECK - OUT',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.checkOutTime,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          '${DateFormat('dd MMM yyyy').format(widget.checkOutDate)}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    '${widget.numberOfNights} Night',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Number of Rooms:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(width: 20),
                          DropdownButton<int>(
                            value: _numberOfRooms,
                            onChanged: (value) {
                              setState(() {
                                _numberOfRooms = value!;
                                _calculateCost();
                                _calculateDiscount();
                              });
                            },
                            items: List.generate(
                              10,
                              (index) => DropdownMenuItem<int>(
                                value: index + 1,
                                child: Text((index + 1).toString()),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Non-refundable',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Refundable is not applicable for this booking',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price Breakup',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Cost:',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(width: 20),
                          Text(
                            '₹${_totalCost.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount:',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                          SizedBox(width: 20),
                          Text(
                            '₹${_discountAmount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price after Discount:',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(width: 20),
                          Text(
                            '₹${_priceAfterDiscount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'I am booking for',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Myself',
                            groupValue: bookingFor,
                            onChanged: (value) {
                              setState(() {
                                bookingFor = value.toString();
                                _fetchUserData();
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text(
                            'Myself',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Radio(
                            value: 'SomeoneElse',
                            groupValue: bookingFor,
                            onChanged: (value) {
                              setState(() {
                                bookingFor = value.toString();
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text(
                            'Someone else',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
  controller: _contactController,
  decoration: InputDecoration(
    labelText: 'Contact No',
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter your contact number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    // Add more validation if needed
    return null;
  },
),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade800,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${_priceAfterDiscount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String hotelName = widget.hotelName;
                    String startDate = DateFormat('yyyy-MM-dd').format(widget.checkInDate);
                    String endDate = DateFormat('yyyy-MM-dd').format(widget.checkOutDate);
                    sendBookData(
                      bookingFor,
                      _priceAfterDiscount.toString(),
                      _nameController.text,
                      _emailController.text,
                      _contactController.text,
                      hotelName,
                      startDate,
                      endDate,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(100, 50),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
