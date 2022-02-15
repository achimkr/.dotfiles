#!/bin/bash

result=$(echo -e "¯\\_(ツ)_/¯
ಠ_ಠ
(╯°□°）╯︵ ┻━┻
ᕕ( ᐛ )ᕗ
ฅ^•ﻌ•^ฅ
ಥ_ಥ
Ѭ " | rofi -dmenu -p Smileys)
 
echo $result | xclip -i -selection "clipboard"
