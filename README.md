# 🌡️ Dryer Chamber Temperature Monitor

> **Industrial Multi-Chamber Thermal Telemetry & Real-Time Monitoring System**

A resilient, scalable IoT and cloud monitoring system engineered to capture, log, and analyze real-time temperatures across multi-chamber industrial drying lines. Built around an industrial microcontroller with redundant networking (Ethernet + Wi-Fi), automated Modbus sensor polling, cloud logging, and a mobile-optimized GitHub Pages analytics dashboard.

---

## 📌 Key Capabilities

- **Multi-Chamber Real-Time Telemetry**: Continuously polls multi-channel temperature sensors across drying chambers with sub-second accuracy.
- **Redundant Industrial Connectivity**: Primary high-reliability W5500 SPI Ethernet with automatic failover to 2.4 GHz Wi-Fi.
- **Fail-Safe Network Watchdog**: Automated socket-level connection verification, non-blocking upload pipelines, and a 10-retry fail-safe watchdog reboot policy.
- **Cloud Backend Integration**: Serverless ingestion using Google Apps Script with automated status synchronization, threshold tracking, and continuous data logging.
- **Intelligent Alerting System**:
  - Upper & Lower threshold temperature warnings with visual indicators.
  - Microcontroller-level offline detection with automated email escalation (only alerts on genuine hardware outages > 30 minutes).
- **Multi-Unit Privacy & Path Isolation**:
  - Independent direct URLs for each production line/unit (`/unit1/`, `/unit2/`, etc.).
  - Complete data isolation and independent browser caching with zero cross-unit leakage.
  - Generic branding (*Dryer Chamber Temperature Monitor*) to protect internal versioning and plant specifications.
- **Advanced Dashboard & Analytics**:
  - Dynamic loading buffer with inspirational quality and precision quotes during initial telemetry synchronization.
  - Interactive temperature time-series charts (1-day, 3-day, 7-day, custom ranges).
  - Toggles for hiding offline dryers and inactive/uninstrumented chambers.
  - Offline local caching and resilient JSONP/CORS fallback for mobile browsers.
  - CSV analytics mode for historical shift comparisons and reporting.

---

## 🏗️ System Architecture

```
[ Chamber Sensors ] (RTD / Thermocouples)
         │
         ▼  (RS485 / Modbus RTU)
[ Industrial MCU ]  (ESP32 + W5500 Ethernet / Wi-Fi)
         │
         ▼  (HTTPS / REST)
[ Cloud Telemetry Engine ] (Google Apps Script + Google Sheets)
         │
         ├──► [ Real-Time Status & Event Log ]
         ├──► [ Threshold & Notification Engine ] ──► [ Email Alerts ]
         │
         ▼  (JSON / JSONP)
[ Multi-Unit Dashboard ] (GitHub Pages CDN)
         ├── /unit1/  ➔ Line 1 Live Monitor
         ├── /unit2/  ➔ Line 2 Live Monitor
         └── / (Hub)  ➔ Central Portal
```

---

## 📂 Repository Structure

```text
Dryer-Chamber-Temperature-Monitor/
│
├── index.html            # Central portal: dark-mode launcher to select units
├── add_unit.ps1          # Automation script to instantly create & configure new units
├── README.md             # Project documentation & architecture manual
│
├── unit1/
│   └── index.html        # Production Unit 1: Standalone live telemetry dashboard
│
└── (Future Units)        # e.g., unit2/, unit3/ created via add_unit.ps1
```

---

## 🌐 Live URLs & Access

When hosted on GitHub Pages (`https://<username>.github.io/<repo-name>/`), endpoints are routed automatically:

| Endpoint | Access Link | Description |
| :--- | :--- | :--- |
| **Unit 1 Dashboard** | `https://<username>.github.io/<repo>/unit1/` | Direct access to Unit 1 live monitor |
| **Unit 2 Dashboard** | `https://<username>.github.io/<repo>/unit2/` | Direct access to Unit 2 live monitor |
| **Central Portal Hub** | `https://<username>.github.io/<repo>/` | Unified portal to navigate between units |

---

## ➕ Adding New Units (Automated)

To spin up a new monitoring dashboard for a new production unit, open PowerShell in the repository folder and run:

```powershell
.\add_unit.ps1 -UnitNumber 2 -GasUrl "https://script.google.com/macros/s/YOUR_NEW_APPS_SCRIPT_URL/exec"
```

### What this does:
1. Creates the `unit2/` folder.
2. Generates `unit2/index.html` configured specifically with the new unit's backend API URL.
3. Automatically links **Unit 2** in the central `index.html` portal hub.
4. Simply commit and push to GitHub to go live!

---

## ⚙️ Hardware Specifications

- **Controller**: Espressif ESP32 / ESP32-S3 (Dual-Core 240 MHz)
- **Ethernet Module**: WIZnet W5500 SPI Ethernet Controller
- **Sensor Bus**: RS485 Transceiver (MAX485 / SP3485) with Modbus RTU protocol
- **Local Display**: 20x4 I2C Character LCD with dynamic diagnostic screens
- **Power Supply**: 24V DC to 5V DC step-down industrial buck converter
- **Watchdogs**: Hardware Timer Watchdog + Network Ping Watchdog (8.8.8.8:53 socket test)

---

## 🛡️ Telemetry & Watchdog Safeguards

1. **Non-Gated Data Transmissions**: Ingestion pipelines continuously attempt uploads whenever a local IP is assigned, ensuring transient connectivity issues never block sensor acquisition.
2. **Direct Socket Health Checks**: Validates internet routing via raw TCP handshakes to Google DNS (`8.8.8.8:53`), bypassing fragile DNS caching.
3. **Threshold Fail-Safe Recovery**: If threshold/configuration synchronization fails 10 consecutive times (~5 minutes), the microcontroller initiates an automatic reboot cycle (`ESP.restart()`) to recover the peripheral network stack.
4. **Intelligent Offline Escalation**: Prevents false alarms from idle meters. Alert emails trigger exclusively when the entire microcontroller halts transmissions for more than 30 minutes, followed by an automatic restoration confirmation upon recovery.

---

## 📄 License & Confidentiality

Internal industrial automation project. All rights reserved. Code and telemetry configurations are customized for continuous industrial chamber monitoring.
