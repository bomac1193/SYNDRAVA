# ⚡ SYNDRAVA QUICK REFERENCE CARD

**One-page cheat sheet for live performance**

---

## 🎛️ CONTROL SURFACE

```
┌─────────────────────────────────────────────────────────┐
│                   ⬡ SYNDRAVA ⬡                          │
├─────────────────────────────────────────────────────────┤
│ SEQUENCER MATRIX (Click to toggle steps)               │
│ ┌──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┐    │
│ │ 1│ 2│ 3│ 4│ 5│ 6│ 7│ 8│ 9│10│11│12│13│14│15│16│ T1 │
│ │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │ T2 │
│ │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │ T3 │
│ │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │ T4 │
│ └──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┘    │
├─────────────────────────────────────────────────────────┤
│ TOUCH PLATES          │  CHAOS & AI CONTROLS           │
│ P1 P2 P3 P4 P5 P6 P7 P8  [FDBK] [CHAOS] [AI] [MORPH]  │
└─────────────────────────────────────────────────────────┘
```

---

## 🎹 MAIN CONTROLS

| Control | Range | Function |
|---------|-------|----------|
| **Feedback** | 0-95% | Amount of signal fed back into chaos network |
| **Chaos** | 0-100% | Random modulation depth (noise injection) |
| **AI Depth** | 0-100% | Dry/wet spectral processing mix |
| **Morph** | 0-100% | Spectral character/formant shift |
| **P1-P8** | 0-100% | Touch plates (modulation sources) |

---

## 🎵 WORKFLOW SHORTCUTS

### **Quick Start**
1. Load samples → Drag audio to device
2. Click sequencer steps → Light = trigger
3. Press Play in Ableton
4. Tweak Feedback/Chaos dials
5. Save preset (click floppy disk)

### **Pattern Programming**
- **Click step** = Toggle trigger
- **Shift+Click** = Parameter lock (hold Shift, adjust params)
- **Alt+Click** = Copy step
- **Ctrl+Click** = Clear step

### **Live Performance**
- **P1-P4** = Macro controls (map to anything)
- **P5-P8** = Chaos modulation sources
- **Feedback** = Rhythmic artifacts (careful > 70%)
- **AI Depth** = Spectral mangle intensity

---

## 🔊 SOUND DESIGN TIPS

### **Kick Drum**
```
Track: 1
Sample: Kick_sample.wav
Pitch: 0 (MIDI 60)
Decay: 200ms
Filter: 200Hz lowpass
P-Lock Step 1: Pitch -12 (sub)
```

### **Snare with Chaos**
```
Track: 2
Sample: Snare_sample.wav
Decay: 150ms
Filter: 2000Hz
FX Lane Step 7: Chaos burst 80%
```

### **Hi-Hat Rolls**
```
Track: 3
Trig Type: Retrig ×8
Decay: 20ms
Probability: 70%
P-Lock: Pitch random (-12 to +12)
```

### **Bass Synth**
```
Track: 4
Mode: Synthetic (cycle~)
Pitch: MIDI notes via P-Lock
Decay: 800ms
Filter: 400Hz with resonance
Encoder Depth: 60% (spectral grit)
```

---

## 🎚️ PARAMETER LOCK GUIDE

| Parameter | P-Lock Usage |
|-----------|--------------|
| **Pitch** | Melodic sequences, glitches |
| **Level** | Accent patterns, dynamics |
| **Decay** | Rhythmic variation, rolls |
| **Filter** | Timbral movement, sweeps |
| **FX Send** | Per-step routing changes |

### **How to Lock:**
1. Select step in sequencer
2. Adjust parameter (pitch/filter/etc.)
3. Value stored automatically
4. Different value per step = parameter lock

---

## 🌀 CHAOS NETWORK MODES

### **Subtle (Feedback < 30%)**
- Adds warmth and analog drift
- Slight rhythmic coloring

### **Moderate (Feedback 30-60%)**
- Rhythmic echoes
- Harmonic enhancement
- Touch plate modulation effective

### **Extreme (Feedback > 60%)**
- Semi-chaotic behavior
- Self-oscillation possible
- Use with caution (can explode!)

---

## 🧬 ENCODER BUS PRESETS

| AI Depth | Morph | Result |
|----------|-------|--------|
| 0% | Any | Dry (bypass) |
| 30% | 0% | Subtle spectral blur |
| 50% | 50% | Formant shifting |
| 80% | 80% | Heavy grain morphing |
| 100% | 100% | Extreme AI mangle |

---

## 🎭 PERFORMANCE MODES

### **Mode 1: Traditional Sequencer**
- Feedback: 0%
- Chaos: 0%
- AI Depth: 0%
- Use as normal drum machine

### **Mode 2: Analog Warmth**
- Feedback: 20%
- Chaos: 10%
- AI Depth: 15%
- Subtle analog character

### **Mode 3: Controlled Chaos**
- Feedback: 50%
- Chaos: 40%
- AI Depth: 60%
- Touch plates active
- Evolving textures

