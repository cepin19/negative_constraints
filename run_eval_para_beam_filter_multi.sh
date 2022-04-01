export LD_LIBRARY_PATH=/app/tools
set -e
#echo  "prob, bleu1, bleu10, bleu1000, token_difference, bleu_against_nonconst" > results/para_beam_filter_multi.csv
for i in {0..3}
do
	for dec in {0..9}
	do
	prob="-$i.$dec"	

	bash test_constrained_para_beam_filter_multi.sh $prob
   echo -n $prob, >> results/para_beam_filter_multi.csv
	python3 score_multiple_suffix.py 1 translated_para_beam_filter_multi_$prob | tr "\n" "," >> results/para_beam_filter_multi.csv 
	
	python3 score_multiple_suffix.py 10 translated_para_beam_filter_multi_$prob | tr "\n" "," >> results/para_beam_filter_multi.csv 

	python3 score_multiple_suffix.py 1000 translated_para_beam_filter_multi_$prob | tr "\n" "," >> results/para_beam_filter_multi.csv 

	python3 score_distance_suffix.py para_beam_filter_multi_$prob | tr "\n" "," >> results/para_beam_filter_multi.csv 

	bash score_notconstrained_constrained_suffix.sh  translated_para_beam_filter_multi_$prob >> results/para_beam_filter_multi.csv 
done
done

