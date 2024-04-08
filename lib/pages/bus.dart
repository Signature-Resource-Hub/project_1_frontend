import 'package:flutter/material.dart';

class AddBusPage extends StatefulWidget {
  @override
  _AddBusPageState createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  final TextEditingController _costController = TextEditingController();
  String? _selectedFrom; // From location
  String? _selectedTo; // To location
  String _selectedAC = '--Select--'; // AC/NON-AC
  String _selectedBusType = '--Select--'; // Bus type

  List<String> _fromLocations = [
    'Ernakulam',
    'Chennai',
    'Koyambedu',
    'Vandalur',
    'Vyttila',
    'Edapally 2',
    'Paravoor Kavala',
    'Palarivattom',
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
    'Madiwala',
    'KEMPEGOWDA BS MAJESTIC',
    'Kasargod',
    'Palakkad',
    'Wayanad',
  ];

  List<String> _acOptions = ['--Select--', 'AC', 'NON-AC']; // Options for AC/NON-AC
  List<String> _busTypes = ['--Select--', 'Sleeper', 'Semi Sleeper', 'Multi Axle Sleeper']; // Bus types

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bus',
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
                SizedBox(height: 20),
                Text(
                  'Bus Type',
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
                    value: _selectedBusType,
                    items: _busTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBusType = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == '--Select--') {
                        return 'Please select a bus type';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Cost',
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
                      return 'Please enter the cost.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // All fields are valid, proceed with adding the bus
                      // Add bus logic here
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
    home: AddBusPage(),
  ));
}
