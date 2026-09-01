# 🏭 Multi-Unit Dryer Monitor — GitHub Pages Deployment

This repository is structured so that **each plant/product unit gets its own unique, private web link** while hosted under a single GitHub repository.

---

## 🌐 How Your Links Work

Once deployed on GitHub Pages (`https://<username>.github.io/<repo-name>/`), you have:

| Destination | Live Web Link | Description |
| :--- | :--- | :--- |
| **Unit 1 Direct** | `https://<username>.github.io/<repo-name>/unit1/` | Direct link to Unit 1 dashboard |
| **Unit 2 Direct** | `https://<username>.github.io/<repo-name>/unit2/` | Direct link to Unit 2 dashboard |
| **Portal Hub** | `https://<username>.github.io/<repo-name>/` | Central portal to switch between units |

> **Privacy & Isolation:**
> - Each unit connects strictly to its own Google Sheet / Apps Script deployment.
> - Browser storage is isolated per path (Unit 1 will never overwrite Unit 2's settings).
> - Every unit's dashboard is titled generically: **`DRYER CHAMBER TEMPERATURE MONITOR`** — no version numbers, firmware models, or internal plant names are exposed.

---

## 🚀 Step-by-Step Setup Guide

### Step 1: Create a GitHub Repository
1. Log in to [GitHub](https://github.com).
2. Click **`+`** (top right) ➔ **New repository**.
3. Name it: `dryer-monitor` (or any name you prefer).
4. Select **Public** (required for free GitHub Pages).
5. Click **Create repository**.

### Step 2: Upload Files to GitHub
1. In your new repository, click **Add file** ➔ **Upload files**.
2. Upload the entire contents of this `github_units_repo` folder:
   - `index.html` (the root portal)
   - `unit1/` folder (containing `index.html` for Unit 1)
3. Click **Commit changes**.

### Step 3: Enable GitHub Pages
1. Go to repository **Settings** (top menu).
2. On the left sidebar, click **Pages** (under *Code and automation*).
3. Under **Build and deployment** ➔ **Branch**:
   - Select **`main`** (or `master`).
   - Folder: **`/ (root)`**.
   - Click **Save**.
4. Wait ~30–60 seconds, then refresh. Your site will be live at:
   ```text
   https://<your-username>.github.io/<repo-name>/unit1/
   ```

---

## ➕ How to Add Unit 2, Unit 3, etc. (Automated)

Whenever you add a new unit in the future, simply run this single command in PowerShell from the `github_units_repo` folder:

```powershell
.\add_unit.ps1 -UnitNumber 2 -GasUrl "https://script.google.com/macros/s/YOUR_NEW_APPS_SCRIPT_URL/exec"
```

### What this command does automatically:
1. Creates the `unit2/` folder.
2. Generates `unit2/index.html` pre-configured with that unit's Google Apps Script URL.
3. Adds the **Unit 2** button to the central `index.html` portal.
4. All you do is commit & push the changes to GitHub!
