import 'package:flutter/material.dart';

class CompostingGuidePage extends StatelessWidget {
  const CompostingGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF57796B),
      appBar: AppBar(
        title: const Text(
          "COMPOSTING GUIDE",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF57796B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCompostingProcedureFlowchart(),
            _buildDosAndDontsGuide(),
          ],
        ),
      ),
    );
  }
}

Widget _buildCompostingProcedureFlowchart() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.symmetric(vertical: 20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Basic Composting Procedure",
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF57796B)),
          ),
          const SizedBox(height: 12.0),
          Image.asset(
            'lib/assets/images/procedure.png',
            height: 400,
          ),
        ],
      ),
    ),
  );
}

Widget _buildDosAndDontsGuide() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.symmetric(vertical: 20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dos and Don'ts for Composting",
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF57796B)),
        ),
        SizedBox(height: 12.0),
        Text(
          "Do:\n"
          "- Balance greens and browns\n"
          "- Cover the compost pile\n"
          "- Compost in batches or layers\n"
          "- Use compost as soil amendment\n\n"
          "Don't:\n"
          "- Add meat, dairy, or oily foods\n"
          "- Use chemical additives\n"
          "- Neglect your compost pile",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ],
    ),
  );
}
