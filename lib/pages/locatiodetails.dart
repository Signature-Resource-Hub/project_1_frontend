// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/model/postprd.dart';
// import 'package:project_1_frontend/pages/detailbus.dart';

// class LocationDetails extends StatelessWidget {
//   final List<dynamic> buses;

//   LocationDetails({required this.buses});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//                 backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),

//         title: Text('Bus Details'),
//       ),
//       // body: ListView.builder(
//       //   itemCount: buses.length,
//       //   itemBuilder: (context, index) {
//       //     // Build each list item using the bus data

//       //     return ListTile(
//       //       title: Text(buses[index]["busName"]),
//       //       subtitle: Text('From: ${buses[index].busFrom}, To: ${buses[index].busTo}\nType: ${buses[index].busType}\nAC/Non-AC: ${buses[index].acNonAc}\nCost: ${buses[index].cost}'),
//       //       // Add more details as needed
//       //     );
//       //   },
//       // ),
//    body: ListView.builder(
//         itemCount: buses.length,
//         itemBuilder: (context, index) {
//           // Build each list item using the bus data
//           return GestureDetector(
//             onTap: () {
//               // Navigate to the next page when the bus item is tapped
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BusDetailsPage(bus: buses[index]),
//                 ),
//               );
//             },
//             child: Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         buses[index]["busName"],
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       Icon(Icons.arrow_forward, color: Colors.blue),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.attach_money, color: Colors.blue),
//                       SizedBox(width: 4),
//                       Text('Cost: ${buses[index]["cost"]}', style: TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/detailbus.dart'; // Assuming detailbus.dart is renamed to BusDetailsPage.dart

class LocationDetails extends StatelessWidget {
  final List<dynamic> buses;
  // final String userId; // New field for userId
  final String busId;//  // New field for busId

  LocationDetails({
    required this.buses,
    // required this.userId,
    required this.busId,
  });

  @override
  Widget build(BuildContext context) {
    // Code to remove duplicate buses with non-null cost
    List<dynamic> uniqueBuses = [];
    for (var i = 0; i < buses.length; i++) {
      bool isDuplicate = false;
      for (var j = 0; j < uniqueBuses.length; j++) {
        if (buses[i]['busName'] == uniqueBuses[j]['busName'] &&
            buses[i]['cost'] == uniqueBuses[j]['cost']) {
          isDuplicate = true;
          break;
        }
      }
      if (!isDuplicate && buses[i]['cost'] != null) {
        uniqueBuses.add(buses[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
        title: Text('Bus Details'),
      ),
      body: ListView.builder(
        itemCount: uniqueBuses.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to BusDetailsPage on tap, passing data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusDetailsPage(
                    bus: uniqueBuses[index],
                    // userId: userId,
                    // busId: uniqueBuses[index]['id'], 
                    busId: uniqueBuses[index]['id'] ?? '', // Pass userId from LocationDetails
// Pass userId from LocationDetails
                    // busId: busId,  // Pass busId from LocationDetails
                  ),
                ),
              );
            },
            child: Container(
              // Container styling and decoration
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for bus name and forward icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        uniqueBuses[index]["busName"],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.blue),
                    ],
                  ),
                  // Row for currency symbol and cost
                  Row(
                    children: [
                      Icon(Icons.currency_rupee, color: Colors.blue),
                      SizedBox(width: 4),
                      Text('${uniqueBuses[index]["cost"]}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
