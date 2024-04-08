import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_1_frontend/model/postprd.dart';
import 'package:project_1_frontend/services/authservice.dart';

class TravelListPage extends StatefulWidget {
  const TravelListPage({Key? key}) : super(key: key);

  @override
  State<TravelListPage> createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  Future<List<Bus>>? data;

  @override
  void initState() {
    super.initState();
    // Call fetchBusData when the page is initialized
    fetchBusData();
  }

  Future<void> fetchBusData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String busFrom = prefs.getString('busFrom') ?? '';
      final String busTo = prefs.getString('busTo') ?? '';
      final String acNonAc = prefs.getString('acNonAc') ?? '';
      final double cost = prefs.getDouble('cost') ?? 0.0;
      final String busType = prefs.getString('busType') ?? '';
      print('busFrom: $busFrom');
    print('busTo: $busTo');
    print('acNonAc: $acNonAc');
    print('cost: $cost');
    print('busType: $busType');

      setState(() {
        data = PostApiService().getBus(busFrom, busTo, acNonAc, cost, busType);
      });
    } catch (e) {
      print("Error fetching bus data: $e");
      setState(() {
        data = Future.value([]); // Set data to an empty future in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel List',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),

      ),
body: FutureBuilder<List<Bus>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No buses found for the given criteria'));
        } else {
          // Group buses by their unique combination of start time and end time
          Map<String, Bus> busesByTime = {};
          for (var bus in snapshot.data!) {
            String timeCombination = '${bus.startTime}-${bus.endTime}';
            if (!busesByTime.containsKey(timeCombination)) {
              busesByTime[timeCombination] = bus;
            }
          }

          // Display the list of buses
    return ListView(
  children: busesByTime.values.map((bus) {
    return Card( // Wrap the ListTile with a Card to set a background color
      color: const Color.fromARGB(255, 177, 220, 241).withOpacity(.7), // Set the background color of the Card
      child: ListTile(
        title: Text('BUS NAME: ${bus.busName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('START TIME: ${bus.startTime}'),
            Text('END TIME: ${bus.endTime}'),
            Text('BUS From: ${bus.busFrom} - To: ${bus.busTo}'),
            Text('AC OR NON: ${bus.acNonAc}'),
            Text('BUS TYPE: ${bus.busType}'),
            Text('BUS COST: ${bus.cost}'),
            Text('NUMBER OF SEATS: ${bus.noOfSeats}'),
          ],
        ),
      ),
    );
  }).toList(),
);
        }
      },
    ),
  );
}
}
