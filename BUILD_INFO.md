# Build Information

## Version: 1.0.0

### Architecture
- **Target**: arm64 (Apple Silicon only)
- **Supported Macs**: M1, M2, M3, M4 series
- **Not supported**: Intel Macs (x86_64)

### Build Command
```bash
cargo build --release --target aarch64-apple-darwin
```

### Output Files
- `target/release/im_disperser.vst3`
- `target/release/im_disperser.clap`

### Installer Package
- **Filename**: `IM_DISPERSER-v1.0.0-macOS-arm64.pkg`
- **Architecture**: arm64 only
- **Build script**: `./create-installer.sh`

### System Requirements
- macOS 11.0 (Big Sur) or later
- Apple Silicon processor (M1/M2/M3/M4)
- VST3 or CLAP compatible DAW

### Installation Locations
- VST3: `/Library/Audio/Plug-Ins/VST3/im_disperser.vst3`
- CLAP: `/Library/Audio/Plug-Ins/CLAP/im_disperser.clap`

---

**Note**: This build is specifically optimized for Apple Silicon. Intel Mac users will need to build from source with x86_64 target or use Rosetta 2 (not recommended for audio plugins).
