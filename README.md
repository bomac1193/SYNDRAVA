# ⬡ S Y N D R A V A ⬡

**Chaotic AI Drum Brain • Touch • Feedback • Spectral Morphing**

A Max for Live hybrid drum machine/sampler/AI-inspired sound engine combining:
- **SOMA Enner** (touch plates, chaos, feedback routing)
- **Elektron Monomachine** (trigs, parameter locks, FX lane)
- **Elektron Digitakt II** (sample workflow)
- **SOMA Pulsar-23** (burst generators, pulses)
- **AI/Spectral Processing** (RAVE-inspired granular/spectral morphing)

---

## 🔥 SYSTEM ARCHITECTURE

### **4 TRACKS** (Expandable to 8)
Each track features:
- **Dual voice architecture**: Sample playback (groove~) + Synthetic voice (FM/noise/cycle~)
- **Independent envelope** (ADSR~)
- **SVF filter** (lowpass with cutoff/resonance)
- **Parameter lockable controls**: Pitch, Level, Decay, Filter, FX Sends
- **Buffer~ sample loading** (10 seconds per track)

### **16-STEP SEQUENCER** with Parameter Locks
- **Step matrix** (4 tracks × 16 steps)
- **Parameter lock dictionary** per step
- **Trig types**: Normal, Ghost, Trigless Lock, Retrig
- **Conditional trigs**: Probability, Fill, 1:2, 1:4, 2:4
- **Microtiming nudge**
- **Velocity per step**

### **ENNER TOUCH SURFACE**
8 interactive touch plates (live.slider objects):
- **P1-P8**: Modulation sources for chaos/routing/parameters
- Touch/drag to generate control signals
- Can modulate:
  - Track parameters
  - Feedback depth
  - Chaos amount
  - Spectral processing
  - FX routing

### **FEEDBACK BUS** (Chaos Network)
Enner-inspired feedback loop with:
- **Dual delay lines** (2000ms/2300ms L/R)
- **Ring modulation** (cycle~ @ 37Hz)
- **Chaos injection** (noise~ modulated by touch plates)
- **SVF lowpass filter** (800Hz, Q=0.9)
- **Tanh~ saturation** (analog-style drive)
- **Feedback amount** dial (0-0.95)
- **Chaos amount** dial (0-1.0)

### **ENCODER BUS** (AI-Inspired Spectral Processing)
Simulated RAVE-style processing:
- **pfft~ spectral blur** (2048 FFT size, 4× overlap)
- **Granular delay** (441/661 samples L/R for grain motion)
- **Encoder Depth** control (dry/wet mix)
- **Spectral Morph** (formant warping simulation)
- Can process all tracks or per-track sends

### **FX LANE** (Monomachine-style)
Per-step automation lane:
- **FX A Send** (delay/reverb)
- **FX B Send** (spectral/granular)
- **Feedback Send** (chaos injection)
- **Chaos Burst** (trigger instability)
- Stored in `dict fx_lane_data`

### **STATE STORAGE**
- **pattrstorage** object (`syndrava`)
- Saves with Ableton set:
  - Sequencer patterns
  - Parameter locks
  - Touch plate states
  - Sample references
  - Routing states

---

## 📦 INSTALLATION

### **1. Copy the .amxd file**
```bash
cp SYNDRAVA.amxd ~/Music/Ableton/User\ Library/Presets/Instruments/Max\ Instrument/
```
Or place in any Ableton User Library location.

### **2. Load in Ableton Live**
1. Open Ableton Live 11+ (Suite or Standard with Max for Live)
2. Navigate to **Browser → Max for Live → Max Instrument**
3. Drag **SYNDRAVA.amxd** onto a MIDI track
4. Wait for Max to initialize (check bottom left corner)

### **3. Verify DSP is running**
- Click the Max window icon in SYNDRAVA
- Audio should be ON (green audio status)

---

## 🎹 HOW TO USE

### **BASIC WORKFLOW**

#### **1. LOAD SAMPLES**
- Drag audio files onto the device
- Samples load into `buffer~ track1buf`, `track2buf`, etc.
- Each buffer holds up to 10 seconds (44.1kHz)

