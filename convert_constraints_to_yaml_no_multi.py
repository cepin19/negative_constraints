import json
import sys
for line in sys.stdin:
    l=[]
    tmp=[]
    for subword in line.strip().split(" "):
        l.append([subword])
    print(json.dumps(l))
