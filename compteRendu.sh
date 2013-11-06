#!/bin/sh

sh scriptOthelloV2.sh rand lazy
echo "\t \tCHANGEMENT DE COULEUR !"
sh scriptOthelloV2.sh lazy rand
sh scriptOthelloV2.sh rand mr
echo "\t \tCHANGEMENT DE COULEUR !"
sh scriptOthelloV2.sh mr rand
sh scriptOthelloV2.sh rand pos
echo "\t \tCHANGEMENT DE COULEUR !"
sh scriptOthelloV2.sh pos rand
sh scriptOthelloV2.sh rand mm
echo "\t \tCHANGEMENT DE COULEUR !"
sh scriptOthelloV2.sh mm rand

# sh scriptOthelloV2.sh rand lazy
# sh scriptOthelloV2.sh rand mr
# sh scriptOthelloV2.sh rand pos
# sh scriptOthelloV2.sh rand mm

# sh scriptOthelloV2.sh lazy rand
# sh scriptOthelloV2.sh mr rand
# sh scriptOthelloV2.sh pos rand