#### **2. PROGRAM SEQUENCER**
- Click cells in the **16-step matrix**
- **Row** = Track (1-4)
- **Column** = Step (1-16)
- Lit cells = active triggers

#### **3. ADJUST TOUCH PLATES**
- **P1-P8 sliders** on the right side
- Drag to modulate:
  - Feedback depth
  - Chaos amount
  - Filter cutoff
  - Spectral morph

#### **4. CONTROL FEEDBACK**
- **Feedback dial**: Amount of signal fed back (0-95%)
- **Chaos dial**: Random modulation depth (0-100%)
- Touch plates interact with feedback network

#### **5. SHAPE WITH ENCODER BUS**
- **AI Depth dial**: Dry/wet spectral processing
- **Morph dial**: Spectral character/formant shift
- Creates RAVE-like textural transformations

#### **6. AUTOMATE FX LANE**
- FX lane stores per-step routing changes
- Modulate sends to feedback/encoder busses
- Trigger chaos bursts on specific steps

---

## 🧬 ADVANCED FEATURES

### **PARAMETER LOCKS**
Each step can lock parameters:
1. Select a step in the sequencer
2. Adjust track parameters (pitch, level, decay, filter)
3. Values stored in `dict pattern_locks`
4. Per-step override of global parameters

### **TRIG TYPES**
**Normal**: Standard trigger
**Ghost**: Quiet trigger (50% velocity)
**Trigless Lock**: Parameter change without trigger
**Retrig**: Rapid repeating trigger (rate/count lockable)

### **CONDITIONAL TRIGS**
**Probability**: 0-100% chance per step
**Fill**: Only fires when Fill button is active
**1:2**: Every 2nd cycle
**1:4**: Every 4th cycle
**2:4**: 2 out of 4 cycles

### **CHAOS NETWORK ROUTING**
Touch plates → Feedback Bus → Chaos Injection → Ring Mod → Filter → Saturation → Output

The feedback can:
- Self-oscillate (careful with feedback dial!)
- Generate rhythmic artifacts
- Create harmonic distortion
- Produce semi-random modulation

### **SPECTRAL MORPHING**
Encoder Bus signal flow:
1. Input → **pfft~ spectral blur** (frequency smearing)
2. **Granular delay** (time-domain microshifts)
3. **Morph control** (spectral tilt/formant shift)
4. **Encoder Depth** (dry/wet crossfade)

Simulates AI latent space interpolation through spectral manipulation.

---

## 🗄️ SUB-PATCHER STRUCTURE

### **p main_engine**
Top-level signal flow and UI presentation

### **p sequencer**
- Step matrix (matrixctrl 4×16)
- Parameter lock dictionary
- Trig condition logic

### **p track1 / track2 / track3 / track4**
Individual track voice engines:
- `buffer~` sample storage
- `groove~` sample playback
- `cycle~` synthetic oscillator
- `adsr~` envelope
- `svf~` filter
- `*~` VCA/mixer

**Inlets**:
1. Trigger (bang)
2. Pitch (0-127 MIDI / float multiplier)
3. Level (0-1)
4. Decay (ms)
5. Sample (buffer name)

**Outlets**:
1. Audio L
2. Audio R

### **p enner_surface**
8 live.slider touch plates (P1-P8)

**Outlets**: 8 float streams (0-1)

### **p feedback_bus**
Chaos feedback network

**Inlets**:
1. Audio L
2. Audio R

**Outlets**:
1. Processed L
2. Processed R

**Controls**:
- Feedback amount (0-0.95)
- Chaos amount (0-1.0)

### **p encoder_bus**
AI-inspired spectral processor

**Inlets**:
1. Audio L
2. Audio R

**Outlets**:
1. Spectral L
2. Spectral R

**Controls**:
- Encoder Depth (dry/wet)
- Spectral Morph (formant shift)

### **p fx_lane**
Per-step routing automation

**Inlet**: Step number (0-15)

**Outlets**:
1. FX A Send (0-1)
2. FX B Send (0-1)
3. Feedback Send (0-1)
4. Chaos Burst (0-1)

### **p mixer**
Final stereo bus mixer (8 inputs → 2 outputs)

---

## 🎛️ CONTROL SURFACE LAYOUT

