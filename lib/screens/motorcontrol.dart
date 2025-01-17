// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
// Import Lottie package
import 'package:http/http.dart' as http;

class MotorControl extends StatefulWidget {
  const MotorControl({super.key});

  @override
  State<MotorControl> createState() => _MotorControlState();
}

class _MotorControlState extends State<MotorControl> {
  final String esp8266IP =
      "192.168.85.62"; 

  bool isMotor1On = false;
  bool isPumpOn = false;
  bool isHeaterOn = false;

  Future<void> sendCommand(String command) async {
    final url = Uri.http(esp8266IP, "/command", {"action": command});
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Command sent: $command");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Gradient gradient,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
          elevation: 5, // Shadow effect
          side: const BorderSide(color: Colors.transparent),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient, // Gradient color
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Motor Control",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFF57796B),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF57796B),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'lib/assets/gif/Animation - 1722425235476.gif',
                height: 250,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),

            // Motor 1 control button
            _buildControlButton(
              icon: isMotor1On ? Icons.power_off : Icons.power,
              label: isMotor1On ? "Turn Motor 1 OFF" : "Turn Motor 1 ON",
              onPressed: () {
                setState(() {
                  if (isMotor1On) {
                    sendCommand("MOTOR1_OFF");
                  } else {
                    sendCommand("MOTOR1_ON");
                  }
                  isMotor1On = !isMotor1On;
                });
              },
              gradient: isMotor1On
                  ? const LinearGradient(
                      colors: [Color(0xFFEF5350), Color(0xFFE53935)],
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
                    ),
            ),

            // Pump control button
            _buildControlButton(
              icon: isPumpOn ? Icons.watch_off : Icons.water_drop,
              label: isPumpOn ? "Turn Pump OFF" : "Turn Pump ON",
              onPressed: () {
                setState(() {
                  if (isPumpOn) {
                    sendCommand("PUMP_OFF");
                  } else {
                    sendCommand("PUMP_ON");
                  }
                  isPumpOn = !isPumpOn;
                });
              },
              gradient: isPumpOn
                  ? const LinearGradient(
                      colors: [Color(0xFFFB8C00), Color(0xFFF4511E)],
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                    ),
            ),

            // Heater control button
            _buildControlButton(
              icon: isHeaterOn ? Icons.thermostat_auto : Icons.heat_pump,
              label: isHeaterOn ? "Turn Heater OFF" : "Turn Heater ON",
              onPressed: () {
                setState(() {
                  if (isHeaterOn) {
                    sendCommand("HEATER_OFF");
                  } else {
                    sendCommand("HEATER_ON");
                  }
                  isHeaterOn = !isHeaterOn;
                });
              },
              gradient: isHeaterOn
                  ? const LinearGradient(
                      colors: [Color(0xFFBDBDBD), Color(0xFF757575)],
                    )
                  : const LinearGradient(
                      colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:lottie/lottie.dart';

// class MotorControl extends StatefulWidget {
//   const MotorControl({super.key});

//   @override
//   State<MotorControl> createState() => _MotorControlState();
// }

// class _MotorControlState extends State<MotorControl> {
//   final String esp8266IP = "192.168.85.62"; // Replace with your ESP8266 IP

//   bool isMotor1On = false;
//   bool isPumpOn = false;
//   bool isHeaterOn = false;
//   int gasSensorValue = 0;

//   Future<void> sendCommand(String command) async {
//     final url = Uri.http(esp8266IP, "/command", {"action": command});
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         print("Command sent: $command");
//       } else {
//         print("Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   Future<void> fetchGasSensorData() async {
//     final url = Uri.http(esp8266IP, "/gas");
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         setState(() {
//           gasSensorValue = int.parse(response.body.split(":")[1].trim());
//         });
//       } else {
//         print("Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   Widget _buildControlButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//     required Gradient gradient,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           padding: const EdgeInsets.symmetric(vertical: 15.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           elevation: 5,
//         ),
//         onPressed: onPressed,
//         child: Ink(
//           decoration: BoxDecoration(
//             gradient: gradient,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Container(
//             height: 60,
//             alignment: Alignment.center,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, color: Colors.white, size: 28),
//                 const SizedBox(width: 12),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Motor Control"),
//         backgroundColor: Colors.green,
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Lottie.network(
//             'https://lottie.host/f29eb0e6-bda4-446f-8b5b-96dc58c0ead6/guA4uRVn1X.json',
//             height: 200,
//           ),
//           _buildControlButton(
//             icon: isMotor1On ? Icons.power_off : Icons.power,
//             label: isMotor1On ? "Turn Motor 1 OFF" : "Turn Motor 1 ON",
//             onPressed: () {
//               setState(() {
//                 isMotor1On = !isMotor1On;
//               });
//               sendCommand(isMotor1On ? "MOTOR1_ON" : "MOTOR1_OFF");
//             },
//             gradient: isMotor1On
//                 ? LinearGradient(colors: [Colors.red, Colors.redAccent])
//                 : LinearGradient(colors: [Colors.green, Colors.greenAccent]),
//           ),
//           ElevatedButton(
//             onPressed: fetchGasSensorData,
//             child: const Text("Fetch Gas Sensor Data"),
//           ),
//           Text(
//             "Gas Sensor Value: $gasSensorValue",
//             style: const TextStyle(fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }