# 📦 SYNDRAVA INSTALLATION & SETUP GUIDE

Complete step-by-step installation for all platforms.

---

## 🖥️ SYSTEM REQUIREMENTS

### **Minimum:**
- **Ableton Live**: 11.0 or higher (Suite or Standard with Max for Live)
- **Max/MSP**: 9.0+ (included with Live Suite)
- **OS**: macOS 10.13+, Windows 10+, or Linux (experimental)
- **CPU**: Intel i5 / AMD Ryzen 5 or better
- **RAM**: 8GB minimum
- **Audio Interface**: Any Core Audio/ASIO compatible

### **Recommended:**
- **Ableton Live**: 11.3+ or 12+
- **CPU**: Intel i7 / AMD Ryzen 7 / Apple Silicon M1+
- **RAM**: 16GB+
- **Audio Buffer**: 256-512 samples (balance latency/CPU)
- **Sample Rate**: 44.1kHz or 48kHz

---

## 📥 INSTALLATION METHODS

### **Method 1: Manual Installation (Recommended)**

#### **macOS:**
```bash
# Copy the .amxd file to User Library
cp SYNDRAVA.amxd ~/Music/Ableton/User\ Library/Presets/Instruments/Max\ Instrument/

# Copy support files
cp p_spectral_blur.maxpat ~/Music/Ableton/User\ Library/Presets/Instruments/Max\ Instrument/
```

#### **Windows:**
```powershell
# Copy the .amxd file to User Library
copy SYNDRAVA.amxd "%USERPROFILE%\Documents\Ableton\User Library\Presets\Instruments\Max Instrument\"

# Copy support files
copy p_spectral_blur.maxpat "%USERPROFILE%\Documents\Ableton\User Library\Presets\Instruments\Max Instrument\"
```

#### **Linux (WSL/Wine):**
```bash
# Via Windows subsystem
cp SYNDRAVA.amxd /mnt/c/Users/<username>/Documents/Ableton/User\ Library/Presets/Instruments/Max\ Instrument/
```

---

### **Method 2: Drag & Drop Installation**

