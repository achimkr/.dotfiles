#!/bin/bash

result=$(echo -e "¯\\_(ツ)_/¯
( ͡° ͜ʖ ͡°)
ಠ_ಠ
(╯°□°）╯︵ ┻━┻
ᕕ( ᐛ )ᕗ
ฅ^•ﻌ•^ฅ
ಥ_ಥ" | rofi -dmenu -p Smileys)

echo $result | xclip -i -selection "clipboard"
