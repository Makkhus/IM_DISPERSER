#!/bin/bash
set -e

# IM_DISPERSER macOS Installer Builder
# Creates a .pkg installer for VST3 and CLAP plugins

VERSION="1.0.0"
PLUGIN_NAME="im_disperser"
PKG_NAME="IM_DISPERSER-v${VERSION}-macOS-arm64.pkg"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Building IM_DISPERSER Installer v${VERSION}${NC}"
echo ""

# Check if plugin files exist in Downloads
if [ ! -d "$HOME/Downloads/${PLUGIN_NAME}.vst3" ] || [ ! -d "$HOME/Downloads/${PLUGIN_NAME}.clap" ]; then
    echo "ERROR: Plugin files not found in ~/Downloads/"
    echo "Expected:"
    echo "  - ~/Downloads/${PLUGIN_NAME}.vst3"
    echo "  - ~/Downloads/${PLUGIN_NAME}.clap"
    exit 1
fi

# Create temporary build directory
BUILD_DIR=$(mktemp -d)
echo -e "${GREEN}Created build directory: ${BUILD_DIR}${NC}"

# Create package structure
PAYLOAD_DIR="${BUILD_DIR}/payload"
VST3_DIR="${PAYLOAD_DIR}/Library/Audio/Plug-Ins/VST3"
CLAP_DIR="${PAYLOAD_DIR}/Library/Audio/Plug-Ins/CLAP"

mkdir -p "${VST3_DIR}"
mkdir -p "${CLAP_DIR}"

# Copy plugins to payload
echo "Copying plugins..."
cp -R "$HOME/Downloads/${PLUGIN_NAME}.vst3" "${VST3_DIR}/"
cp -R "$HOME/Downloads/${PLUGIN_NAME}.clap" "${CLAP_DIR}/"

# Create package
echo "Building package..."
pkgbuild \
    --root "${PAYLOAD_DIR}" \
    --identifier "com.makkhus.imdisperser" \
    --version "${VERSION}" \
    --install-location "/" \
    "${BUILD_DIR}/component.pkg"

# Create distribution XML for product archive
cat > "${BUILD_DIR}/distribution.xml" << 'DISTXML'
<?xml version="1.0" encoding="utf-8"?>
<installer-gui-script minSpecVersion="1">
    <title>IM_DISPERSER</title>
    <welcome file="welcome.html"/>
    <license file="license.txt"/>
    <conclusion file="conclusion.html"/>
    <options customize="never" require-scripts="false" hostArchitectures="arm64"/>
    <domains enable_localSystem="true"/>
    <choices-outline>
        <line choice="default">
            <line choice="com.makkhus.imdisperser"/>
        </line>
    </choices-outline>
    <choice id="default"/>
    <choice id="com.makkhus.imdisperser" visible="false">
        <pkg-ref id="com.makkhus.imdisperser"/>
    </choice>
    <pkg-ref id="com.makkhus.imdisperser" version="1.0.0" onConclusion="none">component.pkg</pkg-ref>
</installer-gui-script>
DISTXML

# Create welcome message
cat > "${BUILD_DIR}/welcome.html" << 'WELCOME'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; }
        h1 { color: #007AFF; }
    </style>
</head>
<body>
    <h1>Welcome to IM_DISPERSER</h1>
    <p>This installer will install the IM_DISPERSER audio plugin in VST3 and CLAP formats.</p>
    <h2>What's New in v1.0.0</h2>
    <ul>
        <li><strong>Fixed non-responsive knobs on macOS</strong></li>
        <li><strong>Improved drag sensitivity</strong> with Shift+drag fine control</li>
        <li><strong>Better performance</strong> with optimized parameter updates</li>
        <li><strong>Smoother UI</strong> optimized for macOS gestures</li>
    </ul>
    <p><strong>System Requirements:</strong> macOS 11.0 or later (Apple Silicon)</p>
</body>
</html>
WELCOME

# Create conclusion message
cat > "${BUILD_DIR}/conclusion.html" << 'CONCLUSION'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; }
        h1 { color: #34C759; }
        code { background-color: #f5f5f5; padding: 2px 6px; border-radius: 3px; }
    </style>
</head>
<body>
    <h1>Installation Complete!</h1>
    <p>IM_DISPERSER has been successfully installed.</p>
    <h2>Plugin Locations:</h2>
    <ul>
        <li><strong>VST3:</strong> <code>/Library/Audio/Plug-Ins/VST3/im_disperser.vst3</code></li>
        <li><strong>CLAP:</strong> <code>/Library/Audio/Plug-Ins/CLAP/im_disperser.clap</code></li>
    </ul>
    <h2>Next Steps:</h2>
    <ol>
        <li>Open your DAW (Logic Pro, Ableton, Reaper, etc.)</li>
        <li>Rescan for new plugins</li>
        <li>Look for "IM_DISPERSER" in your plugin list</li>
    </ol>
    <p><strong>Need Help?</strong> Visit <a href="https://github.com/Makkhus/IMDISPERSER">github.com/Makkhus/IMDISPERSER</a></p>
</body>
</html>
CONCLUSION

# Copy license
cp LICENSE "${BUILD_DIR}/license.txt" 2>/dev/null || echo "GNU General Public License v3.0" > "${BUILD_DIR}/license.txt"

# Build final product archive
OUTPUT_DIR="$HOME/Downloads"
OUTPUT_PKG="${OUTPUT_DIR}/${PKG_NAME}"

echo "Creating product archive..."
productbuild \
    --distribution "${BUILD_DIR}/distribution.xml" \
    --package-path "${BUILD_DIR}" \
    --resources "${BUILD_DIR}" \
    "${OUTPUT_PKG}"

# Clean up
rm -rf "${BUILD_DIR}"

echo ""
echo -e "${GREEN}✅ Installer created successfully!${NC}"
echo ""
echo "Output: ${OUTPUT_PKG}"
echo ""
echo "The installer will install plugins to:"
echo "  • /Library/Audio/Plug-Ins/VST3/im_disperser.vst3"
echo "  • /Library/Audio/Plug-Ins/CLAP/im_disperser.clap"
echo ""
echo -e "${BLUE}Note: Built for Apple Silicon (M1/M2/M3/M4)${NC}"
echo -e "${BLUE}To test: double-click ${PKG_NAME} in your Downloads folder${NC}"
