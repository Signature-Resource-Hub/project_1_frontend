

// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/pages/hotbook.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:project_1_frontend/models/post.dart';
// import 'package:project_1_frontend/services/updateservice.dart';

// class TravelListPage extends StatefulWidget {
//   const TravelListPage({Key? key}) : super(key: key);

//   @override
//   State<TravelListPage> createState() => _TravelListPageState();
// }

// class _TravelListPageState extends State<TravelListPage> {
//   Future<List<Hotel>>? data;
//   double? userCost; // Input cost provided by the user

//   @override
//   void initState() {
//     super.initState();
//     SharedPreferences.getInstance().then((prefs) {
//       final String location = prefs.getString('location') ?? '';
//       final String acNonAc = prefs.getString('acNonAc') ?? '';
//       final double cost = prefs.getDouble('cost') ?? 0.0;

//       userCost = cost; // Storing user's input cost

//       data = PostApiService().getHotel(location, acNonAc, cost);
//       setState(() {});
//     });
//   }

//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Hotel List'),
//       backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4), // Set app bar background color
//     ),
//     body: FutureBuilder<List<Hotel>>(
//       future: data,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error fetching data'));
//         } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//           return Center(child: Text('No data available'));
//         } else {
//           final uniqueHotels = _getUniqueHotels(snapshot.data!);
//           return ListView.builder(
//             itemCount: uniqueHotels.length,
//             itemBuilder: (context, index) {
//               Hotel hotel = uniqueHotels[index];
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Add space around ListTile
//                 child: Card(
//                   elevation: 2,
//                   child: InkWell(
//                     onTap: () {
//                       // Navigate to another page when ListTile is tapped
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => HotbookPage(),
//                         ),
//                       );
//                     },
//                     child: ListTile(
//                       title: Text(
//                         'Hotel Name: ${hotel.hotelname}',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('AC/NON-AC: ${hotel.acNonAc}'),
//                           Text('COST: ${hotel.cost}'),
//                           Text('LOCATION: ${hotel.location}'),
//                           Text('AVAILABILITY: ${hotel.availability}'),
//                           Text('No. Of Persons: ${hotel.numberOfPersons}'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     ),
//   );
// }


//   List<Hotel> _getUniqueHotels(List<Hotel> hotels) {
//     List<Hotel> uniqueHotels = [];
//     for (var hotel in hotels) {
//       if (hotel.availability.toUpperCase() == 'YES') {
//         bool isUnique = true;
        
//         if (userCost != null && hotel.cost > userCost!) {
//           isUnique = false;
//         }
        
//         if (isUnique) {
//           for (var uniqueHotel in uniqueHotels) {
//             if (hotel.cost == uniqueHotel.cost) {
//               isUnique = false;
//               break;
//             }
//           }
//         }
//         if (isUnique) {
//           uniqueHotels.add(hotel);
//         }
//       }
//     }
//     return uniqueHotels;
//   }
// }

import 'package:flutter/material.dart';
import 'package:project_1_frontend/pages/hotbook.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_1_frontend/models/post.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_1_frontend/services/updateservice.dart';

class TravelListPage extends StatefulWidget {
  const TravelListPage({Key? key}) : super(key: key);

  @override
  State<TravelListPage> createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  Future<List<Hotel>>? data;
  double? userCost; // Input cost provided by the user

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final String location = prefs.getString('location') ?? '';
      final String acNonAc = prefs.getString('acNonAc') ?? '';
      final double cost = prefs.getDouble('cost') ?? 0.0;

      userCost = cost; // Storing user's input cost

      data = PostApiService().getHotel(location, acNonAc, cost);
      setState(() {});
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(

      title: Text(
        'Hotel List',
        style: TextStyle(
          fontFamily: 'Montserrat', // Example of using a custom font
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue, // Set app bar background color
    ),
    body: FutureBuilder<List<Hotel>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final uniqueHotels = _getUniqueHotels(snapshot.data!);
          return ListView.builder(
            itemCount: uniqueHotels.length,
            itemBuilder: (context, index) {
              Hotel hotel = uniqueHotels[index];
              return Padding( 
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Add space around ListTile
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners for card
                  ),
                  child: InkWell(
                    onTap: () {
                      //Navigate to another page when ListTile is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelBookingPage(
                            hotelid: hotel.id,
                            hotelName: hotel.hotelname,
                            costPerNight: hotel.cost,
                            location: hotel.location,
                            checkInTime: hotel.checkInTime,
                            checkOutTime: hotel.checkOutTime,
                            rating: hotel.rating,
                          ),
                        ),
                      );

                    },
                    child: ListTile(
                      title: Text(
                        'Hotel Name: ${hotel.hotelname}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text('AC/NON-AC: ${hotel.acNonAc}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('COST: ${hotel.cost}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('LOCATION: ${hotel.location}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('AVAILABILITY: ${hotel.availability}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('No. Of Persons: ${hotel.numberOfPersons}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('Check In Time:${hotel.checkInTime}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('Check Out Time:${hotel.checkOutTime}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          RatingBar.builder(
                            initialRating: hotel.rating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    ),

                        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),

      title: Text('Hotel List'),
    ),
body: ListView.builder(
  itemCount: _data.length,
  itemBuilder: (context, index) {
    // Check if this hotel is unique based on name and location
    bool isUnique = true;
    for (int i = 0; i < index; i++) {
      if (_data[i]["hotelname"] == _data[index]["hotelname"] &&
          _data[i]["location"] == _data[index]["location"]) {
        isUnique = false;
        break;
      }
    }

    // If it's unique, display it
    if (isUnique) {
      return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _data[index]["hotelname"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              "AC/Non-AC: ${_data[index]["acNonAc"]}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Cost: ${_data[index]["cost"]}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Location: ${_data[index]["location"]}",
              style: TextStyle(fontSize: 16),
            ),
               Text(
              "Availability: ${_data[index]["availability"]}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Number of Persons: ${_data[index]["numberOfPersons"]}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else {
      // If not unique, return an empty container
      return Container();
    }
  },
),

  );
}


  List<Hotel> _getUniqueHotels(List<Hotel> hotels) {
    List<Hotel> uniqueHotels = [];
    for (var hotel in hotels) {
      if (hotel.availability.toUpperCase() == 'YES') {
        bool isUnique = true;
        
        if (userCost != null && hotel.cost > userCost!) {
          isUnique = false;
        }
        
        if (isUnique) {
          for (var uniqueHotel in uniqueHotels) {
            if (hotel.cost == uniqueHotel.cost) {
              isUnique = false;
              break;
            }
          }
        }
        if (isUnique) {
          uniqueHotels.add(hotel);
        }
      }
    }
    return uniqueHotels;
  }
}
