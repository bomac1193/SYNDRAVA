# 🔧 SYNDRAVA ADVANCED CUSTOMIZATION GUIDE

This guide explains how to extend, modify, and hack SYNDRAVA's internals.

---

## 📐 ARCHITECTURE DEEP DIVE

### **Signal Flow Diagram**

```
SEQUENCER → PARAMETER LOCKS → TRACK VOICES
    ↓              ↓               ↓
STEP CLK      DICT RECALL      SAMPLE/SYNTH
    ↓              ↓               ↓
FX LANE ────→ ROUTING MODS    ENVELOPE + FILTER
    ↓              ↓               ↓
TOUCH PLATES → CHAOS INJECT → VCA MIXER
                   ↓               ↓
              FEEDBACK BUS ←───── MIX
                   ↓
              DELAY + RINGMOD + SATURATION
                   ↓
              ENCODER BUS
                   ↓
              FFT BLUR + GRAIN DELAY
                   ↓
              MASTER OUT (plugout~)
```

---

## 🎛️ CUSTOMIZING TRACK VOICES

### **Adding Polyphony to a Track**

1. Open `p track1` in Max editor
2. Replace single voice with `poly~`:

```maxpat
[inlet] → [pack note 100] → [poly~ p_voice 8] → [outlet]
```

3. Inside `p_voice`:
```maxpat
[in 1] → [mtof] → [cycle~] → [*~ env] → [out 1]
[in 2] → [/ 127] → [line~ 500] → [env]
```

### **Creating a Wavetable Voice**

Replace `cycle~` with `wave~`:

```maxpat
[buffer~ wavetable] ← [read <wavetable.wav>]
[inlet pitch] → [* 0.001] → [wave~ wavetable] → [outlet]
```

### **Adding FM Synthesis**

Dual operator FM:

```maxpat
[inlet pitch] → [* 2.5] → [cycle~ mod] → [*~ index]
                    ↓
         [inlet pitch] → [+~] → [cycle~ carrier] → [outlet]
```

Where `index` is a parameter lock value.

---

## 🧬 EXPANDING THE SEQUENCER

### **Increasing to 64 Steps**

1. Open `p sequencer`
2. Change `matrixctrl`:
```
columns: 64
rows: 4
```
3. Update `counter`:
```
[counter 0 63]
```
4. Add page selector:
```
[live.menu @items "1-16" "17-32" "33-48" "49-64"]
```

### **Adding Euclidean Patterns**

Create `p euclidean_gen`:

```maxpat
[inlet steps] [inlet pulses] [inlet rotation]
    ↓              ↓              ↓
[EUCLID ALGORITHM (Max gen~ or JavaScript)]
    ↓
[zl stream] → [outlet pattern_list]
```

Connect to sequencer matrix.

### **Per-Step Velocity Curves**

Add velocity to parameter locks:

```maxpat
[dict get pattern_locks step_$i velocity] → [scale 0 127 0 1] → [*~ track_signal]
```

---

## 🌀 CHAOS NETWORK MODIFICATIONS

### **Adding Karplus-Strong Resonator**

In `p feedback_bus`, after `delay~`:

```maxpat
[delay~ 100] → [comb~ 100 0.99] → [lowpass~ 1000] → [outlet]
```

Creates pitched feedback tones.

### **Frequency Shifting Chaos**

Replace ring mod with `freqshift~`:

```maxpat
[inlet signal] → [freqshift~ 100 0.5] → [tanh~] → [outlet]
```

Generates inharmonic sidebands.

### **Granular Feedback**

Add grain playback inside feedback loop:

```maxpat
[tapin~ 10000]
    ↓
[tapout~ <random 10-5000>] → [*~ grain_env] → [+~] → [outlet]
```

Creates stuttering/glitch artifacts.

---

## 🎨 SPECTRAL PROCESSING ENHANCEMENTS

### **Spectral Freeze**

Modify `p_spectral_blur.maxpat`:

```maxpat
[inlet freeze_gate]
    ↓
[gate~ 2] → [when freeze=1: store bins, replay frozen spectrum]
```

Implementation:
```maxpat
[cartopol~] → [capture~ 2048] → [peek~ frozen_bins] → [poltocar~]
```

### **Formant Shifting**

Add `+=` frequency bin offset:

```maxpat
[cartopol~] → [mag] [phase]
                ↓      ↓
           [shift bins up/down by N]
                ↓      ↓
             [poltocar~] → [outlet]
```

### **Spectral Delay (Bin-by-Bin)**

Per-bin delay lines:

```maxpat
[cartopol~] → [frameaccum~ 10] → [poltocar~]
```

Creates spectral smearing/reverb.

---

## 🎹 MIDI & PARAMETER CONTROL

### **Mapping Hardware Controllers**

1. Add `live.dial` objects with MIDI learn
2. Connect to internal parameters:

```maxpat
[live.dial feedback_ctrl @parameter_enable 1]
    ↓
[pattr feedback_amount @autorestore 0]
    ↓
[*~ 0.95] (feedback multiplier)
```

3. Enable MIDI learn in Ableton

### **MIDI Note Input to Tracks**

Add `notein` object:

```maxpat
[notein] → [unpack pitch vel] → [route 36 38 42 46]
            ↓                        (kick snare hat perc)
       [send to track triggers]
```

### **CV-Style Modulation**

Create `p cv_modulator`:

```maxpat
[phasor~ 0.1] → [snapshot~ 100] → [scale~ 0 1 -1 1] → [outlet mod]
```

Route to parameters like filter cutoff.

---

## 🔌 ADDING EXTERNAL FX

### **Insert Delay/Reverb**

Between `p mixer` and `p feedback_bus`:

