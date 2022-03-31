echo -n > results/translations_$1
echo -n > results/translations_not_constrained_$1

#echo -n > references_head
#echo -n > references_all
for out in outputs/*_$1
do
  cat $out >> results/translations_$1
  done
 # IFS=$(echo -en "\n\b")
 for ref in outputs/*_translated
  do
  cat $ref >> results/translations_not_constrained_$1
  done
cat results/translations_$1 | sacrebleu -b results/translations_not_constrained_$1 
