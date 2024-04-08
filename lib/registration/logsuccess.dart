import 'package:flutter/material.dart';
import 'package:project_1_frontend/registration/AddBusPage.dart';

class loginsuccess extends StatefulWidget {
  const loginsuccess({super.key});

  @override
  State<loginsuccess> createState() => _loginsuccessState();
}

class _loginsuccessState extends State<loginsuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),  
          title: Row(
            children: [
              SizedBox(height: 30,),
              GestureDetector(               
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) =>Profile()),
                  // );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://i.pinimg.com/736x/1e/2f/28/1e2f28c0537debcf003afc48375d2775.jpg'), // Replace 'https://example.com/profile_image.jpg' with your image URL
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Dorothy Dix',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Where do you want to go?',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications,size: 30,),
              onPressed: () {              
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Row(
              children: [
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {                 
                  },
                ),
                SizedBox(width: 10),
                Text(
                  'Stanza Living',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Destinations',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See all',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 250,),
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ElevatedButton(
      onPressed: () {
      //  Navigator.push(
    //   context,
    //   // MaterialPageRoute(builder: (context) => AddHotelPage()),
    // );
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
      ),
      child: Text(
        'Hotels',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    ElevatedButton(
      onPressed: () {
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBusPage()),
    );
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 62, 238, 241).withOpacity(.4),
      ),
      child: Text(
        'Buses',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ],
),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommendations for You',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See all',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}