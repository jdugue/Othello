#!/bin/sh

for i in `seq 1 50`;
do
	swipl -q -s main.pl -t "playAll([ $1 , $2 ])." > temp.txt
	tail -n 1  temp.txt >> temp2.txt
	echo " " >> temp2.txt
	sed -e 's/Red gagne !/Red/g' -e 's/Green gagne !/Green/g' -e 's/Egalité !/Egalite/g' temp2.txt >> result.txt
	rm temp.txt temp2.txt
done


