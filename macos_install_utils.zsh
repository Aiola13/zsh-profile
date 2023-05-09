#!/bin/zsh

# To execute run:
#
#    zsh macos_install_utils.sh


# Activer le mode verbose si l'option -v est fournie
verbose_mode() {
  if [ "$1" == "-v" ]; then
    set -x
  fi
}

# Vérifier si le script est exécuté en tant que root et définir USER_HOME en conséquence
set_user_home() {
  if [ "$(id -u)" -eq 0 ]; then
    USER_HOME="/root"
  else
    USER_HOME="${HOME}"
  fi
}

# Installer Homebrew (gestionnaire de paquets pour macOS) s'il n'est pas déjà installé
install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

# Installer les paquets et les ajouter à la configuration Zsh
install_packages() {
  echo "Installing packages..."
  packages=(
    "zsh"
    "romkatv/powerlevel10k/powerlevel10k"
    "bat"
    "exa"
    "btop"
    "ncdu"
    "duf"
    "fd"
    "cheat"
  )
  sources=(
    "/usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme"
    "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  )
  plugins=(
    "zsh-autosuggestions:https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting:https://github.com/zsh-users/zsh-syntax-highlighting.git"
  )

  brew update

  for package in "${packages[@]}"; do
    echo "... ${package} ... "
    brew list "${package}" >/dev/null 2>&1 || brew install "${package}"
  done

  for plugin in "${plugins[@]}"; do
    plugin_name="${plugin%%:*}"
    plugin_git_repo="${plugin#*:}"
    plugin_dir="${USER_HOME}/.zsh/${plugin_name}"

    if [ ! -d "${plugin_dir}" ]; then
        git clone "${plugin_git_repo}" "${plugin_dir}"
    fi
  done

  for source in "${sources[@]}"; do
    if [ -f "${source}" ] && ! grep -q "source ${source}" "${USER_HOME}/.zshrc"; then
      echo "source ${source}" >> "${USER_HOME}/.zshrc"
    fi
  done

  echo "✅ done"
}

# Appliquer les modifications en rechargeant la configuration Zsh
apply_changes() {
  echo "Applying changes..."
  source "${USER_HOME}/.zshrc"
}

# Copier les fichiers de configuration vers le répertoire utilisateur
copy_config_files() {
  echo "Copying configuration files..."

  zshrc_src_path="./.zshrc"
  p10k_src_path="./.p10k.zsh"
  zshrc_dest_path="${USER_HOME}/.zshrc"
  p10k_dest_path="${USER_HOME}/.p10k.zsh"
   
  if [ -f "${zshrc_src_path}" ]; then
    cp "${zshrc_src_path}" "${zshrc_dest_path}"
  fi

  if [ -f "${p10k_src_path}" ]; then
    cp "${p10k_src_path}" "${p10k_dest_path}"
  fi
}

# La fonction principale qui appelle les autres fonctions pour installer et configurer les éléments requis
main() {
  verbose_mode "$1"
  set_user_home
  install_homebrew
  install_packages
  copy_config_files
  apply_changes
  echo "✅ Installation complete!"
}

# Appeler la fonction principale avec tous les arguments passés au script
main "$@"
