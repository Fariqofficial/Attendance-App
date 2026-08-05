# 📍 Attendance App

A Flutter-based Mobile Attendance Application with **Geofencing Radius Checking**, **Location Picker Map**, and **Clean Architecture**.

Built using **Flutter**, **BLoC/Cubit**, **GetIt**, and **OpenStreetMap (Flutter Map)**.

---

## ✨ Features

- **📍 Location List**: View available attendance locations with coordinates and allowed radius.
- **➕ Add Location**: Interactive map picker to select custom locations with real-time **Reverse Geocoding** (updates address automatically when dragging the map).
- **⏱️ Clock In / Check-In**: Automatic GPS location checking with **Geofencing Validation**:
  - Automatically calculates distance between user's live position and target location.
  - Visual status indicator (Green for inside radius, Red/Grey for outside radius).
  - Handles Location Permissions & Hardware GPS status properly.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **Architecture**: Clean Architecture (Data, Domain, Presentation Layers)
- **State Management**: [Flutter BLoC / Cubit](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Maps**: [Flutter Map](https://pub.dev/packages/flutter_map) & OpenStreetMap
- **Geocoding & Location**: [geocoding](https://pub.dev/packages/geocoding) & [geolocator](https://pub.dev/packages/geolocator)
- **UI & Responsiveness**: [flutter_screenutil](https://pub.dev/packages/flutter_screenutil), Google Fonts

---

## 🚀 Getting Started

### Prerequisites

Ensure you have installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version)
- Android Studio / VS Code
- Android Emulator / Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone [https://github.com/your-username/hashmicro_attendance_app.git](https://github.com/your-username/hashmicro_attendance_app.git)
   cd hashmicro_attendance_app
---
### 👨‍💻 Develop by @Fariqofficial
