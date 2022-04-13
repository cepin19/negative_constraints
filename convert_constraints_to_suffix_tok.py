import json
import sys
import random
if len(sys.argv)>1:
    ratio=float(sys.argv[1])
else:
    ratio=1.0
for line in sys.stdin:
    l=[]
    tmp=[]
    l=line.strip().split(" ")
    l=set([t.lower() for t in l])
    print(" <c> ".join(random.sample(l,round(ratio*len(l)))))
