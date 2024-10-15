#!/bin/bash

main() {
  # TODO: Check if the script is running on macOS.

  # TODO: Check if Homebrew is installed.
  echo "[1]"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || return
  # TODO: Investigate is .zprofile can be placed under `.config/`.
  echo "[2]"
  echo >> ~/.zprofile || return
  echo "[3]"
  # shellcheck disable=SC2016 # Expansion isn't meant to happen in this script.
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile || return
  echo "[4]"
  eval "$(/opt/homebrew/bin/brew shellenv)" || return

  echo "[5]"
  brew install git gnupg || return

  # TODO: Set up an SSH agent.

  rm -rf /tmp/dotfiles-macos-workstation || return
  git clone git@github.com:mmotorny/dotfiles-macos-workstation.git /tmp/dotfiles-macos-workstation || return
  find /tmp/dotfiles-macos-workstation -mindepth 1 -maxdepth 1 -exec mv {} ~ \; || return
  cp ~/.dotfiles-hooks/* ~/.git/hooks || return
  cd || return
  git hook run post-checkout || return

  return 0
}

main "$@"
