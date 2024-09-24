# VendCompost 🌱

VendCompost is a smart composting system that automates organic waste management using IoT technology. The system integrates various sensors and a NodeMCU ESP8266 module to monitor environmental factors like soil moisture, temperature, and more. It is controlled through a mobile app developed in Flutter, enabling users to monitor and manage composting in real-time.
see the app : https://drive.google.com/drive/u/0/folders/1UEsO_XdZu6CXzSY30ob7683cKzzCO2A7


## Features
- **Automated Composting**: IoT-enabled monitoring and control of composting processes.
- **Soil Sensor Data**: Real-time data from a 7-in-1 soil sensor, including moisture, temperature, pH, and more.
- **Mobile Control**: Control motors and other devices remotely via the VendCompost Flutter app.
- **Real-Time Alerts**: Notifications when conditions require attention, such as high temperature or low moisture.
- **User-Friendly UI**: Simple and intuitive interface for ease of use.

## Technologies Used
- **Hardware**: 
  - NodeMCU ESP8266 (WiFi Module)
  - 7-in-1 Soil Sensor
  - Motors for composting system control
- **Frontend**: 
  - Flutter (Mobile App)
- **Backend**: 
  - FastAPI (for handling API requests)
- **Database**: 
  - Firebase (for real-time data sync)

## Installation Guide

### Prerequisites
- Install [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Install [FastAPI](https://fastapi.tiangolo.com/)
- NodeMCU setup and configuration

### Steps to Install
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/VendCompost.git
   cd VendCompost
   ```
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Set up NodeMCU for sensor integration and WiFi connection. Follow the detailed setup guide in the `docs/NodeMCU_Setup.md` (link this if you have a separate setup guide).
4. Configure Firebase for real-time database connection and data storage.

## How to Use
- **Step 1**: Run the VendCompost app on your mobile device after connecting NodeMCU.
- **Step 2**: Use the mobile app to monitor the status of the compost system and adjust settings as needed.
- **Step 3**: View sensor data like temperature, humidity, and pH directly in the app.

## Future Enhancements
- Integration with AI for predictive composting cycles.
- Enhanced alert systems for user notifications.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.
