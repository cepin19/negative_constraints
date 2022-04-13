import sys
import mosestokenizer
detok=mosestokenizer.MosesDetokenizer('cs')
ref_dict={}
prev_i=-1
with open("many-czech-references/many-references-datafile") as refs, open("many-czech-references/en.txt") as src:
    for line in refs:
        sentence_i=line.split('\t')[0]
        if sentence_i!=prev_i:
            prev_i=sentence_i
            print(sentence_i)
        detok_line=detok(line.split('\t')[3].strip().split(' '))
        if sentence_i in ref_dict:
            ref_dict[sentence_i].append(detok_line)
        else: 
            ref_dict[sentence_i]=[detok_line]
    for line in src:
        sentence_i=line.split('\t')[0]
        with open("many-czech-references/{}.src".format(sentence_i),'w') as sf, open("many-czech-references/{}.refs".format(sentence_i),'w') as reff:
            sf.write(line.split('\t')[1])
            reff.write('\n'.join(ref_dict[sentence_i]))
       
