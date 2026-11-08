#!/usr/bin/env bash
# Simple .pkg builder that works with non-universal builds

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DIST_DIR="${ROOT_DIR}/target/bundled"
PKG_ROOT="${DIST_DIR}/pkg-root-simple"
PKG_SCRIPTS="${DIST_DIR}/pkg-scripts-simple"
PKG_PATH="${DIST_DIR}/im_disperser-macos.pkg"

echo "📦 Creating macOS installer package..."

# Clean previous builds
rm -rf "${PKG_ROOT}" "${PKG_SCRIPTS}"

# Create directory structure
mkdir -p \
  "${PKG_ROOT}/Library/Audio/Plug-Ins/Components" \
  "${PKG_ROOT}/Library/Audio/Plug-Ins/VST3" \
  "${PKG_ROOT}/Library/Audio/Plug-Ins/CLAP" \
  "${PKG_SCRIPTS}"

# Copy plugins (use what we have)
echo "Copying plugins..."

if [ -d "${DIST_DIR}/im_disperser.vst3" ]; then
  echo "  ✓ VST3"
  ditto "${DIST_DIR}/im_disperser.vst3" "${PKG_ROOT}/Library/Audio/Plug-Ins/VST3/im_disperser.vst3"
else
  echo "  ⚠ VST3 not found"
fi

if [ -d "${DIST_DIR}/im_disperser.clap" ]; then
  echo "  ✓ CLAP"
  ditto "${DIST_DIR}/im_disperser.clap" "${PKG_ROOT}/Library/Audio/Plug-Ins/CLAP/im_disperser.clap"
else
  echo "  ⚠ CLAP not found"
fi

if [ -d "${DIST_DIR}/im_disperser.component" ]; then
  echo "  ✓ AUv2"
  ditto "${DIST_DIR}/im_disperser.component" "${PKG_ROOT}/Library/Audio/Plug-Ins/Components/im_disperser.component"
elif [ -d "${DIST_DIR}/IM_DISPERSER.component" ]; then
  echo "  ✓ AUv2"
  ditto "${DIST_DIR}/IM_DISPERSER.component" "${PKG_ROOT}/Library/Audio/Plug-Ins/Components/IM_DISPERSER.component"
else
  echo "  ⚠ AUv2 not found"
fi

# Clean metadata
xattr -cr "${PKG_ROOT}" 2>/dev/null || true
find "${PKG_ROOT}" -name '._*' -type f -delete

# Create simple postinstall script
cat > "${PKG_SCRIPTS}/postinstall" << 'EOF'
#!/bin/bash
# Clear AU cache so new plugin is recognized
rm -rf ~/Library/Caches/AudioUnitCache
killall -9 AudioComponentRegistrar 2>/dev/null || true
echo "Plugins installed successfully!"
exit 0
EOF

chmod 755 "${PKG_SCRIPTS}/postinstall"

# Build the package
rm -f "${PKG_PATH}"
echo "Building package..."
pkgbuild \
  --root "${PKG_ROOT}" \
  --identifier "top.soout.godiedsp.im-disperser" \
  --version "0.1.3" \
  --install-location / \
  --scripts "${PKG_SCRIPTS}" \
  "${PKG_PATH}"

echo ""
echo "✅ Package created successfully!"
echo "📦 Installer: ${PKG_PATH}"
echo ""
echo "To install: sudo installer -pkg ${PKG_PATH} -target /"
echo "Or double-click the .pkg file"
