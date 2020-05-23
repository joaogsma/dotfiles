#!/bin/bash

CURRENT_DIR=$(pwd)
echo $CURRENT_DIR

ln -sivF $CURRENT_DIR/vim/.vimrc ~
ln -sivF $CURRENT_DIR/tmux/.tmux.conf ~
mkdir -pv ~/.config/alacritty
ln -sivF $CURRENT_DIR/alacritty/alacritty.yml ~/.config/alacritty
