import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/hotelList.dart';
import 'dart:convert';
import 'package:project_1_frontend/services/configu.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddHotelPage extends StatefulWidget {
  @override
  _AddHotelPageState createState() => _AddHotelPageState();
}

class _AddHotelPageState extends State<AddHotelPage> {
  List<Map<String, dynamic>> _hotelList = [];
  final TextEditingController _costController = TextEditingController();
  String? _selectedLocation; // Initial location set to null
  String _selectedAC = '--Select--'; // Initial AC/NON-AC selection set to "--select--"

  List<String> _locations = [
    'Valanjambalam, Cochin',
  
    'Ernakulam South, Cochin',
    'Kaloor',
    'NH Bypass, Chakkarparambu Junction',
    'Ernakulam',
    'Infopark Kochi Phase 1 Campus',
    'Kochi',
    'Periyamet, Chennai',
    'Choolaimedu, Chennai',
    'Karappakam, Chennai',
    'Pallavaram, Chennai',
    'Egatoor, Chennai',
    'Poongavanapuram, Chennai',
    'Chennai',
    'Mount Road, Chennai',
    'Velachery, Chennai',
    'Dr Radhakrishnan Salai Road, Chennai',
    'Vadapalani, Chennai',
    'Brookefield, Bangalore',
    'Thammenahalli Village, Bangalore',
    'Cubbon Park and UB City',
    'Bangalore',
    'Sonnapanahalli, Bangalore',
    'Narayanapura, Bangalore',
    'Koramangala',
    'Thanisandra, Bangalore',
    'HSR Layout',
    'HAL Airport Area',
    'Ashok Nagar',
    'Vasanth Nagar',
    'Domlur Layout',
    'Tirumanahalli',
    'Chickpete, Bangalore',
    'Mavalli, Bangalore',
    'Gandhi Nagar',
    'Anna Nagar, Chennai',
    'MRC Nagar, Chennai',
    'Padappai, Chennai',
    'Tambaram, Chennai',
    'Kelambakkam, Chennai',
    'GST Road, Chennai',
    'Guindy, Chennai',
  ];

  List<String> _acOptions = ['--Select--', 'AC', 'NON-AC']; // Options for AC/NON-AC

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          content: Text("Loading details based on your criteria"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("VIEW"),
            ),
          ],
        );
      },
    );
  }

  Config config = Config();

  Future<void> _fetchHotelList() async {
    final apiUrl = Uri.parse(config.hotelflaskUrl); // Use flaskUrl from Config
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "location": _selectedLocation,
      "acNonAc": _selectedAC,
      "cost": double.parse(_costController.text),
    });

    final response = await http.post(apiUrl, headers: headers, body: body);

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _hotelList = List<Map<String, dynamic>>.from(json.decode(response.body));
        
      });
    } else {
      setState(() {
        _hotelList = [];
      });
      // Handle error
    }
  }

  Future<void> _saveFormDataToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', _selectedLocation ?? '');

    await prefs.setString('acNonAc', _selectedAC);

    await prefs.setDouble('cost', double.tryParse(_costController.text) ?? 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotels',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               
                Text(
                  'Location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 10),
                Container(
                 // Adjust the height as needed
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
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
                       // Adding down arrow icon
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
                Text(
                  'AC/NON-AC',
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
                    value: _selectedAC,
                    items: _acOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedAC = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == '--Select--') {
                        return 'Please select AC/NON-AC';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Cost/Night',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _costController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter Cost',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the cost per night';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _saveFormDataToSharedPreferences();
                      // await _fetchHotelList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => hotelListPage(),
                        ),
                      );
                      // Show success dialog
                      _showSuccessDialog();
                    }
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
    home: AddHotelPage(),
  ));
}
