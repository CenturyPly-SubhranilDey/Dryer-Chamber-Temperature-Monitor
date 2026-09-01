# 📘 Field Installation & Setup Guide — Unit 1
### Dryer Chamber Temperature Monitor (Guwahati Plant)

> **Live Dashboard URL**:  
> 🔗 [**https://centuryply-subhranildey.github.io/Dryer-Chamber-Temperature-Monitor/unit1/**](https://centuryply-subhranildey.github.io/Dryer-Chamber-Temperature-Monitor/unit1/)  
> *(Bookmark this link on mobile phones and control room PCs)*

---

## 📋 Summary of What You Need To Do

All internal electronics (ESP32 controller, 5V power supply, MAX485 communication module, 20x4 LCD display, status LED bar, and relay modules) are **already fully assembled and pre-wired**.

The local installation team only needs to complete **5 simple steps**:
1. **Physical Mounting**: Screw junction box backside to wall/panel board.
2. **Power Supply**: Connect 220V AC mains to the **Red & Black** wires.
3. **Alarm Beacon**: Wire the **Kosmos rotating warning light** to the top connector.
4. **Sensors**: Connect the **RTD (PT-100 3-Wire)** chamber sensors to the **Multispan MS-1208-M1** meter.
5. **Network**: Plug in **Ethernet cable** OR connect via **Wi-Fi Hotspot**.

---

## 🛠️ Step 1: Mechanical Mounting

1. The junction box is designed for quick, clean installation:
   - **Front cover / door**: Contains the circuit board, controller, LCD screen, and switches.
   - **Back base**: Completely blank with pre-molded mounting holes.
2. **To install**:
   - Open the box by loosening the front corner screws.
   - Place the empty back base against your panel board or wall.
   - Secure the back base firmly using mounting screws.
   - Once wiring (Steps 2, 3 & 4) is routed through the cable glands, screw the front cover back onto the base.

---

## ⚡ Step 2: Main Power Connection (220V AC)

Inside the box, two main AC power input wires are brought out:
* **RED Wire** ➔ **220V AC Phase / Line (L)**
* **BLACK Wire** ➔ **220V AC Neutral (N)**

> **Safety Note**: Ensure mains power is switched OFF before making connections. Once connected, flip the power switch on the unit to **ON**. The LCD screen will light up.

---

## 🚨 Step 3: Alarm Warning Light (Kosmos Rotating Light)

* On the **top side of the junction box**, there is an external terminal connector provided specifically for the alarm.
* Connect the two wires from your **Kosmos rotating beacon light** directly to this top connector.
* When temperature exceeds safety thresholds or communication is interrupted, the internal relay triggers this light automatically.

---

## 🌡️ Step 4: RTD Temperature Sensor Wiring (Multispan MS-1208-M1)

> **Important**: The internal RS485 communication wires (Terminals 16 & 17) to the microcontroller are **already wired**. Do NOT disconnect them.

Connect your **PT-100 (3-Wire RTD)** sensors from each dryer chamber to the meter terminals according to the table below:

### 3-Wire RTD Connection Table

| Chamber | Meter Channel | Terminal (+) | Terminal (Comp) | Terminal (-) |
| :---: | :---: | :---: | :---: | :---: |
| **Chamber 1** | CH-1 | **Terminal 1** | **Terminal 2** | **Terminal 3** |
| **Chamber 2** | CH-2 | **Terminal 4** | **Terminal 5** | **Terminal 6** |
| **Chamber 3** | CH-3 | **Terminal 7** | **Terminal 8** | **Terminal 9** |
| **Chamber 4** | CH-4 | **Terminal 10** | **Terminal 11** | **Terminal 12** |
| **Chamber 5** | CH-5 | **Terminal 13** | **Terminal 14** | **Terminal 15** |
| **Chamber 6** | CH-6 | **Terminal 18** | **Terminal 19** | **Terminal 20** |
| **Chamber 7** | CH-7 | **Terminal 21** | **Terminal 22** | **Terminal 23** |
| **Chamber 8** | CH-8 | **Terminal 24** | **Terminal 25** | **Terminal 26** |

### 🔍 How to Identify 3-Wire RTD Leads:
* Standard 3-Wire PT-100 cables have:
  * **Two wires of the same color** (usually Red & Red, or White & White).
  * **One wire of a different color** (usually White, or Red).
* **Connection Rule**:
  * The **single different color** wire goes to the **(+) terminal** (e.g. Terminal 1).
  * The **two same color** wires go to the remaining two terminals (e.g. Terminals 2 and 3).

### ⏭️ If Your Dryer Has Fewer Chambers (e.g. 6 Chambers):
* If your dryer has only 6 chambers, wire Chambers 1 to 6.
* On the Multispan meter front panel, press the **SKIP** button for **Channel 7** and **Channel 8**.
* The meter will now continuously scan only Channels 1 through 6.
* The online web dashboard automatically detects this and hides unused chambers by default.

---

## 🌐 Step 5: Network Connection (Ethernet or Wi-Fi)

The unit features dual networking. You can use either Ethernet or Wi-Fi.

### Option A: Ethernet Cable (Recommended)
1. If an RJ45 LAN cable connected to your plant network with internet is available on the shop floor, simply plug it into the **Ethernet RJ45 port** on the unit.
2. The unit will automatically obtain an IP address via DHCP.
3. The LCD screen will display `ETH CONNECTED` and show the IP address.
4. It will immediately begin uploading live temperature data to the cloud!

---

### Option B: Wi-Fi Hotspot Configuration
Since this unit was tested in Chennai before dispatch, it currently has Chennai Wi-Fi credentials stored in memory.

Follow these simple steps to connect it to your Guwahati plant Wi-Fi:

1. **Power ON the unit without an Ethernet cable plugged in.**
2. The unit will attempt to scan and connect to its old Wi-Fi. It will try **4 times** (takes about 30–40 seconds).
3. After 4 failed attempts, the unit automatically switches into **AP Hotspot Mode**.
   - The LCD display will show:
     ```text
     HOTSPOT ACTIVE
     SSID: Dryer-Monitor-Setup
     ```
4. **Connect via Mobile Phone or Laptop**:
   - Open Wi-Fi settings on your phone/laptop.
   - Connect to the Wi-Fi network named:  
     👉 **`Dryer-Monitor-Setup`**
   - Enter Password:  
     👉 **`12345678`**
5. **Configure Plant Wi-Fi**:
   - Open Google Chrome or Safari and visit:  
     👉 **`http://192.168.4.1`**
   - Click **Scan Networks**.
   - Select your Guwahati plant 2.4 GHz Wi-Fi network from the dropdown.
   - Enter your plant Wi-Fi password and tap **Save & Connect**.
6. The unit will save the credentials to its permanent memory, reboot, connect to your plant Wi-Fi, and begin continuous telemetry transmission!

---

## 📱 Viewing the Live Dashboard

Once the network is connected:
1. Open any web browser on your phone, tablet, or control room desktop:
   👉 **`https://centuryply-subhranildey.github.io/Dryer-Chamber-Temperature-Monitor/unit1/`**
2. The dashboard will load instantly (under 0.5s) from GitHub Pages:
   - Live temperatures for each chamber with color-coded status.
   - Real-time time series charts.
   - Offline / Inactive chamber toggles.
   - Shift temperature analytics and automated alarm logging.

---

## 📞 Support & Troubleshooting Quick Reference

| Issue / Symptom | Possible Cause | Action |
| :--- | :--- | :--- |
| **LCD shows `METER COMM ERR`** | RS485 polarity inverted or loose | Check meter terminals 16 (D-) & 17 (D+). Ensure meter power is ON. |
| **One chamber reads `---` or `OPEN`** | RTD wire disconnected or broken | Check wiring on that channel's terminals. Verify RTD 3-wire continuity. |
| **Hotspot `Dryer-Monitor-Setup` not visible** | Still trying Chennai Wi-Fi (first 40s) | Wait 45 seconds after powering ON for the 4 retries to complete. |
| **Dashboard says `CONNECTING TO SHEET`** | Plant network has restricted internet | Ensure plant Wi-Fi/LAN firewall allows HTTPS outbound traffic. |
