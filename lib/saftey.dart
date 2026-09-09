import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Import Syncfusion Gauges
import 'bottom_navigator_bar.dart';

// Define Palette Colors
const Color kPrimaryColor = Color(0xFF2C6975);
const Color kSecondaryColor = Color(0xFF68B2A0);
const Color kAccentColor = Color(0xFFCDE0C9);
const Color kLightAccentColor = Color(0xFFE0ECDE);
const Color kBackgroundColor = Color(0xFFFFFFFF);

class DataIndexScreen extends StatefulWidget {
  const DataIndexScreen({super.key});

  @override
  _DataIndexScreenState createState() => _DataIndexScreenState();
}

class _DataIndexScreenState extends State<DataIndexScreen> {
  // Firebase reference
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference deviceCodeRef;

  double soilMoistureValue = 0.0;
  double temperatureValue = 0.0;
  double humidityValue = 0.0;
  double ldrValue = 25000.0;

  @override
  void initState() {
    super.initState();
    deviceCodeRef = database.ref().child('DataBase').child('real');
    retrieveData();
  }

  // Function to retrieve data dynamically from Firebase
  void retrieveData() {
    deviceCodeRef.child('Soil_Moisture').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          soilMoistureValue = double.tryParse(event.snapshot.value.toString()) ?? 0.0;
        });
      }
    });

    deviceCodeRef.child('Temperature').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          temperatureValue = double.tryParse(event.snapshot.value.toString()) ?? 0.0;
        });
      }
    });

    deviceCodeRef.child('Humidity').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          humidityValue = double.tryParse(event.snapshot.value.toString()) ?? 0.0;
        });
      }
    });

    deviceCodeRef.child('LDR').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          ldrValue = event.snapshot.value == 1 ? 45000.0 : 25000.0;
        });
      }
    });
  }

  // Method to determine the level based on value ranges
  String getLevel(String title, double value) {
    if (title == "Soil Moisture") {
      if (value < 200) return "Low";
      if (value < 400) return "Moderate";
      if (value < 600) return "High";
      return "Very High";
    } else if (title == "Temperature") {
      if (value < 20) return "Low";
      if (value < 28) return "Moderate";
      return "High";
    } else if (title == "Humidity") {
      if (value < 30) return "Low";
      if (value < 70) return "Moderate";
      return "High";
    } else if (title == "LDR") {
      if (value == 25000.0) return "Low";
      return "High";
    }
    return "Unknown";
  }

  // Method to build the indicator widgets for each variable
  Widget buildIndicator(
      String title, double value, double min, double max, List<GaugeRange> ranges) {
    return Column(
      children: [
        Text(
          '$title Indicator',
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: min,
              maximum: max,
              interval: (max - min) / 5,
              radiusFactor: 0.8,
              ranges: ranges,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: value,
                  needleLength: 0.7,
                  needleStartWidth: 3,
                  needleEndWidth: 8,
                ),
              ],
            )
          ],
        ),
        // Display the level below the gauge
        Text(
          getLevel(title, value),
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor, // Apply background color
      appBar: AppBar(
        backgroundColor: kPrimaryColor, // Apply primary color
        title: const Text("Real-time Data"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: kLightAccentColor, // Light accent as container background
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildIndicator("Soil Moisture", soilMoistureValue, 0, 1023, [
                GaugeRange(startValue: 0, endValue: 200, color: kPrimaryColor),
                GaugeRange(startValue: 200, endValue: 400, color: kSecondaryColor),
                GaugeRange(startValue: 400, endValue: 600, color: kAccentColor),
                GaugeRange(startValue: 600, endValue: 800, color: kLightAccentColor),
                GaugeRange(startValue: 800, endValue: 1023, color: kBackgroundColor),
              ]),
              buildIndicator("Temperature", temperatureValue, 0, 50, [
                GaugeRange(startValue: 0, endValue: 20, color: kPrimaryColor),
                GaugeRange(startValue: 20, endValue: 28, color: kSecondaryColor),
                GaugeRange(startValue: 28, endValue: 50, color: kAccentColor),
              ]),
              buildIndicator("Humidity", humidityValue, 0, 100, [
                GaugeRange(startValue: 0, endValue: 30, color: kPrimaryColor),
                GaugeRange(startValue: 30, endValue: 70, color: kSecondaryColor),
                GaugeRange(startValue: 70, endValue: 100, color: kAccentColor),
              ]),
              buildIndicator("LDR", ldrValue, 20000, 55000, [
                GaugeRange(startValue: 20000, endValue: 35000, color: kSecondaryColor),
                GaugeRange(startValue: 35000, endValue: 55000, color: kAccentColor),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('home');
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed('chartscreen');
          }
        },
      ),
    );
  }
}
