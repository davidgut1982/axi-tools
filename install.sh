#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/.local/bin

curl -fsSL https://raw.githubusercontent.com/davidgut1982/axi-tools/main/scripts/axi \
  -o ~/.local/bin/axi

chmod +x ~/.local/bin/axi

echo ""
echo "AXI manager installed."
echo "Run \`axi install <name>\` to install tools, or \`axi install --all\` for everything."
echo ""

# Add to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo "Note: ~/.local/bin is not in your PATH."
  echo "Add this to your shell config (~/.bashrc, ~/.zshrc, etc.):"
  echo '  export PATH="$HOME/.local/bin:$PATH"'
  echo ""
fi
