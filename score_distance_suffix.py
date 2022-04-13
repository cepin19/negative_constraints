import os,sys
from nltk.tokenize import word_tokenize
diff_tokens=0
suffix=sys.argv[1]
with os.scandir("outputs/") as it:
    for transf in it:
        if not transf.name.endswith("baseline_translated"): continue
        constrainedf="outputs/{}_{}".format(transf.name.replace("_baseline_translated",""),suffix)
        with open(transf) as trans, open(constrainedf) as constrained:
            diff_tokens+=len(set(word_tokenize(trans.read())).symmetric_difference(set(word_tokenize(constrained.read()))))
#print ("diff tokens in total: {}".format(diff_tokens))
print(diff_tokens)
