#This python scripts read the battery charge from /sys/class/power_supply/BATx/uevent to determine the current percentage.
#It is currently hardcoded to two batteries but can be to more rather easily

from pathlib import Path
import sys

def readBatFile(i):
	path = '/sys/class/power_supply/BAT{}/uevent'.format(i)
	if not Path(path).exists():
		print("BAT{} doesnt exist".format(i))
		sys.exit()

	f = open(path)
	s = f.read()
	f.close()
	s = s.split()
		
	d = dict()
	for i in range(0, len(s)):
		t = s[i].split('=')
		if len(t) >= 2:
			d[t[0]] = t[1]
	return d

def readACFile():
	path = '/sys/class/power_supply/AC/online'
	if not Path(path).exists():
		print("AC doesnt exists, this scripts will never show charging.")
		return 0
	f = open(path)
	return int(f.read())

b0 = readBatFile(0)
b1 = readBatFile(1)

#print(b0)
#print(b1)

fullStr = 'POWER_SUPPLY_ENERGY_FULL'
full0 = int(b0[fullStr])
full1 = int(b1[fullStr])

currStr = 'POWER_SUPPLY_ENERGY_NOW'
curr0 = int(b0[currStr])
curr1 = int(b1[currStr])

perc0 = curr0 / full0
perc1 = curr1 / full1
perc = (curr0 + curr1) / (full0 + full1)

sym = ""
if readACFile() == 1:
	sym = ""
elif perc >= 3/4:
	sym = ""
elif perc >= 2/4:
	sym = ""
elif perc >= 1/4:
	sym = ""
elif perc >= 1/8:
	sym = ""
else:
	sym = ""

print("{}{:.0f}|{:.0f}%".format(sym, perc0 * 100, perc1 * 100))
