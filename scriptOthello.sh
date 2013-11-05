#!/bin/sh

swipl -q -s main.pl -t "playAll([ $1 , $2 ])." > temp.txt
tail -n 1  temp.txt >> result.txt
echo " " >> result.txt
rm temp.txt