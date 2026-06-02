#!/bin/zsh
#
# macOS setup script for the Aiola zsh profile.
#
# It installs Homebrew, the CLI tools, Oh My Zsh, Powerlevel10k and the zsh
# plugins, then drops the .zshrc / .p10k.zsh from this repo into your home.
#
# To run:
#
#    zsh macos_install_utils.zsh        # normal
#    zsh macos_install_utils.zsh -v     # verbose (set -x)

set -e

# Enable verbose mode if -v is passed.
verbose_mode() {
  if [ "$1" = "-v" ]; then
    set -x
  fi
}

# Resolve the home directory (handles being run as root).
set_user_home() {
  if [ "$(id -u)" -eq 0 ]; then
    USER_HOME="/root"
  else
    USER_HOME="${HOME}"
  fi
}

# Directory holding this script, so config files are copied from the repo.
set_script_dir() {
  SCRIPT_DIR="${0:A:h}"
}

# Install Homebrew if it is not already present.
install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Make brew available in this shell (Apple Silicon and Intel paths).
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

# Install the Homebrew packages.
install_packages() {
  echo "Installing packages..."
  packages=(
    "fastfetch"
    "bat"
    "eza"
    "btop"
    "ncdu"
    "duf"
    "fd"
    "cheat"
  )

  brew update

  for package in "${packages[@]}"; do
    echo "... ${package} ..."
    brew list "${package}" >/dev/null 2>&1 || brew install "${package}"
  done

  echo "✅ packages done"
}

# Install Oh My Zsh (unattended so it doesn't replace our .zshrc or launch zsh).
install_oh_my_zsh() {
  if [ ! -d "${USER_HOME}/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

# Install Powerlevel10k and the external plugins as Oh My Zsh custom add-ons.
install_omz_addons() {
  echo "Installing Powerlevel10k and plugins..."
  local custom="${ZSH_CUSTOM:-${USER_HOME}/.oh-my-zsh/custom}"

  # name:repo pairs cloned into $custom/themes or $custom/plugins.
  themes=(
    "powerlevel10k:https://github.com/romkatv/powerlevel10k.git"
  )
  plugins=(
    "zsh-autosuggestions:https://github.com/zsh-users/zsh-autosuggestions.git"
    "zsh-syntax-highlighting:https://github.com/zsh-users/zsh-syntax-highlighting.git"
  )

  for theme in "${themes[@]}"; do
    local name="${theme%%:*}" repo="${theme#*:}"
    local dir="${custom}/themes/${name}"
    [ -d "${dir}" ] || git clone --depth=1 "${repo}" "${dir}"
  done

  for plugin in "${plugins[@]}"; do
    local name="${plugin%%:*}" repo="${plugin#*:}"
    local dir="${custom}/plugins/${name}"
    [ -d "${dir}" ] || git clone --depth=1 "${repo}" "${dir}"
  done

  echo "Oh My Zsh add-ons done"
}

# Copy the repo's config files into the home directory (backing up existing ones).
# When the script is run standalone (e.g. piped from curl) the files are not
# present next to it, so they are downloaded from the repository instead.
copy_config_files() {
  echo "Copying configuration files..."
  local raw_base="https://raw.githubusercontent.com/Aiola13/zsh-profile/main"

  for file in ".zshrc" ".p10k.zsh"; do
    local src="${SCRIPT_DIR}/${file}"
    local dest="${USER_HOME}/${file}"
    [ -f "${dest}" ] && cp "${dest}" "${dest}.bak"
    if [ -f "${src}" ]; then
      cp "${src}" "${dest}"
    else
      curl -fsSL "${raw_base}/${file}" -o "${dest}"
    fi
  done
}

main() {
  verbose_mode "$1"
  set_user_home
  set_script_dir
  install_homebrew
  install_packages
  install_oh_my_zsh
  install_omz_addons
  copy_config_files
  echo "Installation complete! Restart your terminal or run: exec zsh"
}

main "$@"
