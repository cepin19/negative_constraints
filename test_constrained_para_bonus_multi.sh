set -e
if [[ $# > 0 ]]
then
prob=$1
else
	prob=-1.0

fi
for f in data/*constrained.txt
do
  echo $f
  basef=`basename "$f"`
cat outputs/"$basef"_src_sep | ~/marian-constraints/build/marian-decoder  --no-spm-decode -v model/encs.spm model/encs.spm -m model/model_transformer_base_para_neg.npz.best-perplexity.npz   --constraint-bonus "$prob" --constraints-modify-scores --multi-token-constraint=true --negative-constraints outputs/"$basef"_negative_constraints_para.sp_newsp.yml  --cpu-threads 2 -n 1  > outputs/"$basef"_translated_para_bonus_multi_"$prob".sp  2> outputs/"$basef"_translated_para_bonus_multi_"$prob"_err
~/marian-constraints/build/spm_decode  --model model/encs.spm < outputs/"$basef"_translated_para_bonus_multi_"$prob".sp > outputs/"$basef"_translated_para_bonus_multi_"$prob"
done
