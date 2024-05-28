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
  double? userCost; // Input cost provided by the user

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final String busFrom = prefs.getString('busFrom') ?? '';
      final String busTo = prefs.getString('busTo') ?? '';
      final String acNonAc = prefs.getString('acNonAc') ?? '';
      final double cost = prefs.getDouble('cost') ?? 0.0;
      final String busType = prefs.getString('busType') ?? '';

      userCost = cost; // Storing user's input cost

      data = PostApiService().getBus(busFrom, busTo, acNonAc, cost, busType);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Travel List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(0.4),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Bus>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Travels not found.'));
          } else {
            final uniqueBuses = _getUniqueBuses(snapshot.data!);
            if (uniqueBuses.isEmpty) {
              return Center(child: Text('Travels not found.'));
            }
            return ListView.builder(
              itemCount: uniqueBuses.length,
              itemBuilder: (context, index) {
                Bus bus = uniqueBuses[index];
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BUS NAME: ${bus.busName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('START TIME: ${bus.startTime}'),
                        Text('END TIME: ${bus.endTime}'),
                        Text(
                            'BUS FROM: ${bus.busFrom} - To: ${bus.busTo}'),
                        Text('AC/NON-AC: ${bus.acNonAc}'),
                        Text('BUS TYPE: ${bus.busType}'),
                        Text('COST: ${bus.cost}'),
                        Text('NUMBER OF SEATS: ${bus.noOfSeats}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  List<Bus> _getUniqueBuses(List<Bus> buses) {
    List<Bus> uniqueBuses = [];
    for (var bus in buses) {
      bool isUnique = true;
      if (userCost != null && bus.cost > userCost!) {
        isUnique = false;
      }
      if (isUnique) {
        for (var uniqueBus in uniqueBuses) {
          if (bus.startTime == uniqueBus.startTime &&
              bus.endTime == uniqueBus.endTime &&
              bus.busFrom == uniqueBus.busFrom &&
              bus.busTo == uniqueBus.busTo &&
              bus.acNonAc == uniqueBus.acNonAc &&
              bus.busType == uniqueBus.busType &&
              bus.cost == uniqueBus.cost &&
              bus.noOfSeats == uniqueBus.noOfSeats) {
            isUnique = false;
            break;
          }
        }
      }
      if (isUnique) {
        uniqueBuses.add(bus);
      }
    }
    return uniqueBuses;
  }
}


