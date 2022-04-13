IFS=$(echo -en "\n\b")
marian_path=~/marian-constraints/build
for f in testset/many-czech-references/*.src
do
	echo $f
	basef=`basename "$f"`
	cp "$f"  outputs/"$basef"
	sed 's/$/ <sep> /g' outputs/"$basef" > outputs/"$basef"_sep
	"$marian_path"/spm_encode  --model model/encs.spm < outputs/"$basef"_sep > outputs/"$basef"_sep.sp
	cat outputs/"$basef"_sep | "$marian_path"/marian-decoder -v model/encs.spm model/encs.spm --no-spm-decode -m model/model_transformer_base_para_neg.npz.best-perplexity.npz -n 1 > outputs/"$basef"_baseline_translated.sp
	"$marian_path"/spm_decode  --model model/encs.spm < outputs/"$basef"_baseline_translated.sp > outputs/"$basef"_baseline_translated
done
