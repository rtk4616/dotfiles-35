#!/bin/sh -eu

cd $(dirname $0)

git submodule init
git submodule update

# install zplug
if [ ! -d ~/.zplug ]; then
    curl -sL zplug.sh/installer | zsh
fi

mkdir -p ${HOME}/.config

# dotfiles
for dotfiles in .?*
do
  case ${dotfiles} in
    ..)            continue ;;
    .config)       ln -sf "${PWD}/.config/fish" "${HOME}/.config/fish" ;;
    .editorconfig) continue ;;
    .git*)         continue ;;
    .travis.yml)   continue ;;
    *)             ln -sf "${PWD}/${dotfiles}" ${HOME} ;;
  esac
done

# neovim
ln -sf ${PWD}/nvim ${HOME}/.config/nvim
