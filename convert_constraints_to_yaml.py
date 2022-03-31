import json
import sys
for line in sys.stdin:
    l=[]
    tmp=[]
    for subword in line.strip().split(" "):
        if subword.startswith("▁"):
            if tmp:
                l.append(tmp)
            tmp=[]
        tmp.append(subword)
    if tmp:
        l.append(tmp)
    print(json.dumps(l))