#!/bin/sh

red=0
green=0
eg=0

for i in `seq 1 50`;
do
	swipl -q -s main.pl -t "playAll([ $1 , $2 ])." > temp.txt
	tail -n 1  temp.txt >> temp2.txt
	#echo " " >> temp2.txt
	sed -e 's/Red gagne !/Red /g' -e 's/Green gagne !/Green /g' -e 's/Egalité !/Egalite/g' temp2.txt > temp.txt
	temp=`cat temp.txt`
	rm temp.txt temp2.txt


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
if $red > $green
then
	vainqueur=$1
	pourcent=$(($red/50*100))
else
	vainqueur=$2
	pourcent=$(($green/50*100))
fi

echo "red "$red
echo "green "$green
echo "l'IA $vainqueur est la plus forte, elle a gagné dans $pourcent pourcent des parties"