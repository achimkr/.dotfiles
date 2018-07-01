#!/bin/bash

df --total | grep -E "total" | awk '{ print $5 }' 
