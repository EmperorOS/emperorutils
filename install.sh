#!/usr/bin/env bash
for utility in ./src/*; do
    chmod +x "$utility"
    sudo cp "$utility" "/usr/local/bin/$(basename "$utility")"
done
