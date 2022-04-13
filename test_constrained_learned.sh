set -e
for f in outputs/*.src
do
  echo $f
  basef=`basename "$f"`
paste  outputs/"$basef"_sep outputs/"$basef"_negative_constraints.suffix_$1  | ~/marian-constraints/build/marian-decoder  --no-spm-decode -v model/encs.spm model/encs.spm -m model/model_transformer_base_para_neg.npz.best-perplexity.npz  --cpu-threads 2 -n 1  > outputs/"$basef"_translated_learned_score_"$1".sp  2> outputs/"$basef"_translated_learned_score_"$1".err
 ~/marian-constraints/build/spm_decode  --model model/encs.spm < outputs/"$basef"_translated_learned_score_"$1".sp > outputs/"$basef"_translated_learned_score_$1
done
