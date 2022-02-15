#!/usr/bin/bash

scp -i ~/.ssh/atis $1  scp://s_kriso@i08fs1.ira.uka.de/$1
ssh -i ~/.ssh/atis s_kriso@i08fs1.ira.uka.de "lpr -P pool-sw2 -o sides=two-sided-long-edge $1 && rm $1"
