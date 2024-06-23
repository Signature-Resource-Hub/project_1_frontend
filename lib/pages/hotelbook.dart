import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:project_1_frontend/pages/roomselection.dart';

class HotelBookingPage extends StatefulWidget {
  // Pass hotel details as constructor parameters
  final String hotelName;
  final int costPerNight;
  final String checkInTime;
  final String checkOutTime;
  final int rating;
  final String location;
  final String hotelid;

  const HotelBookingPage({
    Key? key,
    required this.hotelid,
    required this.hotelName,
    required this.costPerNight,
    required this.checkInTime,
    required this.checkOutTime,
    required this.rating,
    required this.location,
  }) : super(key: key);

  @override
  _HotelBookingPageState createState() => _HotelBookingPageState();
}

class _HotelBookingPageState extends State<HotelBookingPage> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;
  late int _numberOfNights;
  late double _totalCost;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _showStartDatePicker = false;
  bool _showEndDatePicker = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("InitState executed");
    _selectedStartDate = DateTime.now().add(Duration(days: 1));
    _selectedEndDate = DateTime.now().add(Duration(days: 1));
    _numberOfNights = 1;
    _calculateCost();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  void _calculateCost() {
    // Calculate the number of nights stayed
    _numberOfNights = _selectedEndDate.difference(_selectedStartDate).inDays;

    // Calculate the total cost based on the number of nights and cost per night
    _totalCost = _numberOfNights * widget.costPerNight.toDouble();
  }

  List<Widget> _buildRatingStars(int rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      IconData iconData = i < rating ? Icons.star : Icons.star_border;
      Color color = i < rating ? Colors.amber : Colors.grey;
      stars.add(
        Icon(
          iconData,
          color: color,
        ),
      );
    }
    return stars;
  }

  void _navigateToRoomSelectionPage() {
    String userName = _nameController.text;
    String userEmail = _emailController.text;
    String userPhone = _phoneController.text;
    // Calculate the number of nights
    int numberOfNights = _selectedEndDate.difference(_selectedStartDate).inDays;

    // Navigate to the room selection page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomSelectionPage(
          hotelid: widget.hotelid,
          hotelName: widget.hotelName,
          rating: widget.rating,
          location: widget.location,
          checkInTime: widget.checkInTime,
          checkOutTime: widget.checkOutTime,
          numberOfNights: numberOfNights,
          checkInDate: _selectedStartDate, // Pass the selected start date
          checkOutDate: _selectedEndDate,
          costPerNight: widget.costPerNight,
          
          // userName: userName,
          // userEmail: userEmail,
          // userPhone: userPhone,
        ),
      ),
    );
  }

  void _toggleStartDatePicker() {
    setState(() {
      _showStartDatePicker = !_showStartDatePicker;
    });
  }

  void _toggleEndDatePicker() {
    setState(() {
      _showEndDatePicker = !_showEndDatePicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(223, 238, 240, 239),
        //title: Text('Book ${widget.hotelName}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    widget.hotelName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildRatingStars(widget.rating),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(height: 2, thickness: 2, color: Colors.grey),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Check In: ${widget.checkInTime}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Text(
                  'Check Out: ${widget.checkOutTime}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: _toggleStartDatePicker,
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    side: BorderSide(width: 2, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(Icons.calendar_today),
                  label: Text(
                    'Start Date',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _toggleEndDatePicker,
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    side: BorderSide(width: 2, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(Icons.calendar_today),
                  label: Text(
                    'End Date',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            if (_showStartDatePicker)
              TableCalendar(
                focusedDay: _selectedStartDate,
                firstDay: DateTime.now().subtract(Duration(days: 365)),
                lastDay: DateTime.now().add(Duration(days: 365)),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedStartDate = selectedDay;
                    _toggleStartDatePicker();
                    _calculateCost();
                  });
                },
              ),
            if (_showEndDatePicker)
              TableCalendar(
                focusedDay: _selectedEndDate,
                firstDay: DateTime.now().subtract(Duration(days: 365)),
                lastDay: DateTime.now().add(Duration(days: 365)),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedEndDate = selectedDay;
                    _toggleEndDatePicker();
                    _calculateCost();
                  });
                },
              ),
            SizedBox(height: 20),
            Text(
              'Selected Dates : $_numberOfNights Nights',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
                decorationColor: Colors.blue,
                decorationThickness: 2,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amenities',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.pool),
                            ),
                            SizedBox(height: 5),
                            Text('Swimming Pool'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.spa),
                            ),
                            SizedBox(height: 5),
                            Text('Spa'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.restaurant),
                            ),
                            SizedBox(height: 5),
                            Text('Restaurant'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.sports),
                            ),
                            SizedBox(height: 5),
                            Text('Indoor Games'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.room_service),
                            ),
                            SizedBox(height: 5),
                            Text('24 hr Room Service'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.local_cafe),
                            ),
                            SizedBox(height: 5),
                            Text('Coffee Shop'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.videocam),
                            ),
                            SizedBox(height: 5),
                            Text('CCTV'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.sports_bar),
                            ),
                            SizedBox(height: 5),
                            Text('Bar'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.menu_book),
                            ),
                            SizedBox(height: 5),
                            Text('Library'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Property Rules',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Check-in: ${widget.checkInTime}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Check-out: ${widget.checkOutTime}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Unmarried couples with local IDs are allowed',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 5),
                    Text(
                      '• Pets are not allowed',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '• Outside food is not allowed',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '• Allows private parties',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '• Food delivery available',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.grey.shade800,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Cost: ₹$_totalCost',
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: () => _navigateToRoomSelectionPage(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Select Room',
                    style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}