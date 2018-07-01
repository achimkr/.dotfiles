#!/bin/bash

getPrimary(){
	xrandr | grep "primary" | awk '{print $1}'
}
