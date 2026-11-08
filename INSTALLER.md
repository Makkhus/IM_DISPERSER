# Creating the macOS Installer

This guide explains how to create a `.pkg` installer for IM_DISPERSER.

## Prerequisites

- Built plugin bundles (`im_disperser.vst3` and `im_disperser.clap`)
- macOS command-line tools installed
- Plugins should be in your `~/Downloads` folder

## Quick Start

```bash
# Make the script executable
chmod +x create-installer.sh

# Run the installer builder
./create-installer.sh
```

The script will:
1. ✅ Verify plugins exist in `~/Downloads/`
2. 📦 Create a package structure
3. 📝 Generate installer documentation (welcome, license, conclusion)
4. 🔨 Build the `.pkg` installer
5. 💾 Save it to `~/Downloads/IM_DISPERSER-v0.1.3-macOS.pkg`

## What Gets Installed

The installer places plugins in system directories:

- **VST3**: `/Library/Audio/Plug-Ins/VST3/im_disperser.vst3`
- **CLAP**: `/Library/Audio/Plug-Ins/CLAP/im_disperser.clap`

These are system-wide installation locations accessible to all users.

## Installer Features

- ✨ Professional welcome screen with version info
- 📄 GPL-3.0 license display
- ✅ Success screen with installation paths
- 🍎 Native macOS installer UI
- 🔒 Installs to protected system directories (requires admin password)
- 🌐 Native Apple Silicon support (M1/M2/M3/M4)

## Testing the Installer

```bash
# Double-click the .pkg file in Finder, or:
open ~/Downloads/IM_DISPERSER-v0.1.3-macOS.pkg
```

Follow the installation prompts. You'll need to enter your admin password.

## Uploading to GitHub Release

After creating the `.pkg` file:

1. Go to https://github.com/Makkhus/IMDISPERSER/releases/tag/v0.1.3
2. Click "Edit release"
3. Drag and drop `IM_DISPERSER-v0.1.3-macOS.pkg` to the assets section
4. Click "Update release"

## Troubleshooting

**Error: Plugin files not found**
- Make sure `im_disperser.vst3` and `im_disperser.clap` are in `~/Downloads/`
- Build the plugins first with `cargo build --release`

**Error: command not found: pkgbuild**
- Install Xcode Command Line Tools: `xcode-select --install`

**Installer shows "unidentified developer" warning**
- This is normal for unsigned packages
- Users can right-click → Open to bypass (or you can code-sign with an Apple Developer account)

## Code Signing (Optional)

To sign the installer with your Apple Developer certificate:

```bash
# Sign the package
productsign --sign "Developer ID Installer: Your Name" \
    ~/Downloads/IM_DISPERSER-v0.1.3-macOS.pkg \
    ~/Downloads/IM_DISPERSER-v0.1.3-macOS-signed.pkg

# Verify signature
pkgutil --check-signature ~/Downloads/IM_DISPERSER-v0.1.3-macOS-signed.pkg
```

Signed packages won't show security warnings to users.

## Package Details

- **Bundle ID**: `com.makkhus.imdisperser`
- **Version**: `1.0.0`
- **Install Location**: `/Library/Audio/Plug-Ins/`
- **Requirements**: macOS 11.0+, Apple Silicon (M1/M2/M3/M4)
- **Architecture**: arm64 (native Apple Silicon)

---

**Questions?** Open an issue at https://github.com/Makkhus/IMDISPERSER/issues
