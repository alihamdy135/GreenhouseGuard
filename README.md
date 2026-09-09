# GreenhouseGuard — IoT Greenhouse Monitoring App

A Flutter mobile application for real-time monitoring of a smart greenhouse (tomato crop),
backed by Firebase Realtime Database and an IoT sensor node. It visualizes soil moisture,
temperature, humidity and light intensity, shows live safety gauges, and includes an
in-app plant-care chatbot.

## Features

- **Live sensor dashboard** — gauges for Soil Moisture, Temperature, Humidity and LDR
  (light) streamed from Firebase Realtime Database (`syncfusion_flutter_gauges`).
- **Historical charts** — 20-point time series per sensor (`Soil_$i`, `Temperature_$i`,
  `Humidity_$i`, `LDR_$i`) rendered with `fl_chart` + `syncfusion_flutter_charts`.
- **Plant-care chatbot** — offline Q&A knowledge base for tomato growing:
  - General: sensor calibration (every 6 months), fertilization (NPK 10-10-10), pest control
  - Temperature: day 21–27 °C, night 16–20 °C
  - Humidity: optimal 65–85 %, ventilation/misting control
  - Light: 10+ hours/day, supplemental lighting guidance
  - Soil moisture: ideal 400–600 ADC, irrigation scheduling
- **Firebase Authentication** — email/password sign-in via `auth_controller.dart`.
- **Splash screen + bottom navigation** — `splash_screen.dart`, `bottom_navigator_bar.dart`.

## Tech Stack

| Layer      | Technology |
|------------|------------|
| Framework  | Flutter (Dart SDK `^3.5.4`) |
| Backend    | Firebase Core, Firebase Auth, Firebase Realtime Database |
| Charts     | `fl_chart`, `syncfusion_flutter_charts` |
| Gauges     | `syncfusion_flutter_gauges` |
| Indicators | `percent_indicator` |
| Assets     | `assets/logo.png` |

## Project Structure

```
lib/
├── main.dart                # App entry point, routes
├── splash_screen.dart       # Splash / startup screen
├── auth_controller.dart     # Firebase Auth logic
├── home.dart                # ChatbotScreen (plant-care Q&A)
├── charscreen.dart          # ChartScreen (historical sensor charts)
├── saftey.dart              # DataIndexScreen (live gauges from RTDB)
└── bottom_navigator_bar.dart# Shared bottom navigation
```

## Data Flow

```
IoT sensor node (ESP) ──writes──▶ Firebase Realtime Database
                                      │  Soil / Temperature / Humidity / LDR
                                      ▼
                              Flutter app ──reads──▶ gauges + charts + chatbot
```

## Getting Started

### Prerequisites

- Flutter SDK `^3.5.4`
- A Firebase project with **Authentication** (Email/Password) and **Realtime Database** enabled
- `google-services.json` (Android) / `GoogleService-Info.plist` (iOS) placed in the
  platform folders, or configure via `flutterfire configure`

### Run

```bash
flutter pub get
flutter run
```

### Firebase RTDB keys expected by the app

| Key pattern       | Type   | Description                  |
|-------------------|--------|------------------------------|
| `Soil`, `Soil_$i` | double | Soil moisture (ADC 0–1023)   |
| `Temperature...`  | double | Temperature in °C            |
| `Humidity...`     | double | Relative humidity %          |
| `LDR`, `LDR_$i`   | double | Light intensity (raw)        |

## Roadmap

- Push notifications on threshold breach
- Automatic irrigation control from soil-moisture readings
- Multi-greenhouse / multi-device support

## License

MIT
