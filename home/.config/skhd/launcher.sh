#!/bin/bash

app="-\n"
for f in /Applications/*.app; do
	app+=$(basename $f .app)
	app+="\n"
done
app="${app%??}"

selected=$(echo -e $app | dmenu-mac)

[[ "$selected" == "-" ]] && exit 0
	
selected="/Applications/${selected}.app"
open -n $selected

