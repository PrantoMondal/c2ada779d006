# Design Decisions & Ambiguity Handling

---

## 1. Ambiguities Identified

### Ambiguity 1: Analytics Endpoint Response Format
**Question**: What specific analytics should be returned beyond rolling average?

**Options Considered**:
- Only rolling average (simple, meets requirement)
- Multiple metrics (min, max, average, standard deviation)
- Time-windowed analytics (hourly, daily, weekly)

**Decision**: Multiple statistical metrics for each vital type

**Reasoning**: Provides meaningful insights - users can identify patterns (device always hot, battery drops quickly), spot anomalies with min/max values. More valuable than a single average.

**Trade-offs**: Slightly more complex backend logic, but better user value.

---

### Ambiguity 2: Sensor Data Retrieval Frequency
**Question**: How frequently should the app retrieve sensor data?

**Options Considered**:
- Real-time polling every few seconds
- On-demand retrieval only (manual refresh)
- Periodic background updates every 15 minutes

**Decision**: On-demand retrieval with pull-to-refresh

**Reasoning**: Assignment focuses on platform channels and backend integration. Background service is listed as "bonus" feature. No battery drain from constant polling.

**Trade-offs**: Data shows snapshots rather than continuous monitoring.

---

### Ambiguity 3: Handling Platform API Unavailability
**Question**: What should happen when native APIs are unavailable?

**Options Considered**:
- Throw error and disable functionality
- Return mock/default values
- Graceful fallback showing "Not Available"

**Decision**: Graceful fallback with clear indicators

**Reasoning**: Maintains app functionality, clearly indicates unavailable sensors, allows testing on simulators/emulators. Other working sensors remain functional.

**Trade-offs**: More complex error handling, but much better UX.

---

### Ambiguity 4: History Display Approach
**Question**: Should history support pagination or filtering?

**Options Considered**:
- Show all 100 entries at once
- Infinite scroll with lazy loading

**Decision**: Display all 100 entries in a scrollable list

**Reasoning**: Assignment specifies "latest 100 entries" - clear limitation. 100 items is manageable for mobile list view. Simpler implementation focuses on core functionality.

**Trade-offs**: No advanced filtering, but meets requirements simply.

---

## 2. Technology Stack Decisions

### Backend: Node.js + Express + SQLite

**Why this stack?**
- **Node.js**: Fast development, JavaScript familiarity
- **Express**: Industry standard, simple routing, extensive middleware
- **SQLite**:
    - Assignment suggests: "SQLite, JSON file, or simple embedded DB acceptable"
    - File-based persistence survives restarts ✓
    - Zero configuration for evaluators
    - Built-in ACID compliance
    - SQL queries enable easy analytics calculations

**Alternatives Considered**: JSON file (simpler but no concurrent safety), PostgreSQL (overkill, separate server needed)

---

### Flutter: BLoC Pattern

**Why BLoC?**
- Clear separation of concerns (UI ← State ← Events ← Logic)
- Testable business logic independently
- Repository pattern integration
- Industry best practice for Flutter

**Alternatives Considered**: Provider (less structured), Riverpod (potentially unfamiliar)

---

## 3. Project Structure

### Flutter App
```
lib/
├── core/
│   ├── base/
│   ├── config/
│   ├── constants/
│   ├── network/
│   ├── routes/
│   └── utils/
└── features/
    ├── history/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── home/
    │   ├── data/ (datasources, models, repositories)
    │   ├── domain/ (entities, repositories, usecases)
    │   └── presentation/ (bloc, view, widgets)
    └── splash/
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
└── server.js
```

**Reasoning**: Clean Architecture with feature-based organization. Controllers validate, services handle logic, repositories manage data. Testable and maintainable.

---

## 4. Key Assumptions

**User Experience**:
- Users check vitals occasionally, not continuously
- Manual refresh is acceptable
- Clear error messages are more important than hiding details

**Technical**:
- Single device per API instance - no authentication needed
- 100 entries is sufficient - no pagination required
- Timestamp validation uses server time
- Memory percentage = (Used RAM / Total RAM) × 100

**Platform**:
- Android implementation is sufficient for demonstration
- Graceful degradation when APIs unavailable

---

## 5. Questions for Product Manager

1. **"How often do users check device vitals?"** - Determines auto-refresh needs
2. **"Should we alert on overheating or low battery?"** - Passive vs active monitoring
3. **"What analytics matter most - averages, trends, anomalies?"** - Defines implementation
4. **"How many devices? How many logs per day?"** - Validates SQLite choice
5. **"How long to retain data?"** - Storage and cleanup requirements
6. **"What if sensor fails temporarily?"** - Retry logic or skip
7. **"Should app work offline?"** - Local caching core vs bonus

---

## 6. Trade-offs Summary

| Decision | Chose | Over | Reason |
|----------|-------|------|--------|
| Refresh | On-demand | Real-time | Focus on platform channels |
| Architecture | Layered | Flat | Testable, maintainable |
| State | BLoC | Provider | Better separation |
| Errors | Detailed | Generic | Better debugging |
| History | All 100 | Pagination | Simpler, meets requirement |

---

## 7. Implementation Highlights

**Native (Android)**:
- MethodChannel with Kotlin
- Thermal: `PowerManager.getCurrentThermalStatus()`
- Battery: `BatteryManager.BATTERY_PROPERTY_CAPACITY`
- Memory: `ActivityManager.MemoryInfo`

**API Validation**:
- Range checks: Thermal (0-3), Battery (0-100), Memory (0-100)
- Rejects future timestamps
- Field-specific error messages

**Analytics**:
- SQL aggregation for efficiency
- Min, max, average, standard deviation per vital
- Helps identify patterns and anomalies

---

## Conclusion

Approached each ambiguity by identifying unclear requirements, considering alternatives, making justified decisions, and documenting trade-offs. The implementation balances simplicity with functionality while demonstrating technical competence across Flutter, native platforms, and backend.