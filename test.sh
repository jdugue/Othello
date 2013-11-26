swipl -q -s main.pl -t "playAll([ lazy , rand ])." > temp.txt
tail -n 1  temp.txt > temp2.txt
sed -e 's/Red gagne !/Red /g' -e 's/Green gagne !/Green /g' -e 's/Egalité !/Egalite/g' temp2.txt > temp3.txt