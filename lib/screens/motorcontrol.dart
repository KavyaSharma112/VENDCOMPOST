// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vendcompost/screens/sensordata.dart';

class MotorControlPage extends StatefulWidget {
  const MotorControlPage({super.key});

  @override
  _MotorControlPageState createState() => _MotorControlPageState();
}

class _MotorControlPageState extends State<MotorControlPage> {
  final String espIpAddress =
      'http://192.168.245.62'; // Replace with your ESP8266 IP address
  Map<String, dynamic> sensorData = {};

  Future<void> sendCommand(String command) async {
    final url = Uri.parse('$espIpAddress/$command'); // Correct URL
    print('Sending request to: $url'); // Debug statement
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('Command $command sent successfully');
      } else {
        print(
            'Failed to send command $command. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchSensorData() async {
    final url = Uri.parse('$espIpAddress/data');
    print('Fetching sensor data from: $url'); // Debug statement
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          sensorData = json.decode(response.body);
        });
        print('Sensor data fetched successfully');
      } else {
        print(
            'Failed to fetch sensor data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motor Control'),
        backgroundColor: const Color(0xFF57796B),
        elevation: 0,
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'lib/assets/gif/Animation - 1722425235476.gif',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => sendCommand('start'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF57796B),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shadowColor: Colors.black,
                    elevation: 5,
                  ),
                  child: const Text('Start Motor'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => sendCommand('stop'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shadowColor: Colors.black,
                    elevation: 5,
                  ),
                  child: const Text('Stop Motor'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the SensorDataPage when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SensorDataPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shadowColor: Colors.black,
                    elevation: 5,
                  ),
                  child: const Text('Fetch Sensor Data'),
                ),
                const SizedBox(height: 20),
                if (sensorData.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: sensorData.length,
                      itemBuilder: (context, index) {
                        String key = sensorData.keys.elementAt(index);
                        return ListTile(
                          title: Text('$key: ${sensorData[key]}'),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MotorControlPage(),
  ));
}
