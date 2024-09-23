class ThresholdRanges {
  static const Map<String, Map<String, List<double>>> ranges = {
    'Nitrogen (N)': {
      'Low': [0.0, 50.0],
      'Optimal': [50.0, 200.0],
      'High': [200.0, double.infinity],
    },
    'Phosphorus (P)': {
      'Low': [0.0, 10.0],
      'Optimal': [10.0, 40.0],
      'High': [40.0, double.infinity],
    },
    'Potassium (K)': {
      'Low': [0.0, 100.0],
      'Optimal': [100.0, 250.0],
      'High': [250.0, double.infinity],
    },
    'pH': {
      'Acidic': [0.0, 5.5],
      'Neutral': [5.5, 7.5],
      'Alkaline': [7.5, double.infinity],
    },
    'Moisture Content (%)': {
      'Dry': [0.0, 10.0],
      'Moist': [10.0, 20.0],
      'Wet': [20.0, double.infinity],
    },
    'Temperature (°C)': {
      'Low': [0.0, 15.0],
      'Optimal': [15.0, 30.0],
      'High': [30.0, double.infinity],
    },
    'Light Intensity (lux)': {
      'Low': [0.0, 1000.0],
      'Optimal': [1000.0, 3000.0],
      'High': [3000.0, double.infinity],
    },
  };
}
