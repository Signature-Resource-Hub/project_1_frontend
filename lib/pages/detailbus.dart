
// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/pages/pickupanddrop.dart';

// class BusDetailsPage extends StatelessWidget {
//   final dynamic bus;
//   // final String userId; // New field for userId
//   final String busId; // New field for busId

//   BusDetailsPage({required this.bus, required this.busId});

//   // Define a map that maps field names to custom titles
//   final Map<String, String> fieldTitles = {
//     "_id": "Bus Id", // Displayed busId here
//     "busName": "Bus Name",
//     "busFrom": "From",
//     "busTo": "To",
//     "startTime": "Start Time",
//     "endTime": "End Time",
//     "cost": "Cost",
//     "noOfSeats": "Number of Seats",
//     "acNonAc": "AC/Non-AC",
//     "busType": "Bus Type",
//     "busId": "Bus Id", // Add busId mapping here
//     // Add more mappings for other fields if needed
//   };

//   // Define a map that maps field names to corresponding icons
//   final Map<String, IconData> fieldIcons = {
//     "busName": Icons.directions_bus,
//     "busFrom": Icons.location_on,
//     "busTo": Icons.location_on_outlined,
//     "startTime": Icons.schedule,
//     "endTime": Icons.schedule,
//     "cost": Icons.currency_rupee,
//     "noOfSeats": Icons.airline_seat_flat,
//     "acNonAc": Icons.ac_unit,
//     "busType": Icons.airline_seat_recline_normal,
//     "busId": Icons.confirmation_number, // Add busId icon
//     // Add more mappings for other fields if needed
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
//         // title: Text(bus["busName"]), // Display the busName as the title
//       ),
//       body: Card(
//         margin: EdgeInsets.all(16),
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               for (String fieldName in bus.keys)
//                 if (!["availableDate", "pickupPoints", "dropPoints"].contains(fieldName)) // Exclude specified fields
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (fieldIcons.containsKey(fieldName))
//                         Icon(
//                           fieldIcons[fieldName],
//                           size: 24,
//                           color: Colors.blue,
//                         ),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           '${fieldTitles[fieldName]}: ${bus[fieldName]}',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ],
//                   ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   print("Bus Id: ${bus['_id']}"); // Debugging statement
//                   print("User Id: ${bus['userId']}"); // Debugging statement

//                   // Convert pickupPoints and dropPoints to the correct type
//                   List<Map<String, String>> pickupPointsList = [];
//                   List<Map<String, String>> dropPointsList = [];
//                   for (var point in bus['pickupPoints']) {
//                     pickupPointsList.add({
//                       'name': point['name'],
//                       'time': point['time'],
//                     });
//                   }
//                   for (var point in bus['dropPoints']) {
//                     dropPointsList.add({
//                       'name': point['name'],
//                       'time': point['time'],
//                     });
//                   }
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PickupDropPointsPage(
//                         pickupPoints: pickupPointsList,
//                         dropPoints: dropPointsList,
//                         cost: bus['cost'],
//                         busName: bus['busName'],
//                         busFrom: bus['busFrom'],
//                         busTo: bus['busTo'],
//                         startTime: bus['startTime'],
//                         endTime: bus['endTime'],
//                         noOfSeats: bus['noOfSeats'],
//                         acNonAc: bus['acNonAc'],
//                         busType: bus['busType'],
//                         userId: '6609ad6e41529c575ef27e1b', // Pass userId
//                         busId: bus['_id'], // Pass busId
//                       ),
//                     ),
//                   );
//                 },
//                 child: Text('View Pickup & Drop Points'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/pickupanddrop.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BusDetailsPage extends StatelessWidget {
  final dynamic bus;
  final String busId;
  final storage = FlutterSecureStorage(); // Initialize secure storage

  BusDetailsPage({required this.bus, required this.busId});

  final Map<String, String> fieldTitles = {
    "_id": "Bus Id",
    "busName": "Bus Name",
    "busFrom": "From",
    "busTo": "To",
    "startTime": "Start Time",
    "endTime": "End Time",
    "cost": "Cost",
    "noOfSeats": "Number of Seats",
    "acNonAc": "AC/Non-AC",
    "busType": "Bus Type",
    "busId": "Bus Id",
  };

  final Map<String, IconData> fieldIcons = {
    "busName": Icons.directions_bus,
    "busFrom": Icons.location_on,
    "busTo": Icons.location_on_outlined,
    "startTime": Icons.schedule,
    "endTime": Icons.schedule,
    "cost": Icons.currency_rupee,
    "noOfSeats": Icons.airline_seat_flat,
    "acNonAc": Icons.ac_unit,
    "busType": Icons.airline_seat_recline_normal,
    "busId": Icons.confirmation_number,
  };

 Future<String> getUserId() async {
  Map<String, String>? allValues = await storage.readAll();
  if (allValues == null || allValues["token"] == null) {
    // Handle the case where storage data is not available or token is missing
    throw Exception("Token not found in storage");
  }

  String normalizedSource =
      base64Url.normalize(allValues["token"]!.split(".")[1]);
  print(normalizedSource);
  return json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (String fieldName in bus.keys)
                if (!["availableDate", "pickupPoints", "dropPoints"]
                    .contains(fieldName))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (fieldIcons.containsKey(fieldName))
                        Icon(
                          fieldIcons[fieldName],
                          size: 24,
                          color: Colors.blue,
                        ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${fieldTitles[fieldName]}: ${bus[fieldName]}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String userId = await getUserId(); // Fetch user ID
                  print("Bus Id: ${bus['_id']}");
                  print("User Id: $userId"); // Print fetched user ID

                  List<Map<String, String>> pickupPointsList = [];
                  List<Map<String, String>> dropPointsList = [];
                  for (var point in bus['pickupPoints']) {
                    pickupPointsList.add({
                      'name': point['name'],
                      'time': point['time'],
                    });
                  }
                  for (var point in bus['dropPoints']) {
                    dropPointsList.add({
                      'name': point['name'],
                      'time': point['time'],
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PickupDropPointsPage(
                        pickupPoints: pickupPointsList,
                        dropPoints: dropPointsList,
                        cost: bus['cost'],
                        busName: bus['busName'],
                        busFrom: bus['busFrom'],
                        busTo: bus['busTo'],
                        startTime: bus['startTime'],
                        endTime: bus['endTime'],
                        noOfSeats: bus['noOfSeats'],
                        acNonAc: bus['acNonAc'],
                        busType: bus['busType'],
                        userId: userId, // Use fetched user ID
                        busId: bus['_id'],
                      ),
                    ),
                  );
                },
                child: Text('View Pickup & Drop Points'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
