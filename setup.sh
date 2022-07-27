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
applications["Tunnelblick"]="tunnelblick"
applications["Visual Studio Code"]="visual-studio-code"
applications["Zoom"]="zoom"
applications["Figma"]="figma"
applications["Loom"]="loom"
applications["VLC"]="vlc"
applications["Authy"]="authy"
applications["Obsidian"]="obsidian"

# ------------------------------------------------------------------------------------------------

declare -A cli_tools

cli_tools["node.js"]="node"
cli_tools["AWS CLI"]="awscli"
cli_tools["jq"]="jq"
cli_tools["htmlq"]="htmlq"
cli_tools["Docker Credential Helper ECR"]="docker-credential-helper-ecr"
cli_tools["nvm"]="nvm"
cli_tools["tldr"]="tldr"
cli_tools["tree"]="tree"
cli_tools["pnpm"]="pnpm"

# ------------------------------------------------------------------------------------------------

bold=$(tput bold)
normal=$(tput sgr0)

# ------------------------------------------------------------------------------------------------

install_oh_my_zshell() {
  echo "👉 Checking for ${bold}oh my zsh${normal}"
  echo ""
  if [[ ! -f ~/.zshrc ]]; then
    echo "    ❗ No installation found, installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "    Found oh-my-zsh 👌"
  fi
}

# ------------------------------------------------------------------------------------------------

install_homebrew() {
  which -s brew
  if [[ $? != 0 ]] ; then
    echo "🍺🍺🍺 ${bold}First, installing Homebrew${normal} 🍺🍺🍺"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo ""
    echo "🍺 ${bold}Homebrew already installed${normal} 👌"
  fi
  echo ""
}

# ------------------------------------------------------------------------------------------------

install_cask_with_homebrew() {
  echo $1 | tr -d '"' | read name

  echo "🔹 ${bold}$name${normal}"
  echo ""

  application_path="/Applications/$name.app"

  if [[ -f $application_path || -d $application_path ]]; then
    echo "   Found in Applications 👌"
  elif brew list $2 &>/dev/null; then
    echo "   Found installation with brew 👌"
  else
    echo "    ⚠ No installation found, installing with brew"
    brew install --cask $2 && echo "${bold}$app${normal} installed ✅"
  fi
  echo ""
}

# ------------------------------------------------------------------------------------------------

install_with_homebrew() {
  echo $1 | tr -d '"' | read name

  echo "🔹 ${bold}$name${normal}"
  echo ""

  if brew ls --versions $2 > /dev/null; then
    echo "   Tool already installed 👌"
  else
    echo "   ❗ Tool not found, installing with brew"
    echo ""
    brew install $2 && echo "${bold}$1${normal}"
  fi
  echo ""
}

# ------------------------------------------------------------------------------------------------

echo ""
echo "💙 This script installs Homebrew & basic apps needed for 💻 development 💙"
echo ""

install_homebrew

# ------------------------------------------------------------------------------------------------

echo "👉 Checking for CLI tools to install"
echo ""

for name safe_name in ${(kv)cli_tools}; do
  install_with_homebrew $name $safe_name
done

echo "👉 Checking for applications to install"
echo ""

for name safe_name in ${(kv)applications}; do
  install_cask_with_homebrew $name $safe_name
done

echo "🤙 Computer all set up for development 😇"
echo ""
