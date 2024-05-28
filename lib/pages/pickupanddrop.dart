
import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/reviewbooking.dart';

class PickupDropPointsPage extends StatefulWidget {
  final List<Map<String, String>> pickupPoints;
  final List<Map<String, String>> dropPoints;
  final int cost;
  final String busName;
  final String busFrom;
  final String busTo;
  final String startTime;
  final String endTime;
  final int noOfSeats;
  final String acNonAc;
  final String busType;
  // final String userId; // Add userId parameter
  // final String busId; 
  final String userId; // Add userId parameter
  final String busId;

  PickupDropPointsPage({
    required this.busName,
    required this.busFrom,
    required this.busTo,
    required this.startTime,
    required this.endTime,
    required this.noOfSeats,
    required this.acNonAc,
    required this.busType,
    required this.pickupPoints,
    required this.dropPoints,
    required this.cost,
    required this.userId,
    required this.busId, // Add busId parameter
  });

  @override
  _PickupDropPointsPageState createState() => _PickupDropPointsPageState();
}

class _PickupDropPointsPageState extends State<PickupDropPointsPage> {
  int? selectedPickupIndex;
  int? selectedDropIndex;
  int? selectedSeats;
  int totalCost = 0;
  bool isNextButtonEnabled = false;

  // Fields for traveler details
  List<TextEditingController> fullNameControllers = [];
  List<TextEditingController> ageControllers = [];
  List<String?> selectedGenders = [];

  @override
  void initState() {
    super.initState();
    // Initialize traveler detail fields based on the default number of seats
    initializeTravelerDetailFields(widget.noOfSeats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
        title: Text('Pickup and Drop Points'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//               Text(
//   'Bus ID: ${widget.busId}',
//   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// ),

// Text(
//               'Bus ID: ${widget.busId}', // Displaying bus ID passed from previous page
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),

              Text(
                'Pickup Points',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.pickupPoints.length,
                  (index) => RadioListTile<int>(
                    title: Text(widget.pickupPoints[index]['name']!),
                    subtitle: Text(widget.pickupPoints[index]['time']!),
                    value: index,
                    groupValue: selectedPickupIndex,
                    onChanged: (value) {
                      setState(() {
                        selectedPickupIndex = value;
                        updateNextButtonState();
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Drop Points',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.dropPoints.length,
                  (index) => RadioListTile<int>(
                    title: Text(widget.dropPoints[index]['name']!),
                    subtitle: Text(widget.dropPoints[index]['time']!),
                    value: index,
                    groupValue: selectedDropIndex,
                    onChanged: (value) {
                      setState(() {
                        selectedDropIndex = value;
                        updateNextButtonState();
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Number of Seats',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButton<int>(
                value: selectedSeats,
                onChanged: (value) {
                  setState(() {
                    selectedSeats = value;
                    // Update traveler detail fields when the number of seats changes
                    initializeTravelerDetailFields(value ?? 0);
                    updateNextButtonState();
                  });
                },
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Traveler Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                children: List.generate(
                  selectedSeats ?? 0,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: fullNameControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: ageControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Age',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedGenders[index],
                              onChanged: (value) {
                                setState(() {
                                  selectedGenders[index] = value;
                                  updateNextButtonState(); // Update next button state when gender is selected
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                border: InputBorder.none,
                              ),
                              items: ['Male', 'Female']
                                  .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cost: Rs. $totalCost'), // Display total cost in "Rs." format
              ElevatedButton(
                onPressed: isNextButtonEnabled ? () => navigateToNextPage(context) : null,
                child: Text('Next', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeTravelerDetailFields(int count) {
    fullNameControllers.clear();
    ageControllers.clear();
    selectedGenders.clear();
    for (int i = 0; i < count; i++) {
      fullNameControllers.add(TextEditingController());
      ageControllers.add(TextEditingController());
      selectedGenders.add(null);
    }
  }

  void updateNextButtonState() {
    setState(() {
      isNextButtonEnabled = selectedPickupIndex != null &&
          selectedDropIndex != null &&
          selectedSeats != null &&
          fullNameControllers.isNotEmpty && // Check if traveler details fields are not empty
          fullNameControllers.every((controller) => controller.text.isNotEmpty) && // Check if all full name fields are not empty
          ageControllers.isNotEmpty && // Check if traveler details fields are not empty
          ageControllers.every((controller) => controller.text.isNotEmpty) && // Check if all age fields are not empty
          selectedGenders.isNotEmpty && // Check if traveler details fields are not empty
          selectedGenders.every((gender) => gender != null); // Check if all gender fields are selected

      // Calculate total cost based on the number of seats
      totalCost = widget.cost * (selectedSeats ?? 0);
    });
  }

  void navigateToNextPage(BuildContext context) {
    if (isNextButtonEnabled) {
      // Capture selected pickup and drop points
      Map<String, String>? selectedPickupPoint = selectedPickupIndex != null
          ? widget.pickupPoints[selectedPickupIndex!]
          : null;

      Map<String, String>? selectedDropPoint = selectedDropIndex != null
          ? widget.dropPoints[selectedDropIndex!]
          : null;

      List<Map<String, dynamic>> travelers = [];
      for (int i = 0; i < selectedSeats!; i++) {
        travelers.add({
          'fullName': fullNameControllers[i].text,
          'age': int.tryParse(ageControllers[i].text) ?? 0, // Parse age with fallback to 0
          'gender': selectedGenders[i]!,
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewBookingPage(
            busName: widget.busName,
            busFrom: widget.busFrom,
            busTo: widget.busTo,
            startTime: widget.startTime,
            endTime: widget.endTime,
            selectedSeats: selectedSeats!,
            totalCost: totalCost,
            busType: widget.busType,
            selectedPickupPoint: selectedPickupPoint,
            selectedDropPoint: selectedDropPoint,
            travelers: travelers,
           
            userId: widget.userId, // Pass userId
          busId: widget.busId,
          ),
        ),
      );
    }
  }
}