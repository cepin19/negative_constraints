export LD_LIBRARY_PATH=/app/tools
set -e
#echo  "prob, bleu1, bleu10, bleu1000, token_difference, bleu_against_nonconst" > results/para_learned.csv
    for i in {0..9}
do
	bash test_constrained_para_learned.sh 0.$i
   echo -n 0.$i, >> results/para_learned.csv
	python3 score_multiple_suffix.py 1 translated_para_learned_0.$i | tr "\n" "," >> results/para_learned.csv 
	
	python3 score_multiple_suffix.py 10 translated_para_learned_0.$i | tr "\n" "," >> results/para_learned.csv 

	python3 score_multiple_suffix.py 1000 translated_para_learned_0.$i | tr "\n" "," >> results/para_learned.csv 

	python3 score_distance_suffix.py para_learned_0.$i | tr "\n" "," >> results/para_learned.csv 

	bash score_notconstrained_constrained_suffix.sh  translated_para_learned_0.$i >> results/para_learned.csv 
done
    bash test_constrained_para_learned.sh 1.0
   echo -n 1.0, >> results/para_learned.csv

    python3 score_multiple_suffix.py 1 translated_para_learned_1.0 | tr "\n" "," >> results/para_learned.csv

    python3 score_multiple_suffix.py 10 translated_para_learned_1.0 | tr "\n" "," >> results/para_learned.csv

    python3 score_multiple_suffix.py 1000 translated_para_learned_1.0 | tr "\n" "," >> results/para_learned.csv

    python3 score_distance_suffix.py  para_learned_1.0 | tr "\n" "," >> results/para_learned.csv

    bash score_notconstrained_constrained_suffix.sh translated_para_learned_1.0  >> results/para_learned.csv

