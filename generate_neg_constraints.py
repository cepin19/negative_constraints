import os
import nltk
with os.scandir("outputs/") as it:
    for transf in it:
        if not transf.name.endswith("_baseline_translated"): continue
        constraintsf="outputs/{}negative_constraints_improve".format(transf.name.replace("baseline_translated",""))
        reff=os.path.join("testset/many-czech-references",transf.name.replace(".src_baseline_translated",".refs"))

        with open(transf) as trans, open(reff) as refs, open(constraintsf,"w") as contraints:
            trans_tokens=set(nltk.word_tokenize(trans.read()))
            #print(refs.readlines()[1:])
            ref_tokens=set(tok for tok in nltk.word_tokenize(' '.join(refs.readlines()[1:]).replace('\n',' ')))
            constraints=trans_tokens-ref_tokens
  #          constraints_cap=set(c.capitalize() for c in constraints)
 #           constraints_lower=set(c.lower() for c in constraints)

#            final_constraints=constraints.union(constraints_cap).union(constraints_lower) # we want capitalized versions for sentence starts
            final_constraints=constraints
            contraints.write(" ".join(final_constraints).replace("\n"," ")+'\n')
