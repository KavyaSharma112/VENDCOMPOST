import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({super.key});

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  Map<String, dynamic> sensorData = {
    'nitrogen': null,
    'phosphorus': null,
    'potassium': null,
  };

  // Ideal Thresholds
  final double idealNitrogen = 50.0;
  final double idealPhosphorus = 40.0;
  final double idealPotassium = 35.0;

  bool isLoading = true; // Track loading state

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.245.62/data'),
      );

      if (response.statusCode == 200) {
        setState(() {
          sensorData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false; // Even on failure, stop loading
      });
    }
  }

  String generateSuggestion(String nutrient, double? actualValue, double idealValue) {
    if (actualValue == null) return 'Data not available';
    if (actualValue < idealValue) {
      return "Increase $nutrient content (e.g., add organic compost or fertilizers).";
    } else if (actualValue > idealValue) {
      return "Reduce $nutrient input to avoid over-fertilization.";
    } else {
      return "$nutrient levels are balanced.";
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
        backgroundColor: const Color(0xFF3E5B4F), // Darker shade
        elevation: 0,
        title: const Text('Suggestions'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3E5B4F), Color(0xFFDDE2DC)], // Darker gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
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
                      'Nutrient Suggestions',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 16),

                    isLoading
                        ? _buildStructuredTips() // Show categorized tips while loading
                        : Column(
                            children: [
                              _buildSuggestionRow('Nitrogen', sensorData['nitrogen'], idealNitrogen),
                              _buildSuggestionRow('Phosphorus', sensorData['phosphorus'], idealPhosphorus),
                              _buildSuggestionRow('Potassium', sensorData['potassium'], idealPotassium),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStructuredTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryHeader("🌱 Composting Tips"),
        _buildTip("Use vegetable peels and fruit scraps to improve compost quality."),
        _buildTip("Avoid meat and dairy in compost to prevent odor and pests."),
        _buildTip("Shred larger items like leaves to speed up decomposition."),
        const SizedBox(height: 10),

        _buildCategoryHeader("🌿 Natural Fertilizers"),
        _buildTip("Banana peels are a great source of potassium."),
        _buildTip("Coffee grounds add nitrogen to the soil."),
        _buildTip("Eggshells provide calcium and help balance pH."),
        const SizedBox(height: 10),

        _buildCategoryHeader("💧 Moisture & Soil Health"),
        _buildTip("Keep compost slightly moist for better microbial activity."),
        _buildTip("Turn compost every few weeks to maintain aeration."),
        _buildTip("Use dry leaves or paper to balance excess moisture."),
      ],
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(
        tip,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildSuggestionRow(String label, dynamic actualValue, double idealValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ${actualValue ?? 'N/A'} mg/kg',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            generateSuggestion(label, actualValue?.toDouble() ?? 0.0, idealValue),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
