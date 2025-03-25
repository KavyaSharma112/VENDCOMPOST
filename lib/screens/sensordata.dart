import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorDataPage extends StatefulWidget {
  const SensorDataPage({super.key});

  @override
  _SensorDataPageState createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  Map<String, dynamic> sensorData = {
    'nitrogen': null,
    'phosphorus': null,
    'potassium': null,
  };

  final String esp8266IP = "192.168.1.100"; // Update with ESP IP

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://$esp8266IP/data'));

      if (response.statusCode == 200) {
        setState(() {
          sensorData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF57796B),
        elevation: 0,
        title: const Text('Sensor Data'),
        centerTitle: true,
      ),
      body: Center(
        child: sensorData['nitrogen'] == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSensorDataRow('Nitrogen', sensorData['nitrogen']),
                  _buildSensorDataRow('Phosphorus', sensorData['phosphorus']),
                  _buildSensorDataRow('Potassium', sensorData['potassium']),
                ],
              ),
      ),
    );
  }

  Widget _buildSensorDataRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '$label: ${value ?? "N/A"} mg/kg',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
