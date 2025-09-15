#!/usr/bin/env bash

UTIL_DIR="$HOME/.local/share/emperorutils"
mkdir -p "$UTIL_DIR"

git clone https://github.com/emperoros/emperorutils "$UTIL_DIR/emperorutils"
cd "$UTIL_DIR/emperorutils" || exit

for utility in ./src/*; do
    name=$(basename "$utility")
    cp "$utility" "$UTIL_DIR/$name"

    # Bash/Zsh
    for shellrc in "$HOME/.bashrc" "$HOME/.zshrc"; do
        if ! grep -Fxq "source $UTIL_DIR/$name" "$shellrc"; then
            echo "source $UTIL_DIR/$name" >> "$shellrc"
        fi
    done

    # Fish
    FISH_CONFIG="$HOME/.config/fish/config.fish"
    mkdir -p "$(dirname "$FISH_CONFIG")"
    if ! grep -Fxq "source $UTIL_DIR/$name" "$FISH_CONFIG"; then
        echo "source $UTIL_DIR/$name" >> "$FISH_CONFIG"
    fi

    # Csh/Tcsh
    for shellrc in "$HOME/.cshrc" "$HOME/.tcshrc"; do
        if [ -f "$shellrc" ] && ! grep -Fxq "source $UTIL_DIR/$name" "$shellrc"; then
            echo "source $UTIL_DIR/$name" >> "$shellrc"
        fi
    done

done
