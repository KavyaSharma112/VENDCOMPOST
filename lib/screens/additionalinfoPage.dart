import 'package:flutter/material.dart';

class AdditionalInfoPage extends StatelessWidget {
  const AdditionalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Information"),
        backgroundColor: const Color(0xFF57796B),
      ),
      backgroundColor: const Color(0xFF57796B),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildParameterButton(
              context,
              "Temperature (°C)",
              "10.0",
              "25.0",
              "30.0",
              "°C",
            ),
            const SizedBox(height: 16.0),
            _buildParameterButton(
              context,
              "Moisture Content (%)",
              "20.0",
              "40.0",
              "60.0",
              "%",
            ),
            const SizedBox(height: 16.0),
            _buildParameterButton(
              context,
              "pH",
              "5.0",
              "7.0",
              "8.0",
              "",
            ),
            const SizedBox(height: 16.0),
            _buildParameterButton(
              context,
              "Light Intensity (lux)",
              "200.0",
              "500.0",
              "1000.0",
              "lux",
            ),
            const SizedBox(height: 16.0),
            _buildParameterButton(
              context,
              "Nitrogen (N)",
              "0.5",
              "1.0",
              "2.0",
              "%",
            ),
            const SizedBox(height: 16.0),
            _buildParameterButton(
              context,
              "Phosphorus (P)",
              "0.2",
              "0.5",
              "1.0",
              "%",
            ),
            const SizedBox(height: 16.0),
            _buildParameterButton(
              context,
              "Potassium (K)",
              "0.4",
              "1.0",
              "2.0",
              "%",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterButton(
    BuildContext context,
    String parameter,
    String stage1,
    String stage2,
    String stage3,
    String unit,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showParameterDialog(
              context, parameter, stage1, stage2, stage3, unit);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 57, 67, 61),
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          "$parameter $unit",
          style: const TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _showParameterDialog(
    BuildContext context,
    String parameter,
    String stage1,
    String stage2,
    String stage3,
    String unit,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(parameter),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildParameterRow("Stage 1", stage1, unit),
              _buildParameterRow("Stage 2", stage2, unit),
              _buildParameterRow("Stage 3", stage3, unit),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildParameterRow(String stage, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(stage, style: const TextStyle(fontSize: 16.0)),
          Text("$value $unit", style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
