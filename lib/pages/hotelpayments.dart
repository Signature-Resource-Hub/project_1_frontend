import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/orderdetail.dart';
final _formKey = GlobalKey<FormState>();
class Payment extends StatelessWidget {
  final double totalAmount;

  Payment({required this.totalAmount});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Mode'),
        backgroundColor: Colors.pinkAccent.withOpacity(.5), // Change app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pinkAccent.withOpacity(.5), Colors.lightBlueAccent], // Gradient background
          ),
        ),
        child: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Icon(
                  Icons.credit_card, // Use an icon instead of the image
                  size: 120,
                  color: Colors.black, // Adjust icon color to black
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to payment options form
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentOptionsPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Change button color
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'PAY NOW ₹${totalAmount.toStringAsFixed(2)}', // Display total amount here
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Credit/Debit/ATM Cards',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Change text color to black
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Visa, MasterCard, Rupay and More',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black, // Change text color to black
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PaymentOptionsPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _districts = [
    'Select District',
    'Ernakulam',
    'Thrissur',
    'Kollam',
    'Kasargod',
    'Alapuzha'
    // Add more districts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay via Card'),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Enter Card Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Card Number',
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter card number';
                            } else if (value.length != 16 || int.tryParse(value) == null) {
                              return 'Please enter a valid 16 digit card number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name on Card',
                          ),
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name on card';
                            } else if (value.contains(RegExp(r'[0-9]'))) {
                              return 'Name should not contain numbers';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Expiry Date (MM/YY)',
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter expiry date';
                                  } else if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
                                    return 'should be in MM/YY format';
                                  } else {
                                    var split = value.split('/');
                                    var month = int.tryParse(split[0]);
                                    var year = int.tryParse('20${split[1]}');

                                    if (month == null || year == null) {
                                      return 'Please enter a valid expiry date';
                                    }

                                    var now = DateTime.now();
                                    var currentYear = now.year % 100;
                                    var currentMonth = now.month;

                                    if (year < currentYear || (year == currentYear && month < currentMonth)) {
                                      return 'Expiry date should be in the future';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'CVV',
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter CVV';
                                  } else if (value.length != 3 || int.tryParse(value) == null) {
                                    return 'CVV should be 3 digits';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Billing Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Required for your international cards',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'District',
                  ),
                  items: _districts.map((String district) {
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 'Select District') {
                      return 'Please select district';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Billing Address',
                  ),
                  style: TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter billing address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'City',
                        ),
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pincode';
                          } else if (value.length != 6 || int.tryParse(value) == null) {
                            return 'Please enter a valid pincode';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentSuccess()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Pay',
                      style: TextStyle(fontSize: 18),
                    ),
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
class PaymentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Success',
          style: TextStyle(color: Colors.black), // Title text color
        ),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
        elevation: 0, // Remove app bar elevation
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF64B5F6), Color(0xFF81C784)], // Gradient background colors
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 100,
                        color: Colors.green,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Payment completed successfully!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your transaction has been processed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30), // Add spacing between content and button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingDetailScreen()), // Navigate to HomePage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'My Trips',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold, // Text weight
                      fontSize: 18, // Text size
                    ),
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


// void main() {
//   final double totalAmount;

//   PaymentPage({required this.totalAmount});
//   runApp(MaterialApp(
//     home: PaymentPage(totalAmount: _priceAfterDiscount,),
//   ));
// }