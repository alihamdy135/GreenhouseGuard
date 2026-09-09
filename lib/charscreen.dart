import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'bottom_navigator_bar.dart';

const Color kPrimaryColor = Color(0xFF2C6975);
const Color kSecondaryColor = Color(0xFF68B2A0);
const Color kAccentColor = Color(0xFFCDE0C9);
const Color kLightAccentColor = Color(0xFFE0ECDE);
const Color kBackgroundColor = Color(0xFFFFFFFF);

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference deviceCodeRef;

  final List<int> soilMoistureData = List.filled(20, 0);
  final List<double> temperatureData = List.filled(20, 0.0);
  final List<int> humidityData = List.filled(20, 0);
  final List<int> ldrData = List.filled(20, 0);

  @override
  void initState() {
    super.initState();
    deviceCodeRef = database.ref().child('DataBase').child('Chart');
    retrieveData();
  }

  void retrieveData() {
    // Fetch data for all sensors in a single loop
    for (int i = 0; i < 20; i++) {
      final fields = ['Soil_$i', 'Temperature_$i', 'Humidity_$i', 'LDR_$i'];
      for (var field in fields) {
        deviceCodeRef.child(field).once().then((event) {
          setState(() {
            if (field.contains('Soil')) {
              soilMoistureData[i] = int.tryParse(event.snapshot.value.toString()) ?? 0;
            } else if (field.contains('Temperature')) {
              temperatureData[i] = double.tryParse(event.snapshot.value.toString()) ?? 0.0;
            } else if (field.contains('Humidity')) {
              humidityData[i] = int.tryParse(event.snapshot.value.toString()) ?? 0;
            } else if (field.contains('LDR')) {
              ldrData[i] = int.tryParse(event.snapshot.value.toString()) ?? 0;
            }
          });
        }).catchError((error) => debugPrint("Error retrieving $field: $error"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts'),
        backgroundColor: kPrimaryColor, // Set AppBar color to kPrimaryColor
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Soil Moisture Chart
            SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              title: ChartTitle(
                text: 'Soil Moisture Data Analysis',
                textStyle: TextStyle(color: kPrimaryColor), // Set title color to kPrimaryColor
              ),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<Map<String, dynamic>, int>>[
                LineSeries<Map<String, dynamic>, int>(
                  dataSource: List.generate(
                    soilMoistureData.length,
                    (index) => {'year': index + 1, 'sales': soilMoistureData[index]},
                  ),
                  xValueMapper: (Map<String, dynamic> sales, _) => sales['year']!,
                  yValueMapper: (Map<String, dynamic> sales, _) => sales['sales']!,
                  name: 'Soil Moisture',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  color: kSecondaryColor, // Set the chart line color to kSecondaryColor
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Temperature Chart
            SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              title: ChartTitle(
                text: 'Temperature Data',
                textStyle: TextStyle(color: kPrimaryColor), // Set title color to kPrimaryColor
              ),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<Map<String, dynamic>, int>>[
                LineSeries<Map<String, dynamic>, int>(
                  dataSource: List.generate(
                    temperatureData.length,
                    (index) => {'year': index + 1, 'sales': temperatureData[index]},
                  ),
                  xValueMapper: (Map<String, dynamic> data, _) => data['year']!,
                  yValueMapper: (Map<String, dynamic> data, _) => data['sales']!,
                  name: 'Temperature',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  color: kSecondaryColor, // Set the chart line color to kSecondaryColor
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Humidity Chart
            SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              title: ChartTitle(
                text: 'Humidity Data',
                textStyle: TextStyle(color: kPrimaryColor), // Set title color to kPrimaryColor
              ),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<Map<String, dynamic>, int>>[
                LineSeries<Map<String, dynamic>, int>(
                  dataSource: List.generate(
                    humidityData.length,
                    (index) => {'year': index + 1, 'sales': humidityData[index]},
                  ),
                  xValueMapper: (Map<String, dynamic> data, _) => data['year']!,
                  yValueMapper: (Map<String, dynamic> data, _) => data['sales']!,
                  name: 'Humidity',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  color: kSecondaryColor, // Set the chart line color to kSecondaryColor
                ),
              ],
            ),
            const SizedBox(height: 20),

            // LDR Chart
            SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              title: ChartTitle(
                text: 'LDR Data Analysis',
                textStyle: TextStyle(color: kPrimaryColor), // Set title color to kPrimaryColor
              ),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<Map<String, dynamic>, int>>[
                LineSeries<Map<String, dynamic>, int>(
                  dataSource: List.generate(
                    ldrData.length,
                    (index) => {'year': index + 1, 'sales': ldrData[index]},
                  ),
                  xValueMapper: (Map<String, dynamic> data, _) => data['year']!,
                  yValueMapper: (Map<String, dynamic> data, _) => data['sales']!,
                  name: 'LDR',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  color: kSecondaryColor, // Set the chart line color to kSecondaryColor
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('home');
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed('Safe');
          }
        },
      ),
    );
  }
}