```
┌─────────────────────────────────────────────────────────────────┐
│                    ⬡ S Y N D R A V A ⬡                          │
│      Chaotic AI Drum Brain • Touch • Feedback • Spectral       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  SEQUENCER (16 steps × 4 tracks)                               │
│  ┌──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┐           │
│  │01│02│03│04│05│06│07│08│09│10│11│12│13│14│15│16│  Track 1  │
│  ├──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┤           │
│  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  Track 2  │
│  ├──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┤           │
│  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  Track 3  │
│  ├──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──┤           │
│  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  Track 4  │
│  └──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┘           │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│  ENNER SURFACE                    CHAOS & AI CONTROLS          │
│  ┌──┬──┬──┬──┬──┬──┬──┬──┐       ┌────────┬────────┬────────┐│
│  │P1│P2│P3│P4│P5│P6│P7│P8│       │Feedback│ Chaos  │AI Depth││
│  │  │  │  │  │  │  │  │  │       │  Amt   │  Amt   │ / Morph││
│  │  │  │  │  │  │  │  │  │       └────────┴────────┴────────┘│
│  └──┴──┴──┴──┴──┴──┴──┴──┘                                    │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔧 TECHNICAL SPECIFICATIONS

**Sample Rate**: 44.1kHz / 48kHz (follows Ableton project)
**Bit Depth**: 32-bit float (Max/MSP internal)
**FFT Size**: 2048 (encoder bus)
**FFT Overlap**: 4×
**Buffer Size**: 10 seconds @ 44.1kHz per track
**Polyphony**: 4 voices (1 per track)
**Latency**: ~5ms (pfft~ processing + buffer latency)
**CPU Usage**: Moderate (depends on spectral processing depth)

---

## 🎨 DESIGN PHILOSOPHY

SYNDRAVA is not a traditional drum machine. It is a **ritualistic sound instrument** where:

1. **Chaos is intentional** — Feedback and touch plates introduce controlled randomness
2. **Routing is performance** — FX lane changes the signal path per step
3. **AI is simulated** — Spectral processing mimics neural encoding without ML inference
4. **Touch is expressive** — Enner-style plates make static sequences dynamic
5. **Sequencer is alive** — Parameter locks and conditionals create evolving patterns

---

## 🚀 WORKFLOW TIPS

### **Creating Evolving Patterns**
1. Program basic 16-step pattern
2. Add parameter locks to steps 4, 8, 12 (pitch/filter changes)
3. Set FX lane to boost encoder depth on steps 5, 13
4. Modulate feedback with touch plates in real-time
5. Add chaos bursts on steps 7, 15 for rhythmic artifacts

### **Building Chaotic Textures**
1. Load noisy/percussive samples
2. Set high feedback (0.7-0.9)
3. Increase chaos amount (0.5+)
4. Modulate touch plates rapidly
5. Use encoder bus morph to smear frequencies

### **Pulsar-23 Style Bursts**
1. Use retrig trig type on steps
2. Set high retrig rate (8-16 repeats)
3. Short decay envelopes (<50ms)
4. Modulate pitch per retrig with parameter locks
5. Add chaos burst in FX lane

### **Sample-Based Workflows**
1. Drag drum hits onto tracks
2. Use groove~ start/length for slicing
3. Pitch parameter locks for melodic sequences
4. Encoder bus for spectral mangling
5. Feedback bus for rhythmic echoes

---

## 📝 KNOWN LIMITATIONS (MVP VERSION)

This is a **Minimum Viable Product** demonstrating core concepts. Future enhancements:

- [ ] Full 8-track expansion
- [ ] Visual step editor with parameter lock UI
- [ ] More trig conditions (euclidean, ratcheting)
- [ ] Per-track FX sends (currently global)
- [ ] MIDI CC mapping for hardware controllers
- [ ] Preset management system
- [ ] Advanced spectral effects (freeze, bin scramble)
- [ ] Polybuffer~ for multi-sample layers
- [ ] Sample slice auto-detection
- [ ] Live recording into buffers

---

## 🛠️ CUSTOMIZATION

### **Modifying the Spectral Processor**
1. Open **SYNDRAVA.amxd** in Max for Live
2. Navigate to `p encoder_bus`
3. Replace `p_spectral_blur` pfft~ patch with custom FFT processing
4. Example processors:
   - `fft~` + `cartopol~` + frequency bin scrambling
   - `spectdelay~` for spectral freezing
   - `frameaccum~` for smearing

### **Changing Synth Voices**
1. Open `p track1` (or any track)
2. Replace `cycle~` with:
   - `saw~` (aliased saw)
   - `rect~` (pulse/PWM)
   - `pink~` (noise generator)
   - `rand~` (sample & hold chaos)
   - Custom `poly~` voice

### **Adding Effects**
1. Insert between `p mixer` and `p feedback_bus`
2. Recommended Max effects:
   - `tapin~/tapout~` (delay)
   - `comb~` (resonator)
   - `freqshift~` (frequency shifter)
   - `teeth~` (bit crusher)

---

## 💾 SAVING & RECALL

### **Saving Presets**
1. Click **floppy disk icon** (pattrstorage UI)
2. Type preset name
3. Stores:
   - Sequencer pattern
   - Parameter locks
   - Touch plate states
   - Routing settings

### **Recalling Presets**
1. Click **preset number** in pattrstorage
2. All parameters restore instantly

### **Copying Patterns**
- Use **dict pattern_locks** object
- Export to JSON via dict inspector
- Import to other SYNDRAVA instances

---

## 🎯 EXAMPLE PATCHES

### **Example 1: Acid Techno**
```
Steps: 1,5,9,13 (kick)
       3,7,11,15 (snare)
       Every step (hihat with 50% probability)

