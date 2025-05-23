# Weather App

A Flutter-based weather application that allows users to view and save weather information for different cities.

## Features

- Current weather conditions:
  - Temperature
  - Humidity
  - Air speed
  - Weather description
- Weather icons and animations
- Location-based weather updates
- Data storage:
  - SQLite database for weather data
  - Automatic time and date tracking
- User Interface:
  - Loading screen with spinner animation
  - Weather display with icons
  - Saved data viewing page
  - Location selection
- Data Management:
  - Save current weather data
  - View historical weather data
  - Database caching for offline access

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
  - `main.dart` - Route configuration and app initialization
  - `database_helper.dart` - SQLite database operations
  - `Worker/`
    - `worker.dart` - Weather API integration and data processing
  - `Activity/`
    - `home.dart` - Main weather display screen with current conditions
    - `loading.dart` - Initial loading screen with spinner
    - `location.dart` - Location selection functionality
    - `saved_data_page.dart` - View saved weather data from database

## Dependencies

- `sqflite` - For SQLite database operations
- `flutter_spinkit` - For loading animations
- `weather_icons` - For weather condition icons
- `http` - For API requests
- `provider` - For state management

## Dependencies

- `sqflite` - For SQLite database operations
- `flutter_spinkit` - For loading animations
- `weather_icons` - For weather condition icons
- `http` - For API requests
- `provider` - For state management

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
