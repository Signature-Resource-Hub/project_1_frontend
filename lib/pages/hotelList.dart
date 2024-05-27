import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_1_frontend/models/post.dart';
import 'package:project_1_frontend/services/updateservice.dart';
import 'package:project_1_frontend/services/configu.dart';
import 'package:http/http.dart' as http;
class hotelListPage extends StatefulWidget {
  const hotelListPage({Key? key}) : super(key: key);

  @override
  State<hotelListPage> createState() => _hotelListPageState();
}

class _hotelListPageState extends State<hotelListPage> {
  List<dynamic>_data=[];
  

  @override
  void initState() {
    super.initState();
    // Call fetchHotelData when the page is initialized
    fetchHotelData();
  }
Config config = Config();
Dio dio=Dio();
  Future<void> fetchHotelData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String location = prefs.getString('location') ?? '';
      
      final String acNonAc = prefs.getString('acNonAc') ?? '';
      final double cost = prefs.getDouble('cost') ?? 0.0;

    final apiUrl = Uri.parse(config.hotelflaskUrl); // Use flaskUrl from Config
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "location": location,
      "acNonAc": acNonAc,
      "cost": double.parse(cost.toString()),
    });

    final response = await dio.post("http://10.0.2.2:5000//predict", data: body);
    print(response.data);
    setState(() {
      _data=response.data;
    });

      
      

      // setState(() {
      //   data = PostApiService().getHotel(location,  acNonAc, cost);
      //   print("in data");
      //   print(data);
      // });
    } catch (e) {
      print("Error fetching hotel data: $e");
      // setState(() {
      //   data = Future.value([]); // Set data to an empty future in case of error
      // });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
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

}