P-Locks: Step 5 (pitch +7 semitones)
         Step 13 (pitch +12 semitones)

FX Lane: Step 8 (feedback burst)
         Step 16 (encoder depth 100%)
```

### **Example 2: Ambient Chaos**
```
Steps: 1 (long sample, decay 2000ms)
       9 (retrig ×8)

P-Locks: Step 1 (filter 200Hz)
         Step 9 (filter 5000Hz, pitch -12)

Touch: P1→Feedback, P3→Chaos, P5→Morph
FX Lane: All steps (encoder 80%, feedback 60%)
```

### **Example 3: Glitch IDM**
```
Steps: Random pattern with 70% probability per step

P-Locks: Every step (random pitch -24 to +24 semitones)
         Alternating filter cutoff (100Hz / 8000Hz)

Touch: Rapid P2/P4/P6 modulation
FX Lane: Chaos bursts every 4 steps
```

---

## 🔗 RESOURCES

**Max for Live Documentation**: https://docs.cycling74.com/max8/vignettes/m4l_intro
**Buffer~ Reference**: https://docs.cycling74.com/max8/refpages/buffer~
**pfft~ Spectral Processing**: https://docs.cycling74.com/max8/vignettes/fftspectral
**pattrstorage Presets**: https://docs.cycling74.com/max8/vignettes/presets

---

## 🙏 CREDITS

**Concept**: Hybrid of SOMA Enner, Elektron Monomachine, Digitakt II, Pulsar-23
**Architecture**: Semi-modular chaotic drum brain with AI-inspired processing
**Built with**: Max/MSP 9, Max for Live
**Designed for**: Ableton Live 11+ Suite

---

## 📜 LICENSE

This Max for Live device is provided as-is for educational and creative use.

**Feel free to**:
- Modify and extend
- Use in commercial productions
- Share with others (with attribution)

**Do not**:
- Resell as a standalone product
- Claim original authorship

---

## ⚡ QUICK START CHECKLIST

- [ ] Install SYNDRAVA.amxd in Ableton User Library
- [ ] Load on MIDI track in Ableton Live
- [ ] Verify Max DSP is running (bottom left)
- [ ] Load 4 drum samples (kick, snare, hihat, perc)
- [ ] Click steps in sequencer matrix
- [ ] Press Play in Ableton
- [ ] Adjust Feedback/Chaos dials
- [ ] Modulate with touch plates (P1-P8)
- [ ] Enable Encoder Depth for spectral morphing
- [ ] Save your first preset!

---

**⬡ Welcome to SYNDRAVA — where chaos meets rhythm ⬡**
