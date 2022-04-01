export LD_LIBRARY_PATH=/app/tools
set -e
#echo  "prob, bleu1, bleu10, bleu1000, token_difference, bleu_against_nonconst" > results/improve_bonus_trie.csv
for i in {0..3}
do
	for dec in {0..9}
	do
	prob="-$i.$dec"	

	bash test_constrained_improve_bonus_trie.sh $prob
   echo -n $prob, >> results/improve_bonus_trie.csv
	python3 score_multiple_suffix.py 1 translated_improve_bonus_trie_$prob | tr "\n" "," >> results/improve_bonus_trie.csv 
	
	python3 score_multiple_suffix.py 10 translated_improve_bonus_trie_$prob | tr "\n" "," >> results/improve_bonus_trie.csv 

	python3 score_multiple_suffix.py 1000 translated_improve_bonus_trie_$prob | tr "\n" "," >> results/improve_bonus_trie.csv 

	python3 score_distance_suffix.py improve_bonus_trie_$prob | tr "\n" "," >> results/improve_bonus_trie.csv 

	bash score_notconstrained_constrained_suffix.sh  translated_improve_bonus_trie_$prob >> results/improve_bonus_trie.csv 
done
done

