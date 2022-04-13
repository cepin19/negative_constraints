import sacrebleu
import sys,os
import sacrebleu

suffix=sys.argv[2]
filename_end="_{}".format(suffix)
max_refs=int(sys.argv[1])
#ngram counts
correct_counts=[0,0,0,0]
total_counts=[0,0,0,0]
sys_len=0
ref_len=0
with os.scandir("outputs/") as it:
    for transf in it:
        if not transf.name.endswith(filename_end): continue
        reff=os.path.join("testset/many-czech-references/",transf.name.replace(".src{}".format(filename_end),".refs"))
        with open(transf) as trans, open(reff) as refs:
            refs = [ [line] for line in refs.readlines()]
            trans = [trans.read()]
        if len(refs)>max_refs:
            refs=refs[:max_refs]
        #print(refs)
#        print(trans)
        bleu = sacrebleu.corpus_bleu(trans, refs)
        c=bleu.counts
        #print(dir(bleu))
        tc=bleu.totals
        sys_len+=bleu.sys_len
        ref_len+=bleu.ref_len

        for i,count in enumerate(c):
            correct_counts[i]+=count
        for i,count in enumerate(tc):
            total_counts[i]+=count

    print(sacrebleu.BLEU.compute_bleu(correct_counts,total_counts,sys_len,ref_len).score)
