# !/usr/bin/env bash

git add .

git commit

sudo make rebuild

hyprctl reload
