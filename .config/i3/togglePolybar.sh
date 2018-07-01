#!/bin/bash

pid=$(pidof polybar)
[[ $? -eq 0 ]] && polybar-msg cmd toggle 
