# IM_DISPERSER

A professional phase disperser audio plugin for macOS with fixed knob controls and optimized performance.

![IM_DISPERSER](https://github.com/user-attachments/assets/d50d10f3-cde6-4c68-9da9-0f973efd77da)

## Overview

IM_DISPERSER is a high-quality phase disperser effect plugin designed for professional audio production. Built on the powerful i_am_dsp library, it provides precise control over phase dispersion with an intuitive, visually responsive interface.

**This macOS port fixes critical issues found in the original release**, including non-responsive knob controls and improves overall stability.

---

### 📋 Release Information

**Release Type:** Stable Release  
**Version:** 1.0.0  
**Original Plugin:** [sout233/im_disperser](https://github.com/sout233/im_disperser) (Windows)  
**Port Author:** Makkhus  
**Platform:** macOS 11.0+ (Apple Silicon / M-series)  
**Plugin formats**: VST3, CLAP

---

## What's Fixed in This Version

This release addresses several critical bugs from the original macOS build:

### 🔧 Major Fixes

- **Fixed non-responsive knobs on macOS** - Corrected module declaration order that prevented the macOS-optimized knob implementation from loading
- **Improved drag sensitivity** - macOS knobs now use local coordinate tracking (0.002 sensitivity) instead of global cursor manipulation
- **Added Shift+drag fine control** - 25x finer adjustment for precise parameter tweaking
- **Fixed stereo-only processing check** - Added explicit validation to prevent crashes on mono or surround tracks
- **Corrected MIDI note calculation** - Fixed hardcoded constant that caused inconsistent frequency display

### ⚡ Performance Improvements

- **Throttled host updates** - Parameter changes now commit at 60Hz during drag for smoother performance
- **Separate visual preview** - Knob rendering decoupled from parameter updates for fluid animation
- **Optimized peak meter** - Reduced redundant calculations in audio processing loop

### 🎯 User Experience Enhancements

- **Live value display** - Shows numeric parameter values during dragging
- **Smooth visual feedback** - Continuous knob arc animation even between host updates
- **Better gesture support** - Optimized for macOS trackpad and Magic Mouse
- **No cursor hiding** - Unlike Windows version, cursor remains visible during adjustment

## Features

- **Real-time phase dispersion** with adjustable frequency, spread, and amount
- **Visual feedback** with live waveform display
- **Smooth parameter control** optimized for macOS gesture input
- **Native Apple Silicon** optimized for M-series chips
- **Multiple plugin formats**: VST3 and CLAP
- **Professional-grade DSP** with low latency and high audio quality

## Parameters

- **Frequency**: Center frequency for phase dispersion (20 Hz - 20 kHz)
- **Spread**: Frequency range width (0.1 Hz - 2000 Hz)
- **Amount**: Number of dispersion stages (0 - 100)

## System Requirements

- **macOS**: 11.0 (Big Sur) or later
- **Processor**: Apple Silicon (M1/M2/M3/M4)
- **Plugin formats**: VST3 or CLAP compatible DAW

## Installation

1. Download the latest **IM_DISPERSER-v1.0.0-macOS-arm64.pkg** installer from [Releases](https://github.com/Makkhus/IM_DISPERSER/releases/latest)
2. Double-click the installer and follow the prompts
3. Restart your DAW and rescan plugins

The installer automatically places plugins in the correct system directories.

**Note:** This build is optimized for Apple Silicon Macs (M1/M2/M3/M4). Intel Macs are not supported.

## Compatibility

**Tested DAWs:**
- Logic Pro X / Logic Pro (VST3)
- Ableton Live 11+ (VST3/CLAP)
- FL Studio (VST3/CLAP)
- Reaper (VST3/CLAP)
- Pro Tools 2023.6+ (VST3)
- Cubase (VST3)
- Studio One (VST3/CLAP)

Compatible with any DAW supporting VST3 or CLAP plugins.

## Credits

**Original Plugin**: [sout233/im_disperser](https://github.com/sout233/im_disperser)  
**DSP Core**: [IAMMRGODIE/i_am_dsp](https://github.com/IAMMRGODIE/i_am_dsp)  
**macOS Port**: Makkhus

**Built with:**
- [nih-plug](https://github.com/robbert-vdh/nih-plug) - Plugin framework
- [vizia](https://github.com/vizia/vizia) - UI framework
- [i_am_dsp](https://github.com/IAMMRGODIE/i_am_dsp) - DSP library

## License

GNU General Public License v3.0 (GPL-3.0)

This software is free and open source. See [LICENSE](LICENSE) for details.

## Support

For bug reports and feature requests, please open an issue on [GitHub](https://github.com/Makkhus/IM_DISPERSER/issues).

---

**Made with ❤️ for the macOS audio community**
