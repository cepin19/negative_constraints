python3 generate_neg_constraints_para.py
for f in outputs/*negative_constraints_para
do 
	echo $f
	~/marian-constraints/build/spm_encode --model ../neg/corp/encs.spm < $f > $f.sp_newsp
	cat $f.sp_newsp | python3  convert_constraints_to_yaml.py > $f.sp_newsp.yml
	cat $f.sp_newsp | python3 convert_constraints_to_yaml_no_multi.py > $f.sp_newsp.nomulti.yml
    cat $f.sp_newsp | python3  convert_constraints_to_suffix.py > $f.sp_newsp.suffix
     for i in {0..9}
     do
     cat $f | python3  convert_constraints_to_suffix_tok.py 0.$i > $f.suffix_0.$i
     done
     cat $f | python3  convert_constraints_to_suffix_tok.py 1.0 > $f.suffix_1.0

    done
