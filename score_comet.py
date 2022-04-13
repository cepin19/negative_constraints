import sacrebleu
import sys,os
import sacrebleu

suffix=sys.argv[2]
filename_end="_{}".format(suffix)
max_refs=int(sys.argv[1])
#ngram counts

all_refs=[]
all_src=[]
all_trans=[]
with os.scandir("outputs/") as it:
    for transf in it:
        if not transf.name.endswith(filename_end): continue
        reff=os.path.join("testset/many-czech-references/",transf.name.replace(".src{}".format(filename_end),".refs"))
        src_f=os.path.join("outputs/",transf.name.replace(".src{}".format(filename_end),".src_sep"))
        with open(transf) as trans, open(reff) as refs, open(src_f) as s:
            refs =refs.readlines()
            src=s.read()
            trans = trans.read()
        if len(refs)>max_refs:
            refs=refs[:max_refs]
        all_trans.append(trans)
        all_src.append(src)
        all_refs.append(refs)


from comet import download_model, load_from_checkpoint

model_path = download_model("wmt20-comet-da")
model = load_from_checkpoint(model_path)
data=[]
sys_scores=[]
for i in range(max_refs):
    data=[]
#    print(i)
    for src,trans,refs in zip(all_src,all_trans,all_refs):
        
        try:
#        print(src)
            data.append(
        {
            "src": src,
            "mt": trans,
            "ref": refs[i]
        })
        except IndexError:
            data.append(
           {
            "src": src,
            "mt": trans,
            "ref": refs[-1]
        })

    
#    print(data)
    #try:
    seg_scores, sys_score = model.predict(data, batch_size=8, gpus=1)
        
    #except:
     #   sys_score=0.0
    sys.stderr.write(str(sys_score))
    sys_scores.append(sys_score)
#    print(sys_score)
#print(sum(sys_scores))
#print(len(sys_scores))
print(sum(sys_scores)/len(sys_scores))
