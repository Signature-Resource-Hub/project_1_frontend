// import 'package:flutter/material.dart';

// class guidedetails extends StatelessWidget {
//   final dynamic content;

//   guidedetails({required this.content});

//   // Define a map that maps field names to custom titles
//   final Map<String, String> fieldTitles = {
    
//     "contents":"contents"
//     // Add more mappings for other fields if needed
//   };

//   // Define a map that maps field names to corresponding icons
//   final Map<String, IconData> fieldIcons = {
    
//     "contents": Icons.content_cut_sharp,
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
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (fieldIcons.containsKey("fieldName"))
//                         Icon(
//                           fieldIcons[""],
//                           size: 24,
//                           color: Colors.blue,
//                         ),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           '${content}',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ],
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class guidedetails extends StatelessWidget {
  final dynamic content;

  guidedetails({required this.content});

  // Define a map that maps field names to custom titles
  final Map<String, String> fieldTitles = {
    "contents": "Contents",
    // Add more mappings for other fields if needed
  };

  // Define a map that maps field names to corresponding icons
  final Map<String, IconData> fieldIcons = {
    "contents": Icons.content_cut_sharp,
    // Add more mappings for other fields if needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),        title: Text(
          'Guide Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var field in fieldTitles.keys)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (fieldIcons.containsKey(field))
                            Icon(
                              fieldIcons[field],
                              size: 24,
                              color: Colors.blue, // Updated icon color
                            ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${fieldTitles[field]}:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${content}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
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
      ),
    );
  }
}
