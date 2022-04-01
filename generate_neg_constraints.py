import os
import nltk
with os.scandir("outputs/") as it:
    for transf in it:
        if not transf.name.endswith("translated"): continue
        constraintsf="outputs/{}negative_constraints_improve".format(transf.name.replace("translated",""))
        reff=os.path.join("data/",transf.name.replace("constrained.txt_translated","references.txt"))

        with open(transf) as trans, open(reff) as refs, open(constraintsf,"w") as contraints:
            trans_tokens=set(nltk.word_tokenize(trans.read()))
            #print(refs.readlines()[1:])
            ref_tokens=set(nltk.word_tokenize(' '.join(refs.readlines()[1:]).replace('\n',' ')))
            contraints.write(" ".join(trans_tokens-ref_tokens).replace("\n"," ")+'\n')
