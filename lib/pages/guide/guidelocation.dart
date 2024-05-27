import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio package
import 'package:project_1_frontend/models/guidemodel.dart';
import 'package:project_1_frontend/pages/guide/guides.dart';
import 'package:project_1_frontend/services/guideservice.dart';
// import 'package:project_1_frontend/pages/hotelsdetails.dart';
// import 'package:project_1_frontend/services/GuideService.dart';
// import 'package:project_1_frontend/services/updateservice.dart'; // Import the HotelDetailsPage

class guidebyloc extends StatefulWidget {
  @override
  _guidebyloc createState() => _guidebyloc();
}

class _guidebyloc extends State<guidebyloc> {
  String? _selectedLocation; // From location

  List<dynamic>_data=[];
  GuideService service=GuideService();
 List<String> _locations = [
    'Ernakulam',
    'Chennai',
    // 'Koyambedu',
    // 'Vandalur',
    // 'Vyttila',
    // 'Edapally 2',
    // 'Paravoor Kavala',
    // 'Palarivattom',
    'Kasargod',
    'Banglore',
    'Kannur',
    'Thrissur',
    'Angamaly',
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

  void _searchGuide() async {
    if (_formKey.currentState!.validate()) {
      try {
        final Response res = await service.getguideByLocation(_selectedLocation!);
        setState(() {
          _data = res.data;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuidePage(travelGuide: _data),
          ),
        );
      } on DioException catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // content: Text('An error occurred: $e'),
                        content: Text('Guides not found for the particular Location'),

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
          'Find a Guide',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
          backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
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
                Icon(
                  Icons.location_on_outlined,
                  size: 50,
                  color: Colors.teal, // Changed icon color
                ),
                SizedBox(height: 20),
                Text(
                  'Select Location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    items: _locations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '-- Select Location --',
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
                  onPressed: () {
                    _searchGuide();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),

                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 8, // Added elevation
                    shadowColor: Colors.blue.withOpacity(0.5), // Added shadow color
                  ),
                  child: Text(
                    'Search Guides',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
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
    home: guidebyloc(),
  ));
}