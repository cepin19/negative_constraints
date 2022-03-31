import os
import nltk
import string
with os.scandir("outputs/") as it:
    for transf in it:
        if not transf.name.endswith("translated"): continue
        constraintsf="outputs/{}negative_constraints_para".format(transf.name.replace("translated",""))
        reff=transf.name

        with open(transf) as trans,  open(constraintsf,"w") as contraints:
            trans_tokens=set(nltk.word_tokenize(trans.read()))
            final_toks=set()
            for tok in trans_tokens:
                if not tok in string.punctuation:
                    final_toks.add(tok)
            #print(refs.readlines()[1:])
#            ref_tokens=set(nltk.word_tokenize(' '.join(refs.readlines()[1:]).replace('\n',' ')))
            contraints.write(" ".join(final_toks).replace("\n"," ")+'\n')
