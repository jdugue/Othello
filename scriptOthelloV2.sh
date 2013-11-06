#!/bin/sh

nbtime=20
red=0
green=0
eq=0
pourcent=0

for i in `seq 1 $nbtime`;
do
	swipl -q -s main.pl -t "playAll([ $1 , $2 ])." > temp.txt
	tail -n 1  temp.txt > temp2.txt
	#echo " " >> temp2.txt
	sed -e 's/Red gagne !/Red /g' -e 's/Green gagne !/Green /g' -e 's/Egalité !/Egalite/g' temp2.txt > temp.txt
	temp=`cat temp.txt`
	rm temp.txt temp2.txt

	# echo "temp "$temp

	if [ $temp = "Red" ]
	then
		red=$(($red + 1))
		# echo "red"
	elif [ $temp = "Green" ]
	then
		# echo "gr"
		green=$(($green + 1))
	elif [ $temp = "Egalite" ]
	then
		# echo "eq"
		eq=$(($eq + 1))
	fi

	# echo $temp
	# echo "red "$red
	# echo "green "$green
	# echo "eq "$eq
	# echo "--------------------------------"
done

#A VERIFIER AVEC MAEL
if [ "$red" -gt "$green" ]
then
	# echo "1"
	pourcent=$(($red * 100 / $nbtime))
	vainqueur=$2
	couleur="ROUGE"
	# echo "pourcent "$pourcent
elif [ "$green" -gt "$red" ]
then
	# echo "2"
	pourcent=$(($green * 100 / $nbtime))
	vainqueur=$1
	couleur="VERT"
	# echo "pourcent "$pourcent
fi

# echo "pourcent "$pourcent
# echo "red "$red
# echo "green "$green
# echo "eq "$eq
echo "\t \t------------------------------------------------------"
echo "\t \t|  Match de l'IA $1 (VERT) contre l'IA $2 (ROUGE)|"
echo "\t \t------------------------------------------------------"
echo "\n"
echo "\t \tl'IA $vainqueur gagne dans $pourcent % des parties quand elle joue $couleur"
echo "\n"