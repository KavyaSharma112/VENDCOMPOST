import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendcompost/screens/Compostingguide.dart';
import 'package:vendcompost/screens/additionalinfoPage.dart';
import 'package:vendcompost/screens/motorcontrol.dart';

import 'package:vendcompost/screens/npkdata.dart';

class CompostStagesPageState extends StatefulWidget {
  const CompostStagesPageState({super.key});

  @override
  _CompostStagesPageState createState() => _CompostStagesPageState();
}

class _CompostStagesPageState extends State<CompostStagesPageState> {
  final List<CompostStage> stages = [
    CompostStage(
      name: "Stage 1",
      description: "Initial Breakdown",
      duration: 5,
    ),
    CompostStage(
      name: "Stage 2",
      description: "Heating",
      duration: 10,
    ),
    CompostStage(
      name: "Stage 3",
      description: "Cooling",
      duration: 14,
    ),
    CompostStage(
      name: "Stage 4",
      description: "Maturation",
      duration: 30,
    ),
  ];

  int currentStageIndex = 0;
  int daysElapsed = 0;
  late Timer _timer;
  int _selectedIndex = 0; // Index to keep track of the selected tab

  @override
  void initState() {
    super.initState();
    loadState();

    // Schedule timer to check for midnight and update
    _timer = Timer.periodic(const Duration(hours: 24), (Timer timer) {
      // Get current date and time
      DateTime now = DateTime.now();

      // Check if it's midnight (00:00:00)
      if (now.hour == 0 && now.minute == 0 && now.second == 0) {
        // Increment days and advance stage
        advanceStage();
        increaseDaysElapsed();
      }
    });

    // Initialize suggestions based on initial sensor values
    updateSuggestions();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void advanceStage() {
    setState(() {
      if (currentStageIndex < stages.length - 1) {
        currentStageIndex++;
        daysElapsed = 0;
        saveState();
      }
    });
  }

  void increaseDaysElapsed() {
    setState(() {
      if (daysElapsed < stages[currentStageIndex].duration) {
        daysElapsed++;
        saveState();
      }
    });
  }

  Future<void> saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentStageIndex', currentStageIndex);
    await prefs.setInt('daysElapsed', daysElapsed);
  }

  Future<void> loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentStageIndex = prefs.getInt('currentStageIndex') ?? 0;
      daysElapsed = prefs.getInt('daysElapsed') ?? 0;

