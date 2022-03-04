#!/bin/sh
bold=$(tput bold)
normal=$(tput sgr0)

applications=(
  "Alfred"
  "Alt-C"
  "Bluesnooze"
  "Chrome"
  "Docker"
  "Firefox"
  "iTerm"
  "Postman"
  "Slack"
  "Spectacle"
  "Spotify"
  "Statusfy"
  "VS Code"
)

echo ""
echo "💙 This script installs Homebrew & basic apps needed for 💻 development 💙"
echo ""
echo "🍺🍺🍺 ${bold}First, Homebrew${normal} 🍺🍺🍺"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo ""

for app in "${applications[@]}"
do
  echo "👉 ${bold}$app${normal}"
  echo ""
  brew install --cask $app
  echo "👉 ${bold}$app${normal} installed ✅"
  echo ""
done

echo "🤙 Computer all set up for development 😇"
echo ""
