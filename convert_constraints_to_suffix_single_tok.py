import json
import sys
import random
for line in sys.stdin:
    l=[]
    tmp=[]
    l=line.strip().split(" ")
    l=set([t.lower() for t in l])
    print(" <c> ".join(random.sample(l,1)))