      // Ensure we start at Stage 1 if no saved state exists
      if (currentStageIndex != 0 || daysElapsed != 0) {
        currentStageIndex = 0;
        daysElapsed = 0;
        saveState();
      }
    });
  }

  // Function to update suggestions based on sensor values
  void updateSuggestions() {
    // Temperature suggestion
    if (temperatureValue < targetTemperature - 2) {
      temperatureSuggestion =
          "Increase temperature slightly for faster breakdown.";
    } else if (temperatureValue > targetTemperature + 2) {
      temperatureSuggestion =
          "Decrease temperature slightly to avoid overheating.";
    } else {
      temperatureSuggestion = "Temperature is within optimal range.";
    }

    // Moisture content suggestion
    if (moistureContentValue < targetMoistureContent - 5) {
      moistureContentSuggestion =
          "Increase moisture content for better composting.";
    } else if (moistureContentValue > targetMoistureContent + 5) {
      moistureContentSuggestion =
          "Reduce moisture content to prevent soggy compost.";
    } else {
      moistureContentSuggestion = "Moisture content is optimal.";
    }

    // pH level suggestion
    if (pHValue < targetpH - 0.5) {
      pHLevelSuggestion = "Increase pH level to promote microbial activity.";
    } else if (pHValue > targetpH + 0.5) {
      pHLevelSuggestion = "Decrease pH level to enhance nutrient availability.";
    } else {
      pHLevelSuggestion = "pH level is balanced.";
    }

    // Light intensity suggestion
    if (lightIntensityValue < targetLightIntensity - 100) {
      lightIntensitySuggestion =
          "Increase light intensity for better composting process.";
    } else if (lightIntensityValue > targetLightIntensity + 100) {
      lightIntensitySuggestion =
          "Reduce light intensity to avoid drying out the compost.";
    } else {
      lightIntensitySuggestion = "Light intensity is appropriate.";
    }

    // Nutrient balance suggestion
    if (nitrogenValue < targetNitrogen * 0.8) {
      nutrientBalanceSuggestion =
          "Add nitrogen-rich materials for better nutrient balance.";
    } else if (nitrogenValue > targetNitrogen * 1.2) {
      nutrientBalanceSuggestion =
          "Reduce nitrogen-rich materials to balance nutrient levels.";
    } else if (phosphorusValue < targetPhosphorus * 0.8) {
      nutrientBalanceSuggestion =
          "Add phosphorus-rich materials for improved compost quality.";
    } else if (phosphorusValue > targetPhosphorus * 1.2) {
      nutrientBalanceSuggestion =
          "Reduce phosphorus-rich materials to balance nutrient levels.";
    } else if (potassiumValue < targetPotassium * 0.8) {
      nutrientBalanceSuggestion =
          "Add potassium-rich materials to enhance compost fertility.";
    } else if (potassiumValue > targetPotassium * 1.2) {
      nutrientBalanceSuggestion =
          "Reduce potassium-rich materials to balance nutrient levels.";
    } else {
      nutrientBalanceSuggestion = "Nutrient balance is adequate.";
    }
  }

  // Function to handle navigation bar tap

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to Motor Control Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MotorControl()),
      ).then((_) {
        // Set index to 0 when coming back from Motor Control Page
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else {
      // Set index to Home tab
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // Pages to display based on selected index

  @override
  Widget build(BuildContext context) {
    CompostStage currentStage = stages[currentStageIndex];
    int daysRemaining = currentStage.duration - daysElapsed;

    return Scaffold(
      backgroundColor: const Color(0xFF57796B),
      appBar: AppBar(
        title: Text(currentStage.name),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        backgroundColor: const Color(0xFF57796B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.0),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(2, 20),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset('lib/assets/images/vend.png', height: 300),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              currentStage.description,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Time remaining: $daysRemaining days",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Displaying sensor values and target values
            _buildSensorValueRow(
                "Temperature (°C)", temperatureValue, targetTemperature),
            _buildSensorValueRow("Moisture Content (%)", moistureContentValue,
                targetMoistureContent),
            _buildSensorValueRow("pH", pHValue, targetpH),
            _buildSensorValueRow("Light Intensity (lux)", lightIntensityValue,
                targetLightIntensity),
            _buildSensorValueRow("Nitrogen (N)", nitrogenValue, targetNitrogen),
            _buildSensorValueRow(
                "Phosphorus (P)", phosphorusValue, targetPhosphorus),
            _buildSensorValueRow(
                "Potassium (K)", potassiumValue, targetPotassium),
            const SizedBox(height: 40),
            _buildSuggestion("Temperature", temperatureSuggestion),
            _buildSuggestion("Moisture Content", moistureContentSuggestion),
            _buildSuggestion("pH Level", pHLevelSuggestion),
            _buildSuggestion("Light Intensity", lightIntensitySuggestion),
            _buildSuggestion("Nutrient Balance", nutrientBalanceSuggestion),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdditionalInfoPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 57, 67, 61),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Additional Info"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompostingGuidePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 57, 67, 61),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Composting Guide"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Motor Control',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }

  Widget _buildSensorValueRow(String label, double value, double target) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Text(
                value.toStringAsFixed(2), // Adjust as needed for formatting
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "(Target: ${target.toStringAsFixed(2)})",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestion(String label, String suggestion) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label Suggestion",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            suggestion,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class CompostStage {
  final String name;
  final String description;
  final int duration;

  CompostStage({
    required this.name,
    required this.description,
    required this.duration,
  });
}
