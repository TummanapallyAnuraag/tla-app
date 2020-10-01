#!/bin/bash

DATABASE="database.txt"
INPUT="input.txt"
mkdir tmpdir

if [ -f "$1" ]; then
	INPUT=$1
fi

grep -o '[A-Z]\{3\}[\ (),]\{0,2\}\(\w\+\s\)\(\w\+\s\)\(\w\+\)' ${INPUT} > tmpdir/raw.txt

#cat tmpdir/raw.txt
cat tmpdir/raw.txt | cut -d' ' -f2 > tmpdir/col1.txt
cat tmpdir/raw.txt | cut -d' ' -f3 > tmpdir/col2.txt
cat tmpdir/raw.txt | cut -d' ' -f4 > tmpdir/col3.txt
cat tmpdir/raw.txt | cut -d' ' -f1 > tmpdir/tmp_col4.txt

grep -o '[A-Z]\{3\}' tmpdir/tmp_col4.txt > tmpdir/acr.txt

paste -d',' tmpdir/acr.txt tmpdir/col1.txt tmpdir/col2.txt tmpdir/col3.txt > tmpdir/data.csv
#cat tmpdir/data.csv

touch tmpdir/database.txt

input="tmpdir/data.csv"
while IFS= read -r line
do
	acr=`echo ${line,,} | cut -d',' -f1`
	w1=`echo ${line,,} | cut -d',' -f2`
	w2=`echo ${line,,} | cut -d',' -f3`
	w3=`echo ${line,,} | cut -d',' -f4`
	#echo ${line,,}

	if [ ${#w3} -gt 0 ]; then
		if [ ${acr:0:1} == ${w1:0:1} -a ${acr:1:1} == ${w2:0:1} -a ${acr:2:1} == ${w3:0:1} ]; then
			echo $acr:$w1 $w2 $w3 >> tmpdir/database.txt
		fi
	fi
done < "$input"

cat tmpdir/database.txt >> ${DATABASE}
cat ${DATABASE} > tmpdir/database.txt
cat tmpdir/database.txt | sort | uniq > ${DATABASE}

rm -rf tmpdir
