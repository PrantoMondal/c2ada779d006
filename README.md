# Device Vitals Monitor

A Flutter application that monitors device sensor data (thermal state, battery level, and memory usage) and logs it to a Node.js backend API.

---

## 📋 Prerequisites

- **Node.js** (v24.13.0 or higher)
- **Flutter** (3.38.6 via FVM)
- **FVM** (Flutter Version Management) - [Install FVM](https://fvm.app/docs/getting_started/installation)
- **Android Studio** / **Xcode** (for Android/iOS development)
- **Physical Android device** or **Emulator** (API level 29+ recommended for thermal sensor)

---

## Installation
1. **Clone the Repository:** <br />Clone this repository to your local machine using the following command:<br /><br />
    ```bash
    git clone https://github.com/PrantoMondal/c2ada779d006.git
    ```
2. **Open Directory:**<br />Navigate to the project directory and complete the setup:<br /><br />
    ```bash
    cd c2ada779d006
    ```


## 🚀 Backend Setup

### Step 1: Navigate to Backend Directory
```bash
cd api
```

### Step 2: Install Dependencies
```bash
npm install
```

### Step 3: Start the Server
```bash
npm start or node src/server.js
```

The server will start on **`http://localhost:3000`**

### Step 4: Get Your Local IP Address

**On Windows:**
```bash
ipconfig
```
Look for `IPv4 Address` under your active network connection

**On macOS/Linux:**
```bash
ifconfig
```
Look for `inet` address (usually starts with `192.168.x.x` or `10.x.x.x`)

**Example Output:**
```
IPv4 Address: 10.173.90.225
```

---

## 📱 Flutter App Setup

### Step 1: Navigate to Flutter Directory
```bash
cd c2ada779d006
```

### Step 2: Use FVM to Set Flutter Version
```bash
fvm use 3.38.6
```

If the version is not installed, FVM will prompt you to install it:
```bash
fvm install 3.38.6
```

### Step 3: Update Base URL with Your Local IP

Open the file:
```
lib/src/main.dart
```

Find this line:
```dart
baseUrl: "http://xx.xxx.xx.xxxx:3000/api",
```

**Replace `10.173.90.225` with your local IP address** from Step 4 of Backend Setup.

Example:
```dart
baseUrl: "http://yyy.yyy.y.yyy:3000/api",  // Your IP here
```

### Step 4: Clean and Get Dependencies
```bash
fvm flutter clean
fvm flutter pub get
```

### Step 5: Run the App
```bash
fvm flutter run
```

Select your connected device or emulator when prompted.

---

## 🧪 Testing the Application

### 1. Test Backend API (Optional)

**POST Request - Log Vitals:**
```bash
curl -X POST http://YOUR_IP:3000/api/vitals \
  -H "Content-Type: application/json" \
  -d '{
    "device_id": "test-device",
    "timestamp": "2024-01-29T10:00:00Z",
    "thermal_value": 1,
    "battery_level": 85,
    "memory_usage": 45
  }'
```

**GET Request - Fetch History:**
```bash
curl http://YOUR_IP:3000/api/vitals
```

**GET Request - Fetch Analytics:**
```bash
curl http://YOUR_IP:3000/api/vitals/analytics
```

### 2. Test Flutter App

1. Open the app on your device
2. Pull down to refresh and view current sensor readings
3. Click **"Log Status"** button to send data to backend
4. Navigate to **History** screen (top-right icon) to view logged data
5. Check analytics at the bottom of History screen

---

## 📁 Project Structure

### Flutter App
```
lib/
├── src/
│   ├── core/
│   │   ├── base/
│   │   ├── config/
│   │   ├── constants/
│   │   ├── network/
│   │   ├── routes/
│   │   └── utils/
│   └── features/
│       ├── home/
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       ├── history/
│       └── splash/
└── main.dart
```

### Backend API
```
api/
├── src/
│   ├── config/
│   │   └── database.js
│   ├── data/
│   │   └── vitals.db
│   └── modules/
│       └── vitals/
│           ├── controller.js
│           ├── repository.js
│           ├── routes.js
│           ├── service.js
│           └── validation.js
├── app.js
├── server.js
└── package.json
```

---

## 🔧 Troubleshooting

### Backend Issues

**Port Already in Use:**
```bash
# Change port in server.js
const PORT = 3001; // Change from 3000
```

**Database Locked:**
```bash
# Delete the database file and restart
rm src/data/vitals.db
npm start or node src/server.js
```

### Flutter Issues

**FVM Command Not Found:**
```bash
# Install FVM globally
dart pub global activate fvm
```

**Network Error - "Failed to connect":**
- Ensure backend server is running
- Check if your phone and computer are on the same Wi-Fi network
- Verify the IP address in `api_client.dart` is correct
- Disable firewall temporarily to test

**Platform Channel Error:**
- Ensure you're testing on a physical Android device or emulator (API 29+)
- iOS simulator may show "Not Available" for some sensors (expected behavior)

**Build Failed:**
```bash
# Clear Flutter cache
fvm flutter clean
rm -rf .dart_tool/
fvm flutter pub get
```

---

## 🎯 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/vitals` | Log device vitals |
| GET | `/api/vitals` | Get latest 100 entries |
| GET | `/api/vitals/analytics` | Get analytics data |

### POST /api/vitals
**Request Body:**
```json
{
  "device_id": "string",
  "timestamp": "ISO8601 datetime",
  "thermal_value": "0-3",
  "battery_level": "0-100",
  "memory_usage": "0-100"
}
```

**Response:**
```json
{
  "message": "Vitals logged successfully"
}
```

### GET /api/vitals/analytics
**Response:**
```json
{
  "thermal": {
    "min": 0,
    "max": 2,
    "average": 1.2,
    "stdDev": 0.5
  },
  "battery": {
    "min": 45,
    "max": 95,
    "average": 75.5,
    "stdDev": 12.3
  },
  "memory": {
    "min": 30,
    "max": 80,
    "average": 55.0,
    "stdDev": 15.2
  }
}
```

---

## 📝 Notes

- The app uses **MethodChannel** to retrieve native sensor data (no third-party packages)
- Backend uses **SQLite** for persistent storage
- Data survives server restarts
- Android API 29+ required for thermal sensor support
- Pull-to-refresh to update sensor readings manually

---

## 🏗️ Technology Stack

**Backend:**
- Node.js + Express 5
- better-sqlite3 (SQLite)
- Zod (Validation)

**Frontend:**
- Flutter 3.38.6
- BLoC Pattern (State Management)
- MethodChannel (Native Platform Integration)

---

## 👨‍💻 Development

### Backend Development Mode
```bash
cd api
npm start or node src/server.js  # Auto-restarts on file changes
```

### Flutter Hot Reload
Press `r` in terminal while app is running for hot reload  
Press `R` for hot restart

---

## 📄 License

This project is for assignment purposes.