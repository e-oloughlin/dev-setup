#!/bin/zsh
declare -A applications

applications["Alfred 4"]="alfred"
applications["Alt-C"]="alt-c"
applications["Bluesnooze"]="bluesnooze"
applications["Google Chrome"]="google-chrome"
applications["Docker"]="docker"
applications["Firefox"]="firefox"
applications["iTerm"]="iterm2"
applications["Postman"]="postman"
applications["Slack"]="slack"
applications["Spectacle"]="spectacle"
applications["Spotify"]="spotify"
applications["Statusfy"]="statusfy"
applications["Visual Studio Code"]="visual-studio-code"


# ------------------------------------------------------------------------------------------------

bold=$(tput bold)
normal=$(tput sgr0)

# ------------------------------------------------------------------------------------------------

install_homebrew() {
  which -s brew
  if [[ $? != 0 ]] ; then
    echo "🍺🍺🍺 ${bold}First, installing Homebrew${normal} 🍺🍺🍺"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "🍺🍺🍺 ${bold}Homebrew already installed${normal} 🍺🍺🍺"
  fi
}

# ------------------------------------------------------------------------------------------------

install_with_homebrew() {
  echo $1 | tr -d '"' | read name

  echo "· ${bold}$name${normal}"
  echo ""

  application_path="/Applications/$name.app"

  if [[ -f $application_path || -d $application_path ]]; then
    echo "    Found in Applications 👌"
  elif brew list $2 &>/dev/null; then
    echo "    Found installation with brew 👌"
  else
    echo "    👉 No installation found, installing with brew"
    brew install --cask $2 && echo "${bold}$app${normal} installed ✅"
  fi
  echo ""
}

# ------------------------------------------------------------------------------------------------

echo ""
echo "💙 This script installs Homebrew & basic apps needed for 💻 development 💙"
echo ""

install_homebrew

# ------------------------------------------------------------------------------------------------

echo "👉 Checking for applications to install"
echo ""

for name safe_name in ${(kv)applications}; do
  install_with_homebrew $name $safe_name
done

echo "🤙 Computer all set up for development 😇"
echo ""
