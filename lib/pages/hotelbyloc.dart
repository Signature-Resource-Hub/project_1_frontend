
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio package
import 'package:project_1_frontend/models/post.dart';
import 'package:project_1_frontend/pages/hot_byloc_details.dart';

import 'package:project_1_frontend/services/hotelservice.dart';
import 'package:project_1_frontend/services/updateservice.dart'; // Import the HotelDetailsPage

class HotelbylocPage extends StatefulWidget {
  @override
  _HotelbylocState createState() => _HotelbylocState();
}

class _HotelbylocState extends State<HotelbylocPage> {
  String? _selectedLocation; // From location

  List<dynamic>_data=[];
  HotelService service=HotelService();
  List<String> _locations = [
    "Valanjambalam, Cochin",
    "Near Cochin South Train Station, Cochin",
    "Ernakulam South, Cochin",
    
    
    
    "Kelambakkam, Chennai",
   
    
    "Mount road, Chennai",
    "Vadapalani, Chennai",
    "Banglore",
    "Sonnapanahalli, Bangalore",
    
    "Koramangala",
    
    "HSR Layout",
    "HAL Airport Area",
    
    "Vasanth Nagar",
    "Domlur Layout",
    "Tirumanahalli",
    
    "Mavalli, Bangalore",
    "Kaloor",
"Ernakulam",
"Kochi",
"Periyamet, Chennai",
"Choolaimedu, Chennai",
"Karappakam, Chennai",
"Pallavaram, Chennai",
"Chennai",
"Brookefield, Bangalore",
"Thammenahalli Village, Bangalore",
"Thanisandra, Bangalore",
"Chickpete, Bangalore"
    //"Gandhi Nagar"
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showError(String content, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
 

void _searchHotels() async {
    var data=jsonEncode({
      "location": _selectedLocation,
    

    }
    );

  if (_formKey.currentState!.validate()) {
    try {
      // Call the API service to fetch buses
      final Response res = await service.getRoomByLocation(_selectedLocation!);
      print(res.data);
      setState(() {
        _data=res.data;
      });

      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationDetails(hotelRooms: _data),
        ),
      );
    } on DioException catch (e) {
      // Handle any exceptions (e.g., network errors)
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Text(
                  'Location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text('-- Select --'),
                      ),
                      ..._locations.map((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        );
                      }),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a location';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
  onPressed: () async {
    // Call the _searchBuses function and wait for the result
    _searchHotels();
    
    
  },
  child: Text('Search Hotels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HotelbylocPage(),
  ));
}


