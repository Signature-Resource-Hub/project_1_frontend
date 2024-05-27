import 'package:flutter/material.dart';
final _formKey = GlobalKey<FormState>();
class PaymentPage extends StatelessWidget {
  final int? totalAmount; // Define totalAmount as an optional parameter

  PaymentPage({this.totalAmount});
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
                          'PAY NOW ₹${totalAmount}',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay via Card'),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
        elevation: 0, // Removed elevation from app bar
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white, // Set background color to white
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey, // Assign the form key
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
                          style: TextStyle(color: Colors.black), // Set text color to black
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter card number';
                            } else if (int.tryParse(value) == null) {
                              return 'Please enter a valid card number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name on Card',
                          ),
                          style: TextStyle(color: Colors.black), // Set text color to black
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
                                style: TextStyle(color: Colors.black), // Set text color to black
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter expiry date';
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
                                style: TextStyle(color: Colors.black), // Set text color to black
                                obscureText: true, // Obscure CVV number
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter CVV';
                                  } else if (int.tryParse(value) == null) {
                                    return 'CVV should contain only numbers';
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Country',
                        ),
                        style: TextStyle(color: Colors.black), // Set text color to black
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter country';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'State',
                        ),
                        style: TextStyle(color: Colors.black), // Set text color to black
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter state';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Billing Address',
                  ),
                  style: TextStyle(color: Colors.black), // Set text color to black
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
                        style: TextStyle(color: Colors.black), // Set text color to black
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
                        style: TextStyle(color: Colors.black), // Set text color to black
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pincode';
                          } else if (value.length != 6) {
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
                    // Check if the form is valid
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, navigate to payment success page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentSuccess()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4), // Set button color to pink
                    padding: EdgeInsets.symmetric(vertical: 16), // Increase button padding
                  ),
                  child: Container(
                    width: double.infinity, // Make button full width
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
    home: PaymentPage(),
  ));
}