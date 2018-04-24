#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

pgrep openvpn &> /dev/null
if [[ $? -eq 0 ]]; then
    echo "%{F#00FF00}$icon"
else
	echo "%{F#FF0000}$icon"
fi

