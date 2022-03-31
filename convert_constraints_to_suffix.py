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
    for subword in line.strip().split(" "):
        if subword.startswith("▁"):
            if tmp:
                l.append(" ".join(tmp))
            tmp=[]
        tmp.append(subword)
    if tmp:
        l.append(" ".join(tmp))
    print(" <c> ".join(random.sample(l,round(ratio*len(l)))))