1. Open Ableton Live
2. Open the **Browser** (left sidebar)
3. Navigate to **Places → User Library**
4. Create folder: **Max Instrument** (if it doesn't exist)
5. **Drag SYNDRAVA.amxd** into the Max Instrument folder
6. **Drag p_spectral_blur.maxpat** into the same folder
7. The device will appear in Browser → Max Instrument

---

### **Method 3: Project-Specific Installation**

Keep SYNDRAVA in your project folder:

1. Create a folder in your project: `<ProjectName>/Max Devices/`
2. Copy SYNDRAVA.amxd and support files there
3. Drag directly from Finder/Explorer onto a MIDI track
4. Save project (device will be embedded)

**Pros**: Portable, project-specific
**Cons**: Not available globally

---

## 🎛️ FIRST-TIME SETUP

### **Step 1: Load the Device**

1. Open **Ableton Live**
2. Create a new **MIDI Track** (Cmd/Ctrl + T)
3. Navigate to **Browser → Max for Live → Max Instrument**
4. **Double-click SYNDRAVA.amxd** (or drag to track)
5. Wait for Max to initialize (5-10 seconds)

**You should see:**
- The SYNDRAVA UI loads
- Max DSP indicator turns **green** (bottom left)
- No error messages in Max console

---

### **Step 2: Verify Audio Output**

1. Click the **Max window icon** (top right of SYNDRAVA)
2. Verify **Audio is ON** (should show green indicator)
3. If red, click **Audio ON** button
4. Close Max window

**Test audio:**
1. Click a step in the sequencer (step 1, track 1)
2. Press **Play** in Ableton
3. You should hear a default synth sound (cycle~ @ 220Hz)

---

### **Step 3: Load Sample Files**

#### **Drag & Drop Method:**
1. Open Finder/Explorer
2. Find a drum sample (kick.wav, snare.wav, etc.)
3. **Drag the audio file** onto the SYNDRAVA device
4. It will load into the first available track buffer

#### **Manual Buffer Loading (Advanced):**
1. Click **Max window icon** → Edit mode (press **E**)
2. Find **buffer~ track1buf**
3. Double-click buffer~ object
4. Click **Read** → select your sample
5. Lock device (press **L**)

**Supported formats:**
- WAV, AIFF (recommended)
- MP3, M4A (converted on load)
- Mono or stereo (downmixed to mono per track)

---

### **Step 4: Program Your First Pattern**

1. Click cells in the **16-step matrix**:
   - **Row 1** (Track 1): Click steps **1, 5, 9, 13** (kick pattern)
   - **Row 2** (Track 2): Click steps **5, 13** (snare)
   - **Row 3** (Track 3): Click steps **3, 7, 11, 15** (hats)

2. Press **Play** in Ableton
3. You should hear a basic 4/4 pattern

---

### **Step 5: Save Your First Preset**

1. Click the **floppy disk icon** (pattrstorage)
2. Type a name: `MyFirstPattern`
3. Press Enter
4. Preset saved! (loads with Ableton project)

---

## 🔧 TROUBLESHOOTING INSTALLATION

### **Device Won't Load**

**Symptom**: SYNDRAVA.amxd appears, but UI doesn't load

**Fix:**
1. Check Max/MSP is installed (comes with Live Suite)
2. Update Max: `Help → Check for Updates` in Max standalone
3. Verify file integrity (re-download SYNDRAVA.amxd)

---

### **No Audio Output**

**Symptom**: Sequencer running, but no sound

**Fix:**
1. Click Max window icon → check **Audio is ON**
2. Verify Ableton track **volume fader** is up
3. Check Ableton **Master volume**
4. Verify **monitor is set to AUTO or IN**
5. Check sample buffer loaded: Double-click `buffer~` object

---

### **"Can't find p_spectral_blur.maxpat"**

**Symptom**: Error in Max console

**Fix:**
1. Copy `p_spectral_blur.maxpat` to same folder as SYNDRAVA.amxd
2. Or place in Max search path:
   - macOS: `~/Documents/Max 9/Library/`
   - Windows: `%USERPROFILE%\Documents\Max 9\Library\`

---

### **High CPU Usage**

**Symptom**: Ableton CPU meter high, audio dropouts

**Fix:**
1. Increase **buffer size**: `Preferences → Audio → Buffer Size → 512`
2. Reduce **AI Depth** to 0% (disables spectral processing)
3. Reduce **Feedback** to 0% (disables chaos network)
4. Close Max window (reduces UI redraw overhead)

---

### **Clicks/Pops in Audio**

**Symptom**: Digital artifacts, glitches

**Fix:**
1. Increase **buffer size** (see above)
2. Reduce **sample rate**: 48kHz → 44.1kHz
3. Disable other plugins (isolate SYNDRAVA)
4. Check for disk I/O issues (samples on external drive?)

---

### **Max Console Shows Errors**

**Symptom**: Red text in Max console

**Common errors:**

| Error | Cause | Fix |
|-------|-------|-----|
| `buffer~: no such buffer` | Sample not loaded | Drag audio file to device |
| `pfft~: can't find subpatch` | Missing p_spectral_blur | Copy support file |
| `dict: no such dictionary` | Preset data missing | Create new preset |
| `pattrstorage: read failed` | Corrupted preset | Delete preset, recreate |

---

## 🎨 CUSTOMIZING THE INTERFACE

### **Resize the Device Window**

1. Click **Max window icon** (top right)
2. Press **E** (edit mode)
3. Adjust presentation rectangle:
   - Select `panel` object
   - Inspector → Presentation Rectangle
   - Change width/height (default: 1024×600)
4. Press **L** (lock) to save

---

### **Change Colors**

1. Edit mode (press **E**)
2. Select UI object (live.slider, panel, etc.)
3. Inspector → Appearance
   - Background Color
   - Element Color
   - Border Color
4. Lock (press **L**)

**SYNDRAVA default theme:**
- Background: `RGB(0.1, 0.1, 0.12)`
- Accent: `RGB(0.7, 0.3, 0.9)` (purple)
- Border: `RGB(0.5, 0.2, 0.7)`

---

### **Add More Touch Plates**

1. Edit mode
2. Copy `live.slider` object (P1-P8)
3. Paste, rename to P9, P10, etc.
4. Route outlets to parameters
5. Save

---

## 🗂️ FILE ORGANIZATION

### **Recommended Project Structure:**

```
MyProject/
├── MyProject.als (Ableton project)
├── Samples/
│   ├── Drums/
│   │   ├── kick_01.wav
│   │   ├── snare_02.wav
│   │   ├── hat_03.wav
│   └── Synths/
│       ├── bass_stab.wav
│       └── chord_loop.wav
├── Max Devices/
│   ├── SYNDRAVA.amxd
│   └── p_spectral_blur.maxpat
└── Documentation/
    ├── README.md
    ├── QUICK_REFERENCE.md
    └── presets.txt (notes on saved presets)
```

---

## 📚 LEARNING PATH

### **Week 1: Basics**
- [ ] Install and verify audio
- [ ] Load 4 samples
- [ ] Program simple 16-step patterns
- [ ] Experiment with Feedback/Chaos at low levels (< 30%)
- [ ] Save 5 basic presets

### **Week 2: Sequencer Mastery**
- [ ] Learn parameter locks (pitch, filter, decay)
- [ ] Try conditional trigs (probability, fill)
- [ ] Use retrig for drum rolls
- [ ] Explore FX lane (per-step routing)

### **Week 3: Sound Design**
- [ ] Dive into Encoder Bus (AI Depth, Morph)
- [ ] Push Feedback into chaos territory (60%+)
- [ ] Modulate with touch plates
- [ ] Create evolving textures

### **Week 4: Performance**
- [ ] Map MIDI controller to parameters
- [ ] Practice live pattern switching
- [ ] Record long generative sessions
- [ ] Resample output back into tracks

---

## 🎓 RECOMMENDED RESOURCES

### **Max/MSP Learning:**
- Cycling '74 Tutorials: [docs.cycling74.com/max8/tutorials](https://docs.cycling74.com/max8/tutorials)
- Amazing Max Stuff: [amazingmaxstuff.com](http://www.amazingmaxstuff.com)
- Delicious Max Tutorials (YouTube)

### **Max for Live:**
- Ableton Max for Live Intro: [ableton.com/en/manual/max-for-live](https://www.ableton.com/en/manual/max-for-live/)
- Darwin Grosse's 20 Objects series
- Cycling '74 Forum: [cycling74.com/forums](https://cycling74.com/forums)

### **Spectral Processing:**
- FFT in Max: [docs.cycling74.com/max8/vignettes/fftspectral](https://docs.cycling74.com/max8/vignettes/fftspectral)
- pfft~ examples in Max

---

## 🔄 UPDATING SYNDRAVA

When a new version is released:

1. **Backup current version**:
   ```bash
   cp SYNDRAVA.amxd SYNDRAVA_v1.0_backup.amxd
   ```

2. **Copy new version** to User Library

3. **Reopen Ableton project**

4. **Reload device** (double-click in browser)

5. **Test presets** (may need re-saving)

---

## 🛡️ BACKUP & RECOVERY

### **Backup Presets:**

1. Locate pattrstorage file:
   - macOS: `~/Music/Ableton/User Library/Presets/`
   - Windows: `%USERPROFILE%\Documents\Ableton\User Library\Presets\`

2. Copy `.json` preset files to safe location

### **Export Dict Data:**

1. Open Max window (edit mode)
2. Right-click `dict pattern_locks`
3. Select **Export JSON**
4. Save to backup folder

### **Restore from Backup:**

1. Copy preset files back to User Library
2. Reload SYNDRAVA
3. Presets should appear in pattrstorage menu

---

## 🎯 GETTING HELP

### **Check These First:**
1. **README.md** (full documentation)
2. **QUICK_REFERENCE.md** (cheat sheet)
3. **ADVANCED_CUSTOMIZATION.md** (hacking guide)

### **Community Support:**
- Cycling '74 Forum: Max for Live category
- r/maxmsp subreddit
- Ableton Forum: Max for Live section

### **Reporting Bugs:**
Include:
- Ableton version
- Max version
- OS version
- Steps to reproduce
- Max console errors (if any)

---

## ✅ POST-INSTALLATION CHECKLIST

- [ ] SYNDRAVA.amxd in User Library
- [ ] p_spectral_blur.maxpat in same folder
- [ ] Device loads without errors
- [ ] Max DSP is ON (green indicator)
- [ ] Audio output works
- [ ] 4 sample buffers loaded
- [ ] Basic pattern programmed
- [ ] First preset saved
- [ ] Documentation files accessible
- [ ] Ready to create!

---

**⬡ Installation complete — let the ritual begin! ⬡**

**Version**: 1.0 MVP
**Last Updated**: 2025-11-17
**Author**: Claude Code (AI Assistant)
