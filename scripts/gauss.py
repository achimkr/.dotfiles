#!/bin/python
#This python script is supposed to generate the matrix for the blur kernel in compton.
#First argument is the radius of the kernel
#Second argument is the parameter of the gauss function e^(-a * x^2)

import sys
import re

E = 2.71828

def evalGauss(pos, sigma):
    return E**(-sigma * (pos**2))    

if len(sys.argv) < 3:
    print("Insufficient number of arguments")
    sys.exit() 

regInt = re.compile("\d*")
regFloat = re.compile("\d*\.{0,1}\d*")

error = False 
if not regInt.match(sys.argv[1]): 
    print("radius (first argument) has to be an integer")
    error = True 

if not regFloat.match(sys.argv[2]):
    print("sigma has to a floating point number")
    error = True 

if error: sys.exit()

rad = int(sys.argv[1]) 
sigma = float(sys.argv[2]) 

if rad < 0: 
    print("Radius has to be >0")
    error = True

if sigma <= 0:
    print("Sigma has to be >0")
    error = True

if error: sys.exit()

#print("{}, {}".format(rad, sigma))

#horizontal
print("{},1".format(2 * rad + 1), end='')

for i in range(-rad, rad + 1):
    if i == 0:  continue
    value = evalGauss(i, sigma)   
    print(",{:0.5f}".format(value), end='')
     
#Vertical
print(";1,{}".format(2 * rad + 1), end='')
for i in range(-rad, rad + 1):
    if i == 0:  continue
    value = evalGauss(i, sigma)   
    print(",{:0.5f}".format(value), end='')

print()
