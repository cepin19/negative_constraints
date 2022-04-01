import json
import sys
import random
for line in sys.stdin:
    l=[]
    tmp=[]
    l=line.strip().split(" ")
    print(" <c> ".join(random.sample(l,1)))