```maxpat
[inlet L/R]
    ↓
[tapin~ 10000]
    ↓
[tapout~ 441 882 1323] → [*~ 0.3 0.2 0.1] → [+~]
    ↓
[allpass~ 100] (diffusion) × 4
    ↓
[outlet L/R]
```

### **Multiband Compression**

Split into 3 bands:

```maxpat
[svf~ lowpass 200] → [live.gain~ @parameter_enable 1] → [+~]
[svf~ bandpass 200 2000] → [live.gain~ @parameter_enable 1] → [+~]
[svf~ highpass 2000] → [live.gain~ @parameter_enable 1] → [outlet]
```

---

## 🗄️ ADVANCED PATTRSTORAGE

### **Creating Preset Morphing**

```maxpat
[live.dial morph_amt @parameter_enable 1]
    ↓
[scale 0. 1. 0 127]
    ↓
[pattrstorage] ← [message "recall 1, recall 2 $1"] (interpolate)
```

### **Auto-Randomization**

```maxpat
[metro 4000] → [random 1000] → [/ 1000.] → [s chaos_amount]
[metro 8000] → [random 1000] → [/ 1000.] → [s encoder_depth]
```

### **Snapshot Recall System**

```maxpat
[live.step 16] → [scale 0 15 1 16] → [prepend recall] → [pattrstorage]
```

Sequences through 16 presets.

---

## 🎬 PERFORMANCE TRICKS

### **Live Resampling**

Record output back into track buffers:

```maxpat
[plugout~] → [record~ track1buf]
```

Creates feedback of feedback.

### **Touch Plate XY Mapping**

Map two plates to X/Y of a parameter space:

```maxpat
[touch_plate_1] → X (filter cutoff)
[touch_plate_2] → Y (resonance)
```

Plot on `live.grid` for visualization.

### **Conditional Pattern Switching**

```maxpat
[live.toggle fill_mode]
    ↓
[gate 2 1] → [dict get fills] / [dict get normal]
    ↓
[matrixctrl] (load pattern)
```

---

## 🧪 EXPERIMENTAL FEATURES

### **Neural Network Integration (Dummy)**

Simulate AI latent space with noise + smoothing:

```maxpat
[noise~] → [slide~ 10000 10000] → [scale~ -1 1 0 1]
    ↓
[*~ encoder_depth] → [route to spectral params]
```

### **Gesture Recording**

Record touch plate movements:

```maxpat
[seq~ gesture_buffer] → [record movements] → [playback with metro]
```

### **Probability Matrix**

Each step has unique probability:

```maxpat
[dict pattern_locks step_$i probability]
    ↓
[random 100] < [threshold] → [gate trigger]
```

---

## 🛠️ DEBUGGING TOOLS

### **Signal Flow Inspector**

Add `live.scope~` at key points:

```maxpat
[feedback_bus out] → [live.scope~ @calccount 1024]
```

### **Parameter Lock Viewer**

Display current locks:

```maxpat
[dict.view pattern_locks] (see all step data)
```

### **CPU Usage Monitor**

```maxpat
[dspstate~] → [unpack] → [live.meter~ cpu_usage]
```

---

## 📚 CODE SNIPPETS

### **Random Step Generator**

```javascript
// Max JavaScript
for (var i = 0; i < 16; i++) {
    var trig = Math.random() > 0.5 ? 1 : 0;
    var pitch = Math.floor(Math.random() * 48) - 24;
    outlet(0, "set_step", i, trig, pitch);
}
```

### **Euclidean Pattern**

```javascript
function euclidean(steps, pulses) {
    var pattern = [];
    for (var i = 0; i < steps; i++) {
        pattern[i] = Math.floor((i * pulses / steps)) != Math.floor(((i-1) * pulses / steps)) ? 1 : 0;
    }
    return pattern;
}
```

---

## 🎯 OPTIMIZATION TIPS

### **Reduce CPU Usage**

1. Lower FFT size: `2048 → 1024`
2. Reduce pfft~ overlap: `4 → 2`
3. Disable unused feedback paths
4. Use `poly~` with voice stealing

### **Improve Latency**

1. Use `plugreceive~` for direct transport sync
2. Minimize `delay~` buffer sizes
3. Use `sig~` instead of `line~` where possible

### **Memory Management**

1. Use `buffer~` @sizeinsamps instead of @sizeinms
2. Clear unused buffers: `clear` message
3. Use `polybuffer~` for shared sample banks

---

## 🔗 INTEGRATION WITH OTHER DEVICES

### **Link to Ableton Instruments**

```maxpat
[midiout] ← [makenote 100 500] ← [sequencer output]
```

Triggers external MIDI instruments.

### **OSC Control**

```maxpat
[udpreceive 8000]
    ↓
[oscroute /syndrava/feedback /syndrava/chaos]
    ↓
[route to parameters]
```

### **Max for Live Device Chaining**

```maxpat
[send~ to_reverb]
[receive~ from_compressor]
```

Use global send~/receive~ for routing.

---

## 🚀 FUTURE EXPANSION IDEAS

- [ ] **Per-track spectral processors** (independent FFT chains)
- [ ] **Machine learning model integration** (onnx~ or ml.* objects)
- [ ] **Visual spectrogram display** (jit.pwindow + jit.fft~)
- [ ] **Hardware controller templates** (Push, Launchpad, etc.)
- [ ] **MIDI clock output** (sync external gear)
- [ ] **Sample auto-slicer** (transient detection with bonk~)
- [ ] **Probability lanes** (per-parameter probability)
- [ ] **Live sample recording** (input from Ableton tracks)

---

**⬡ Happy hacking! ⬡**
