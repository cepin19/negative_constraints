import csv
import seaborn as sns
import matplotlib
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
data=pd.DataFrame()
ref_metric="COMET"
labels=["bonus SW","bonus tok","filter SW","filter tok","learned" ]
for i,file in enumerate(["improve_bonus_subword.csv","improve_bonus_trie.csv","improve_beam_filter_subword.csv", "improve_beam_filter_multi.csv", "improve_learned.csv"]):
    print(file)
    similarity_bleu = []
    performance_bleu = []
    with open("results/"+file, newline='') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        next(reader, None)
        for row in reader:
#            print(row)
                        
            performance_bleu.append(float(row[6]))      
    if data.empty:
        data=pd.DataFrame({"Labels":labels[i],ref_metric:[max(performance_bleu)]})

    else:
        #print ("else")
        data=data.append(pd.DataFrame({"Labels":labels[i].replace(".csv",""),ref_metric:[max(performance_bleu)]}),ignore_index=True)

#   print(pd.DataFrame({"Labels":file.replace("results_","").replace(".csv",""),"Similarity BLEU":similarity_bleu,ref_metric:performance_bleu}))
print(data[data.index.duplicated()])
print(data)
#exit()
sns.set_theme(style="whitegrid")

sns.set(font_scale = 1.1)

#sns.lineplot(data=pd.melt(data,['Similarity BLEU']))
sns.barplot(x='Labels', y=ref_metric,
            data=data).set(xlabel=None)
#sns.lineplot(data=pd.melt(data,['Labels']))
#ax2=plt.twinx()
#sns.lineplot(x='Labels', y='Similarity BLEU',
 #            data=data,color='b',label='Similarity BLEU',ax=ax2, marker='o')
plt.gca().set_ylim((0.350,0.51))
plt.legend([],[], frameon=False)
plt.savefig("constraints_new_bleu1.png",dpi=500)
#plt.legend()
matplotlib.pyplot.show()
