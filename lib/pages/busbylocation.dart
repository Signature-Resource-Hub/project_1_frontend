

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_1_frontend/model/postprd.dart';
import 'package:project_1_frontend/pages/locatiodetails.dart';
import 'package:project_1_frontend/services/authservice.dart';
import 'package:project_1_frontend/services/busservice.dart';

class BusByLocation extends StatefulWidget {
  @override
  _BusByLocationState createState() => _BusByLocationState();
}

class _BusByLocationState extends State<BusByLocation> {
  String? _selectedFrom; // From location
  String? _selectedTo; // To location
  DateTime? _selectedDate; // Selected date
  List<dynamic> _data = [];
  BusService service = BusService();

  List<String> _fromLocations = [
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

  List<String> _toLocations = [
    'Chennai',
    'Ernakulam',
    'Vyttila Junction',
    'Vyttila',
    'Banglore',
    'Kasaragod',
    'Palakkad',
    'Wayanad',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Bus Added Successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _searchBuses() async {
    // Check if both from, to locations, and date are selected
    if (_selectedFrom == null || _selectedTo == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both "From", "To" locations, and date.'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Exit the function early
    }

    var data = jsonEncode({
      "from": _selectedFrom,
      "to": _selectedTo,
      "date": _selectedDate!.toString(), // Convert DateTime to String
    });

    if (_formKey.currentState!.validate()) {
      try {
        // Call the API service to fetch buses
        final Response res = await service.getBusByLocation(_selectedFrom!, _selectedTo!);
        print(res.data);
        List<dynamic> buses = res.data;

        if (buses.isEmpty) {
          // If no travels are available for the selected locations, show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No travels available for the selected locations.'),
              backgroundColor: Colors.red,
            ),
          );
          return; // Exit the function early
        }

        // If travels are available, navigate to the LocationDetails page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationDetails(buses: buses, busId: 'busId',),
          ),
        );
      } on DioException catch (e) {
        // Handle any exceptions (e.g., network errors)
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No travels available for the selected locations'),
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
          'Bus By Location',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Text(
                'From',
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
                  value: _selectedFrom,
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text('-- Select --'),
                    ),
                    ..._fromLocations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFrom = newValue;
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
              SizedBox(height: 20),
              Text(
                'To',
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
                  value: _selectedTo,
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text('-- Select --'),
                    ),
                    ..._toLocations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTo = newValue;
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
              SizedBox(height: 20),
              Text(
                'Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (picked != null && picked != _selectedDate) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? '-- Select Date --'
                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  _searchBuses();
                },
                child: Text('Search Buses', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BusByLocation(),
  ));
}
