import 'package:flutter/material.dart';
import 'package:project_1_frontend/widgets/text_box.dart';
import 'package:project_1_frontend/widgets/text_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.red,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              iconTheme: IconThemeData(color: Colors.white)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button background color
              padding: const EdgeInsets.all(10.0),
              textStyle: const TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8.0), // Button border radius
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.red, size: 25)),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController _controller = TextEditingController();
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length <= 2) {
      return 'Please enter a valid name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: ListView(
        children: [
          const HeadingText(
              text: "Demo Heading", align: TextAlign.left, color: Colors.black),
          const SubHeadingText(
              text: "Demo Sub heading",
              align: TextAlign.left,
              color: Colors.black),
          const DescriptionText(
              text: "Demo description text",
              align: TextAlign.left,
              color: Colors.black),
          CustomTextBox(
            controller: _controller,
            labelText: "Full name",
            keyboardType: TextInputType.name,
            prefixIcon: Icons.person,
            validator: _validateName,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          ElevatedButton(
              onPressed: () {},
              child: const SubHeadingText(
                  text: "Demo Button",
                  align: TextAlign.left,
                  color: Colors.white)),
          Icon(Icons.notifications)
        ],
      ),
    );
  }
}
