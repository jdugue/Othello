choix_move_AB([], _,_, 1, _, (MRecord,VRecord), (MRecord,VRecord)).
choix_move_AB([], _,_, _, _, (_,VRecord), (_,VRecord)).
choix_move_AB([Move|[]], _,_,_ ,_, _, (Move,_)).
choix_move_AB([Move|Moves], Couleur,Plateau,Profondeur ,Alpha,Beta, Record, Choix) :-
	cases_a_retourner(Move,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Move,Couleur,PlateauTemp,NewPlateau),
	alpha_beta(Couleur,Profondeur, NewPlateau, Alpha,Beta, Move, Value), 
	cutoff().

alpha_beta(Couleur,0, NewPlateau, Alpha,Beta, Move, Value) :-
	valeur_case(Move,Value).

alpha_beta(Couleur,Profondeur, Plateau, Alpha,Beta, Move, Value) :-
	Profondeur>0, 
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, Coups),
	NewProfondeur is Profondeur - 1, 
	Alpha1 is -Beta,
	Beta1 is -Alpha,
	choix_move_AB(Coups, Adv,Plateau, NewProfondeur, Alpha1,Beta1, (nil,-1000), (Move,Value)).

