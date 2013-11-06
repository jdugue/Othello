/* Algo minimax d'apres le livre The Art Of Prolog */
/*
evaluate_and_choose([Move|Moves], Position,D ,MaxMin, Record, Best) :-
	move(Move, Position, Position1), 
	minimax(D, Position1, MaxMin, MoveX, Value), 
	update(Move , Value , Record, Record1),
	evaluate_and_choose(Moves, Position, D, MaxMin, Record1, Best).
	
evaluate_and_choose([], Position, D, MaxMin, Record, Record).

minimax (0, Position, MaxMin, Move, Value) :-
	value(Position, V),
	Value is  V*MaxMin.

minimax(D, Position, MaxMin, Move, Value) :-
	D>0, 
	findall(M, move(Position, M), Moves),
	D1 is D - 1, 
	MinMax is -MaxMin, 
	evaluate_and_choose(Moves, Position, D1, MinMax, (nil,-1000), (Move,Value)).

update(Move, Value, (Move1,Value1), (Move,Value1)) :-
	Value <= Value1.	

update(Move, Value, (Move1,Value1), (Move,Value)) :-
	Value > Value1.	
*/	
	
%Adaptation
choix_move_MM([], _,_, 3, _, (MRecord,VRecord), (MRecord,VRecord)).
choix_move_MM([], _,_, _, _, (_,VRecord), (_,VRecord)).
choix_move_MM([Move|[]], _,_,_ ,_, _, (Move,_)).
choix_move_MM([Move|Moves], Couleur,Plateau,Profondeur ,MaxMin, Record, Choix) :-
	cases_a_retourner(Move,Plateau,Couleur,ARetourner),
	retourne_all(ARetourner,Plateau,PlateauTemp),
	ajoutePion(Move,Couleur,PlateauTemp,NewPlateau),
	minimax(Couleur,Profondeur, NewPlateau, MaxMin, Move, Value), 
	update(Move , Value , Record, NewRecord),
	choix_move_MM(Moves,Couleur, Plateau, Profondeur, MaxMin, NewRecord, Choix).

minimax(Couleur,0, NewPlateau, MaxMin, Move, Value) :-
	valeur_case(Move,V),
	Value is  V*MaxMin.

minimax(Couleur,Profondeur, Plateau, MaxMin, Move, Value) :-
	Profondeur>0, 
	couleur_adversaire(Couleur,Adv),
	coups_legaux(Adv, Plateau, Coups),
	NewProfondeur is Profondeur - 1, 
	MinMax is -MaxMin, 
	choix_move_MM(Coups, Adv,Plateau, NewProfondeur, MinMax, (nil,-1000), (Move,Value)).

update(_, Value, (Move1,Value1), (Move1,Value1)) :-
	Value =< Value1.	

update(Move, Value, (_,Value1), (Move,Value)) :-
	Value > Value1.	
