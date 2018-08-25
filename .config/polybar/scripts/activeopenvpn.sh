path=$(ps aux | grep $(pgrep openvpn) | awk '$11=="openvpn"{print $NF}')
proto=$(echo $path | awk -F '[_-]' '{print $(NF-1)}')
place=$(echo $path | awk -F '[_-]' '{print $(NF-2)}')

echo $place$proto
