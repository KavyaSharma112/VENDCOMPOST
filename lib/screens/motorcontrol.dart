import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MotorControl extends StatefulWidget {
  const MotorControl({super.key});

  @override
  State<MotorControl> createState() => _MotorControlState();
}

class _MotorControlState extends State<MotorControl> {
  final String esp8266IP = "192.168.1.100"; // Update with ESP IP

  bool isMotor1On = false;
  bool isPumpOn = false;
  bool isHeaterOn = false;

  Future<void> sendCommand(String command) async {
    final url = Uri.parse('http://$esp8266IP/command?action=$command');
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

  Widget _buildControlButton(String label, bool isOn, String onCommand, String offCommand) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          sendCommand(isOn ? offCommand : onCommand);
          isOn = !isOn;
        });
      },
      style: ElevatedButton.styleFrom(backgroundColor: isOn ? Colors.red : Colors.green),
      child: Text(isOn ? "Turn $label OFF" : "Turn $label ON"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Motor Control")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildControlButton("Motor 1", isMotor1On, "MOTOR1_ON", "MOTOR1_OFF"),
          _buildControlButton("Pump", isPumpOn, "PUMP_ON", "PUMP_OFF"),
          _buildControlButton("Heater", isHeaterOn, "HEATER_ON", "HEATER_OFF"),
        ],
      ),
    );
  }
}
