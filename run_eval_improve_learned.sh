export LD_LIBRARY_PATH=/app/tools
set -e
#echo  "prob, bleu1, bleu10, bleu1000, token_difference, bleu_against_nonconst" > results/improve_learned.csv
    bash test_constrained_improve_learned.sh single_word
   echo -n single_word, >> results/improve_learned.csv

    python3 score_multiple_suffix.py 1 translated_improve_learned_single_word | tr "\n" "," >> results/improve_learned.csv

    python3 score_multiple_suffix.py 10 translated_improve_learned_single_word | tr "\n" "," >> results/improve_learned.csv

    python3 score_multiple_suffix.py 1000 translated_improve_learned_single_word | tr "\n" "," >> results/improve_learned.csv

    python3 score_distance_suffix.py  improve_learned_single_word | tr "\n" "," >> results/improve_learned.csv

    bash score_notconstrained_constrained_suffix.sh translated_improve_learned_single_word | tr "\n" ","  >> results/improve_learned.csv
     CUDA_VISIBLE_DEVICES=1  python score_comet.py 20 translated_improve_learned_single_word    >> results/improve_learned.csv

    for i in {0..9}
do
	bash test_constrained_improve_learned.sh 0.$i
   echo -n 0.$i, >> results/improve_learned.csv
	python3 score_multiple_suffix.py 1 translated_improve_learned_0.$i | tr "\n" "," >> results/improve_learned.csv 
	
	python3 score_multiple_suffix.py 10 translated_improve_learned_0.$i | tr "\n" "," >> results/improve_learned.csv 

	python3 score_multiple_suffix.py 1000 translated_improve_learned_0.$i | tr "\n" "," >> results/improve_learned.csv 

	python3 score_distance_suffix.py translated_improve_learned_0.$i | tr "\n" "," >> results/improve_learned.csv 

	bash score_notconstrained_constrained_suffix.sh  translated_improve_learned_0.$i  | tr "\n" ",">> results/improve_learned.csv 
         CUDA_VISIBLE_DEVICES=1  python score_comet.py 20 translated_improve_learned_0.$i    >> results/improve_learned.csv

done
    bash test_constrained_improve_learned.sh 1.0
   echo -n 1.0, >> results/improve_learned.csv

    python3 score_multiple_suffix.py 1 translated_improve_learned_1.0 | tr "\n" "," >> results/improve_learned.csv

    python3 score_multiple_suffix.py 10 translated_improve_learned_1.0 | tr "\n" "," >> results/improve_learned.csv

    python3 score_multiple_suffix.py 1000 translated_improve_learned_1.0 | tr "\n" "," >> results/improve_learned.csv

    python3 score_distance_suffix.py  improve_learned_1.0 | tr "\n" "," >> results/improve_learned.csv

   bash score_notconstrained_constrained_suffix.sh translated_improve_learned_1.0 | tr "\n" ","  >> results/improve_learned.csv
     CUDA_VISIBLE_DEVICES=1  python score_comet.py 20 translated_improve_learned_1.0    >> results/improve_learned.csv

