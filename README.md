# MyWeather

A Flutter weather app that uses your device's GPS to fetch real-time weather conditions and an hourly forecast — with dynamic themes and animations that change based on current weather.

---

## Features

- **Auto-location** — detects your position via GPS using `geolocator`
- **Current conditions** — temperature, feels like, min/max, humidity, wind, pressure, visibility, cloudiness, and more
- **Hourly forecast** — next 5 periods (3h intervals) with temperature and condition
- **Dynamic theming** — background color, text colors, and UI adapt to the current weather condition
- **Lottie animations** — animated weather icons matching the current condition
- **Humidity indicator** — circular progress indicator with current humidity percentage
- **Sunrise & Sunset** — dedicated cards at the bottom of the screen
- **Detailed location** — neighborhood, city, and state shown separately using the Geocoding API

---

## Tech Stack

| Layer | Package |
|---|---|
| State management | `provider` |
| HTTP | `http` |
| Location | `geolocator` |
| Animations | `lottie` |
| Environment | `flutter_dotenv` |

---

## APIs Used

| API | Endpoint |
|---|---|
| Current weather | `GET /data/2.5/weather` |
| 5-day forecast (3h) | `GET /data/2.5/forecast` |
| Reverse geocoding | `GET /geo/1.0/reverse` |

All requests are fired in parallel via `Future.wait` to minimize load time.

---

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/your-username/myweather.git
cd myweather
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up your API key

Create a `.env` file at the root of the project:

```
API_KEY=your_openweathermap_api_key
```

> Get a free key at [openweathermap.org](https://openweathermap.org/api)

### 4. Run the app

```bash
flutter run
```

---

## Project Structure

```
lib/
├── entities/
│   └── weather.dart          # WeatherModel + ForecastItem
├── services/
│   ├── weather_webservice.dart  # API calls (current, forecast, geocoding)
│   └── weather_provider.dart   # ChangeNotifier + theme logic
├── components/
│   ├── forecast_container.dart
│   └── umidity_container.dart
└── screens/
    └── home_screen.dart
assets/
└── animations/               # Lottie JSON files
```

---

## Dynamic Themes

The app applies a different `ThemeData` based on the current weather description returned by the API (in Brazilian Portuguese via `lang=pt_br`).

| Condition | Theme |
|---|---|
| `céu limpo` / `sol` | Warm orange, light background |
| `algumas nuvens` / `nuvens dispersas` | Blue-grey, light background |
| `chuviscos` / `chuva leve` | Deep blue, muted background |
| `chuva` / `tempestade` / `trovoada` | Dark blue-grey, dark background |
| `nublado` / `vento` / `ventania` | Grey, light background |
| `nascer do sol` | Deep orange, warm light background |
| `pôr do sol` | Deep orange, dark warm background |

---

## Permissions

The app requires location permission at runtime. On first launch, users will be prompted to grant access.

**Android** — add to `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

**iOS** — add to `Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>MyWeather uses your location to show local weather conditions.</string>
```

---

## License

MIT
