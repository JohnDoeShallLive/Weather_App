# Weather App

A Flutter-based weather application that provides real-time weather information for any location.

## Features

- Current weather conditions with temperature, humidity, and wind speed
- 5-day weather forecast
- Location-based weather updates
- Search for weather by city name
- Beautiful and intuitive user interface
- Automatic location detection
- Weather condition icons and animations
- Temperature display in both Celsius and Fahrenheit
- Offline support with cached weather data

## Getting Started

### Prerequisites

- Flutter SDK installed
- Android Studio or VS Code with Flutter extension
- Android or iOS emulator, or physical device
- OpenWeatherMap API key (free tier available at https://openweathermap.org/api)

### API Key Setup

1. Sign up for a free API key at [OpenWeatherMap](https://openweathermap.org/api)
2. Replace `{API-KEY}` in `lib/Worker/worker.dart` with your actual API key
3. Wait at least 2 hours after obtaining your API key for it to become active

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/weather.git
```

2. Navigate to the project directory:
```bash
cd weather
```

3. Install dependencies:
```bash
flutter pub get
```

### Running the App

1. Connect your device or start an emulator
2. Run the app:
```bash
flutter run
```

## Usage

1. **Main Screen**
   - View current weather conditions
   - See temperature, humidity, and wind speed
   - Access 5-day forecast

2. **Location Features**
   - Use current location by allowing permissions
   - Search for weather by city name
   - Switch between locations

3. **Settings**
   - Toggle between Celsius and Fahrenheit
   - Enable/disable location tracking
   - Clear cache

## Project Structure

- `lib/`
  - `main.dart` - Main application entry point
  - `models/` - Data models
  - `screens/` - UI screens
  - `services/` - API and utility services
  - `widgets/` - Reusable UI components

## Dependencies

- `flutter_svg` - For weather icons
- `geolocator` - For location services
- `http` - For API requests
- `provider` - For state management
- `shared_preferences` - For local storage

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Acknowledgments

- OpenWeatherMap API for weather data
- Flutter community for excellent documentation and support
- All contributors who helped with the project
