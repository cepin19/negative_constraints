IFS=$(echo -en "\n\b")
for f in data/*constrained.txt
do
  echo $f
  basef=`basename "$f"`
   head -n 1 "$f" | cut -f1  > outputs/"$basef"_src
   sed 's/$/ <sep> /g' outputs/"$basef"_src > outputs/"$basef"_src_sep
~/marian-constraints/build/spm_encode  --model model/encs.spm < outputs/"$basef"_src_sep > outputs/"$basef"_src_sep.sp
cat outputs/"$basef"_src_sep | ~/marian-constraints/build/marian-decoder -v model/encs.spm model/encs.spm --no-spm-decode -m model/model_transformer_base_para_neg.npz.best-perplexity.npz -n 1 > outputs/"$basef"_translated.sp
~/marian-constraints/build/spm_decode  --model model/encs.spm < outputs/"$basef"_translated.sp > outputs/"$basef"_translated
done
