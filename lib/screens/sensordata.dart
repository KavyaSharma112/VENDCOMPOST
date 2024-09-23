// ignore_for_file: avoid_print

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

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.245.62/data'),
      );

      if (response.statusCode == 200) {
        setState(() {
          sensorData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF57796B), Color(0xFFF2F4F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: sensorData['nitrogen'] == null
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sensor Data',
                            style: TextStyle(
                              fontSize: 24, // Adjust size as needed
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSensorDataRow(
                              'Nitrogen', sensorData['nitrogen']),
                          _buildSensorDataRow(
                              'Phosphorus', sensorData['phosphorus']),
                          _buildSensorDataRow(
                              'Potassium', sensorData['potassium']),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSensorDataRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value == null ? 'N/A' : '$value mg/kg',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
