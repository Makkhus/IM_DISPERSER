# Changelog

All notable changes to IM_DISPERSER will be documented in this file.

## [1.0.0] - 2026-11-08

### First Stable Release 🎉

This is the first stable release of IM_DISPERSER for macOS - a professional phase disperser plugin with fully working controls and optimized performance.

### Features
- Real-time phase dispersion with adjustable frequency, spread, and amount
- Visual feedback with live waveform display
- Smooth parameter control optimized for macOS gesture input
- Native Apple Silicon build optimized for M-series chips
- VST3 and CLAP formats

### Fixed (from original Windows version)
- **Non-responsive knobs on macOS** - Corrected module declaration order
- **Drag sensitivity** - Local coordinate tracking with 0.002 sensitivity
- **Shift+drag fine control** - 25x finer adjustment for precision
- **MIDI note calculation** - Using proper A4_MIDI constant
- **Windows code removal** - Pure macOS implementation

### Performance
- 60Hz throttled parameter updates for smooth performance
- Separate visual preview decoupled from host updates
- Optimized peak meter calculations

### User Experience
- Live value display during parameter adjustments
- Smooth visual feedback and animation
- Optimized for macOS trackpad and Magic Mouse
- Cursor remains visible during adjustment

### Credits
- Original Plugin: [sout233/im_disperser](https://github.com/sout233/im_disperser)
- DSP Core: [IAMMRGODIE/i_am_dsp](https://github.com/IAMMRGODIE/i_am_dsp)
- macOS Port: Makkhus

---

**Platform**: macOS 11.0+ (Apple Silicon / M-series)  
**Formats**: VST3, CLAP  
**License**: GPL-3.0
