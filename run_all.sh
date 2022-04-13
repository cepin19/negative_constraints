#bash run_eval_para_beam_filter_trie.sh > run_eval_para_beam_filter_trie.log  2>&1  &
bash run_eval_para_bonus_trie.sh >run_eval_para_bonus_trie.log  2>&1  &
bash run_eval_para_beam_filter_multi.sh > run_eval_para_beam_filter_multi.log  2>&1  &
#bash run_eval_para_bonus_multi.sh > run_eval_para_bonus_multi.log  2>&1  &
bash run_eval_para_learned.sh > run_eval_para_learned.log  2>&1  &
bash run_eval_para_beam_filter_subword.sh  > run_eval_para_beam_filter_subword.log  2>&1  &
wait
bash run_eval_para_bonus_subword.sh > run_eval_para_bonus_subword.log  2>&1  &
bash run_eval_improve_beam_filter_multi.sh > run_eval_improve_beam_filter_multi.log 2>&1 &
#bash run_eval_improve_bonus_multi.sh    > run_eval_improve_bonus_multi.log 2>&1  &
bash run_eval_improve_learned.sh > run_eval_improve_learned.log   2>&1  &
wait
#bash run_eval_improve_beam_filter_trie.sh > run_eval_improve_beam_filter_trie.log  2>&1  &
bash run_eval_improve_beam_filter_subword.sh > run_eval_improve_beam_filter_subword.log   2>&1  &
bash run_eval_improve_bonus_subword.sh > run_eval_improve_bonus_subword.log  2>&1  &
bash run_eval_improve_bonus_trie.sh > run_eval_improve_bonus_trie.log   2>&1  &
