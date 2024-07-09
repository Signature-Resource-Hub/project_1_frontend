
// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/models/guidemodel.dart';
// import 'package:project_1_frontend/pages/guide/guidedetails.dart';
// import 'package:project_1_frontend/services/guideservice.dart';

// class GuidePage extends StatefulWidget {
//   @override
//   _GuidePageState createState() => _GuidePageState();
// }

// class _GuidePageState extends State<GuidePage> {
//   late Future<List<Guide>> data;

//   @override
//   void initState() {
//     super.initState();
//     // data = GuideService().getGuides();
//     data = GuideService.getGuides();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
//           title: Text('Guide List'),
//         ),
//         body: FutureBuilder<List<Guide>>(
//           future: data,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               print(1);
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               print(2);
//               print(snapshot);
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//               print(3);
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   Guide guide = snapshot.data![index];
//                   return GestureDetector(
//                     onTap: () {

//                       Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => guidedetails(content: guide.contents)
//                 ),
//               );
//                       // Handle onTap action here
//                       // For example, you can navigate to a detail page
//                       // or perform any other action
//                       print('Tapped on Guide ID: ${guide.id}');
//                     },
//                     child: Card(
//                       child: ListTile(
//                         title: Text("Guide ID: ${guide.id}"),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Guide Name: ${guide.userid.username}"),
//                             Text("Star: ${guide.star}"),
//                             Text("Timestamp: ${guide.timestamp}"),
//                             // Add more details as needed
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text('No guides found.'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:project_1_frontend/model/guidereview.dart';
import 'package:project_1_frontend/models/guidemodel.dart';
import 'package:project_1_frontend/pages/guide/guidedetails.dart';
import 'package:project_1_frontend/pages/guide/userguidereviews.dart';
import 'package:project_1_frontend/services/guideservice.dart';

class GuidePage extends StatefulWidget {
  final List<dynamic>? travelGuide;

  GuidePage({Key? key, this.travelGuide}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  late Future<List<Guide>> data;

  @override
  void initState() {
    super.initState();
    // Fetch guide data when the page initializes
    data = GuideService.getGuides();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),          title: Text(
            'Guide List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat', // Custom font
            ),
          ),
          centerTitle: true, // Center align the title
        ),
        body: FutureBuilder<List<Guide>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while data is being fetched
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Show an error message if data fetching fails
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // Render the guide list if data is available
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Guide guide = snapshot.data![index];
                  final guideid=guide.userid.id;
                  return GestureDetector(
                    onTap: () {
                      // Navigate to guide details page when tapped
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => guidedetails(content: guide.contents),
                      //   ),
                      // );
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userguidereviews( guideId: guideid),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4, // Add elevation for a card-like appearance
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add margin around each card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners for the card
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        // title: Text(
                        //   "Guide ID: ${guide.userid.id}",
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold, // Make guide ID bold
                        //     fontFamily: 'Montserrat', // Custom font
                        //     color: Colors.blueAccent, // Text color
                        //   ),
                        // ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text("Guide Name: ${guide.userid.username}",
                            style: TextStyle(
                            fontWeight: FontWeight.bold, // Make guide ID bold
                            fontFamily: 'Montserrat', // Custom font
                            color: Colors.blueAccent, // Text color
                          ),
                            
                            ),
                            SizedBox(width: 4),

                            Text("Location: ${guide.location}"),

                            SizedBox(height: 4),
                            Row(
                              children: [
                                // SizedBox(width: 4),
                                SizedBox(width: 4),
                                Icon(Icons.star, color: Colors.amber), // Star icon for rating
                                SizedBox(width: 4),

                                Text("Star: ${guide.star}", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 4),
                            // Text("Timestamp: ${guide.timestamp}"),
                            Text("Contents: ${guide.contents}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              // Show a message when no guides are found
              return Center(child: Text('No guides found.'));
            }
          },
        ),
      ),
    );
  }
}
