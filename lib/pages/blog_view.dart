// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/models/blogs.dart';

// class BlogDetailsPage extends StatelessWidget {
//   final dynamic content;
//   final DateTime timestamp; // Add DateTime parameter for the timestamp

//   BlogDetailsPage({required this.content, required this.timestamp}); // Modify the constructor

//   // Define a map that maps field names to custom titles
//   final Map<String, String> fieldTitles = {
//     "contents": "contents",
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
//         backgroundColor: Colors.lightBlueAccent,
//         // You can set the title here if needed
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (fieldIcons.containsKey("contents"))
//                       Icon(
//                         fieldIcons["contents"],
//                         size: 24,
//                         color: Colors.blue,
//                       ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         '${content}',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                           fontStyle: FontStyle.italic, // Make the text italicized
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//                // Add some space between content and timestamp
//               Row(
//                 children: [
//                   Icon(
//                     Icons.access_time,
//                     size: 20,
//                     color: Colors.grey,
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'Posted at: ',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                   Text(
//                     '${timestamp}',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:project_1_frontend/models/blogs.dart';
import 'package:intl/intl.dart';

class BlogDetailsPage extends StatelessWidget {
  final String username;
  final String location;
  final String content;
  final DateTime timestamp;

  BlogDetailsPage({
    required this.username,
    required this.location,
    required this.content,
    required this.timestamp,
  });

  final Map<String, String> fieldTitles = {
    "content": "Content",
  };

  final Map<String, IconData> fieldIcons = {
    "content": Icons.content_cut_sharp,
  };

  @override
  Widget build(BuildContext context) {
    String formattedTimestamp = DateFormat('dd MMM yyyy, hh:mm a').format(timestamp);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Blog Details', style: TextStyle(fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Blogger: $username',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Location: $location',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (fieldIcons.containsKey("content"))
                      Icon(
                        fieldIcons["content"],
                        size: 24,
                        color: Colors.blue,
                      ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 20,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Posted at: ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    formattedTimestamp,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