### **Mode 4: Full Ritual**
- Feedback: 75%+
- Chaos: 70%+
- AI Depth: 90%+
- Touch plates constantly moving
- Unpredictable, generative

---

## 🔥 EMERGENCY CONTROLS

| Problem | Solution |
|---------|----------|
| **Too loud!** | Reduce Feedback immediately |
| **Distorting** | Lower Chaos amount |
| **No sound** | Check Ableton track volume, verify DSP ON |
| **Glitchy** | Reduce AI Depth |
| **Too chaotic** | Reset Feedback/Chaos to 0% |

### **Reset to Safe State:**
1. Feedback → 0%
2. Chaos → 0%
3. AI Depth → 0%
4. All Touch Plates → 0%

---

## 🎯 STEP CONDITION SYMBOLS

| Symbol | Meaning |
|--------|---------|
| **●** | Normal trigger (100%) |
| **◐** | Ghost trigger (50%) |
| **○** | Trigless lock (no trigger, params only) |
| **⟳** | Retrig (multiple hits) |
| **%** | Probability (random chance) |
| **F** | Fill (only when Fill active) |
| **1:2** | Every 2nd cycle |

---

## 🗺️ SIGNAL ROUTING MAP

```
SEQUENCER
    ↓
TRACK VOICES (Sample + Synth)
    ↓
MIXER (4→2 stereo)
    ↓
FEEDBACK BUS (Chaos Network)
    ↓
ENCODER BUS (Spectral AI)
    ↓
MASTER OUT
```

### **FX Lane Routing:**
```
STEP → FX LANE DATA → SEND AMOUNTS
    ↓           ↓
  TRACK → FEEDBACK BUS
    ↓           ↓
  TRACK → ENCODER BUS
```

---

## ⚡ HOTKEYS (Inside Max)

| Key | Action |
|-----|--------|
| **E** | Edit mode (unlock for patching) |
| **L** | Lock mode (presentation view) |
| **Space** | Ableton Play/Stop |
| **Cmd/Ctrl + M** | MIDI Learn mode |
| **Cmd/Ctrl + S** | Save patch |

---

## 🎨 GENRE TEMPLATES

### **Techno**
```
Pattern: 4/4 kick every step
Snare: Steps 5, 13
Hats: 1/16 notes with probability 80%
Feedback: 25%, Chaos: 15%
```

### **IDM / Glitch**
```
Pattern: Random with euclidean (5 pulses / 16 steps)
Retrigs: Steps 4, 12 (×8 rate)
P-Locks: Random pitch on all steps
Feedback: 60%, Chaos: 70%, AI: 80%
```

### **Ambient / Drone**
```
Pattern: Sparse triggers (steps 1, 9 only)
Decay: 4000ms+
Feedback: 85% (borderline chaos)
AI Depth: 95% (heavy spectral)
Touch: Slow manual movements
```

### **Breaks / Jungle**
```
Pattern: Complex breakbeat (use retrig)
Snare: Steps 5, 13 with ±3 pitch variance
Hats: 1/16 with microtiming nudge
Feedback: 10%, Chaos: 5% (tight)
```

---

## 📱 MOBILE CONTROL (Optional)

**Using TouchOSC / Lemur:**
- Map to MIDI CC via Ableton
- P1-P8 → Faders
- Feedback/Chaos → XY Pad
- Sequencer → Button Grid

---

## 🛟 TROUBLESHOOTING

| Issue | Fix |
|-------|-----|
| No audio | Check Max DSP (bottom left, should be green) |
| Clicking sounds | Increase Ableton buffer size (Preferences → Audio) |
| High CPU | Reduce AI Depth, lower FFT size |
| Timing drift | Use plugsync~ (already implemented) |
| Crashes | Save often, reduce feedback before tweaking |

---

## 💾 PRESET NAMING CONVENTION

Use descriptive names:
- `TechnoKick_Heavy`
- `GlitchPerc_Chaos70`
- `AmbientDrone_AI90`
- `BreakSnare_Retrig`

Helps recall sounds quickly in sessions.

---

## 🔗 QUICK LINKS

- **Max for Live Docs**: docs.cycling74.com/max8/vignettes/m4l_intro
- **SYNDRAVA Repo**: (Your project folder)
- **Support**: README.md in device folder

---

**⬡ Print this page for studio reference! ⬡**

---

## 📋 SESSION CHECKLIST

Before starting a session:
- [ ] Ableton project saved
- [ ] SYNDRAVA loaded on track
- [ ] Max DSP enabled (green light)
- [ ] 4 samples loaded
- [ ] Basic pattern programmed
- [ ] Feedback/Chaos at safe levels (< 50%)
- [ ] Preset saved as default

During session:
- [ ] Save presets frequently
- [ ] Monitor CPU usage
- [ ] Experiment with touch plates
- [ ] Try parameter locks
- [ ] Record output to audio track

After session:
- [ ] Save final Ableton project
- [ ] Export favorite presets
- [ ] Bounce stems if needed
- [ ] Document cool discoveries

---

**Last updated: 2025-11-17**
**Version: 1.0 MVP**
