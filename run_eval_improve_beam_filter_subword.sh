export LD_LIBRARY_PATH=/app/tools
set -e
#echo  "prob, bleu1, bleu10, bleu1000, token_difference, bleu_against_nonconst" > results/improve_beam_filter_subword.csv
for i in {0..3}
do
	for dec in {0..9}
	do
	prob="-$i.$dec"	

	bash test_constrained_improve_beam_filter_subword.sh $prob
   echo -n $prob, >> results/improve_beam_filter_subword.csv
	python3 score_multiple_suffix.py 1 translated_improve_beam_filter_subword_$prob | tr "\n" "," >> results/improve_beam_filter_subword.csv 
	
	python3 score_multiple_suffix.py 10 translated_improve_beam_filter_subword_$prob | tr "\n" "," >> results/improve_beam_filter_subword.csv 

	python3 score_multiple_suffix.py 1000 translated_improve_beam_filter_subword_$prob | tr "\n" "," >> results/improve_beam_filter_subword.csv 

	python3 score_distance_suffix.py improve_beam_filter_subword_$prob | tr "\n" "," >> results/improve_beam_filter_subword.csv 

	bash score_notconstrained_constrained_suffix.sh  translated_improve_beam_filter_subword_$prob >> results/improve_beam_filter_subword.csv 
done
done

